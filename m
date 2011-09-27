From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 3/5] [media]: OMAP_VOUT: Fix VSYNC IRQ handling in
 omap_vout_isr
Date: Tue, 27 Sep 2011 12:09:01 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404ECA548CF@dbde02.ent.ti.com>
References: <1316167233-1437-1-git-send-email-archit@ti.com>
 <1316167233-1437-4-git-send-email-archit@ti.com>
 <19F8576C6E063C45BE387C64729E739404EC941F86@dbde02.ent.ti.com>
 <4E7AD29C.4070804@ti.com>
 <19F8576C6E063C45BE387C64729E739404ECA54614@dbde02.ent.ti.com>
 <CAB2ybb8ab9jSFB1J_CQfObB11QcdtQ=6Kf9zdbg0v5Jckf09sw@mail.gmail.com>
 <CAB2ybb-rZgDvS9Bo6AJF=KVd0irXHa0S0LrPJ=SWr0daJ6gX1w@mail.gmail.com>
 <CAB2ybb8UGC=HK7jpYaDym8Y8iy=omwWiXrV7cdRw3k20e0NiZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <CAB2ybb8UGC=HK7jpYaDym8Y8iy=omwWiXrV7cdRw3k20e0NiZw@mail.gmail.com>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: "Semwal, Sumit" <sumit.semwal@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Semwal, Sumit
> Sent: Tuesday, September 27, 2011 11:12 AM
> To: Hiremath, Vaibhav
> Cc: Taneja, Archit; Valkeinen, Tomi; linux-omap@vger.kernel.org; linu=
x-
> media@vger.kernel.org
> Subject: Re: [PATCH 3/5] [media]: OMAP_VOUT: Fix VSYNC IRQ handling i=
n
> omap_vout_isr
>=20
> Hi Vaibhav,
> >>
> >> On Mon, Sep 26, 2011 at 3:49 PM, Hiremath, Vaibhav <hvaibhav@ti.co=
m>
> wrote:
> >>>
> >>> > -----Original Message-----
> >>> > From: Taneja, Archit
> >>> > Sent: Thursday, September 22, 2011 11:46 AM
> >>> > To: Hiremath, Vaibhav
> >>> > Cc: Valkeinen, Tomi; linux-omap@vger.kernel.org; Semwal, Sumit;
> linux-
> >>> > media@vger.kernel.org
> >>> > Subject: Re: [PATCH 3/5] [media]: OMAP_VOUT: Fix VSYNC IRQ hand=
ling
> in
> >>> > omap_vout_isr
> >>> >
> >>> > Hi,
> >
> > =A0=A0<snip>
> >>>
> >>> > >> - =A0 =A0 =A0 =A0 =A0if (!(irqstatus& =A0(DISPC_IRQ_VSYNC |
> DISPC_IRQ_VSYNC2)))
> >>> > >> + =A0 =A0 =A0 =A0 =A0if (mgr_id =3D=3D OMAP_DSS_CHANNEL_LCD)
> >>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq =3D DISPC_IRQ_VSYNC=
;
> >>> > >> + =A0 =A0 =A0 =A0 =A0else if (mgr_id =3D=3D OMAP_DSS_CHANNEL=
_LCD2)
> >>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq =3D DISPC_IRQ_VSYNC=
2;
> >>> > >> + =A0 =A0 =A0 =A0 =A0else
> >>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto vout_isr_err;
> >>> > >> +
> >>> > >> + =A0 =A0 =A0 =A0 =A0if (!(irqstatus& =A0irq))
> >>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto vout_isr_err;
> >>> > >> =A0 =A0 =A0 =A0 =A0 =A0break;
> >>> > > I understand what this patch meant for, but I am more curious=
 to
> know
> >>> > > What is value addition of this patch?
> >>> > >
> >>> > > if (!(irqstatus& =A0(DISPC_IRQ_VSYNC | DISPC_IRQ_VSYNC2)))
> >>> > >
> >>> > > Vs
> >>> > >
> >>> > > if (mgr_id =3D=3D OMAP_DSS_CHANNEL_LCD)
> >>> > > =A0 =A0 irq =3D DISPC_IRQ_VSYNC;
> >>> > > else if (mgr_id =3D=3D OMAP_DSS_CHANNEL_LCD2)
> >>> > > =A0 =A0 irq =3D DISPC_IRQ_VSYNC2;
> >>> > >
> >>> > > Isn't this same, because we are not doing anything separate a=
nd
> special
> >>> > > for VSYNC and VSYNC2?
> >>> >
> >>> > Consider a use case where the primary LCD panel(connected to LC=
D
> >>> > manager) is configured at a 60 Hz refresh rate, and the seconda=
ry
> >>> > panel(connected to LCD2) refreshes at 30 Hz. Let the overlay
> >>> > configuration be something like this:
> >>> >
> >>> > /dev/video1----->overlay1----->LCD manager----->Primary panel(6=
0 Hz)
> >>> >
> >>> >
> >>> > /dev/video2----->overlay2----->LCD2 manager----->Secondary Pane=
l(30
> Hz)
> >>> >
> >>> >
> >>> > Now if we are doing streaming on both video1 and video2, since =
we
> deque
> >>> > on either VSYNC or VSYNC2, video2 buffers will deque faster tha=
n the
> >>> > panels refresh, which is incorrect. So for video2, we should on=
ly
> deque
> >>> > when we get a VSYNC2 interrupt. Thats why there is a need to
> correlate
> >>> > the interrupt and the overlay manager.
> >>> >
> >>>
> >>> Archit,
> >>>
> >>> I think I am still not understood or convinced with your descript=
ion
> above,
> >>>
> >>> The code snippet which we are referring here, does check whether =
the
> >>> interrupt is either VSYNC or VSYNC2, else fall back to "vout_isr_=
err".
> >
> >
> I am not quite sure I understand what is the confusing part here -
> below is my understanding; please correct me if you think otherwise.
> As I understand, this patch creates a (missing) correlation between a
> manager and the corresponding ISR. The earlier code would accept a
> VSYNC2 for LCD1 manager, which is not the correct thing to do.
> That is why the check of 'if ((mgr=3D=3DLCD) && (IRQ=3D=3DVSYNC))' ki=
nd of
> thing is needed;=A0Which part of this do you think the above patch
> doesn't do? Or, do you think it is not needed / done correctly?
Sumit,

Please look at the patch carefully, it does exactly same thing. I under=
stand the use-case what Archit explained in the last email but in this =
patch context, the use-case change anything here in this patch.=20

Can you review it carefully again?

Thanks,
Vaibhav
> >>>
> >>> For me both are doing same thing, the original code is optimized =
way
> of implementation. Can you please review it again?
> >>>
> >>> Thanks,
> >>> Vaibhav
> >
> >
> Thanks and best regards,
> ~Sumit.
> >>>
> >>> <snip>
