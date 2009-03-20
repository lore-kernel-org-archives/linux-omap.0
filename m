From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value
Date: Fri, 20 Mar 2009 15:52:45 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A925775D@dbde02.ent.ti.com>
References: <94a0d4530903200317h403210f2u622b837be1e5d9a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33111 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018AbZCTKXw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 06:23:52 -0400
In-Reply-To: <94a0d4530903200317h403210f2u622b837be1e5d9a8@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Varide, Nischal" <nischal.varide@ti.com>

=46elipe,
=20

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]=20
> Sent: Friday, March 20, 2009 3:48 PM
> To: Hiroshi DOYU
> Cc: Gupta, Ramesh; Kanigeri, Hari; Guzman Lugo, Fernando;=20
> linux-omap@vger.kernel.org; ameya.palande@nokia.com
> Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a=20
> saner value
>=20
> On Fri, Mar 20, 2009 at 9:36 AM, Hiroshi DOYU=20
> <Hiroshi.DOYU@nokia.com> wrote:
> > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner=
=20
> > value
> > Date: Fri, 20 Mar 2009 06:54:04 +0200 (EET)
> >
> >> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> >> Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout=20
> to a saner=20
> >> value
> >> Date: Fri, 20 Mar 2009 01:06:16 +0100
> >>
> >> > On Fri, Mar 20, 2009 at 2:00 AM, Guzman Lugo, Fernando=20
> <x0095840@ti.com> wrote:
> >> > >
> >> > >
> >> > >
> >> > > This is a stress test, it creates 4 processes and each=20
> process will do 1000 transfers using streams, so the trace is:
> >> > >
> >> > > STRM_Issue -> =A0WMD_CHNL_AddIOReq =A0-> IO_Schedule
> >> > >
> >> > > IO_Schedule schedules a call to IO_DPC using task let.
> >> > >
> >> > > IO_DPC -> IO_DispatchChnl -> InputChnl -> CHNLSM_InterruptDSP2
> >> > >
> >> > > Also =A0 =A0 =A0IO_DispatchChnl -> OutputChnl ->=20
> CHNLSM_InterruptDSP2.
> >> > >
> >> > >
> >> > > As we can call a lot CHNLSM_InterruptDSP2 in this=20
> test, there is a problem with the timeout. However running=20
> other tests, videos and mp3 there no problems. I think we=20
> should change to 10ms, only to make sure there is no problem=20
> when CHNLSM_InterruptDSP2 is called a lot.
> >> > >
> >> > > Let me know if you are agreed. Or have some comments about it.
> >> >
> >> > Well again, the best way to implement the wait for a slot in the=
=20
> >> > mailbox is with interrupts, not busy-looping. If we=20
> busy-loop too=20
> >> > much that would increase the CPU usage, and that would be bad.
> >>
> >> I think that s/w queuing of messages would be more=20
> efficient to allow=20
> >> multiple senders to continue thier work anyway, especially in the=20
> >> case of having these streamings.
> >
> > Migrating to the existing mailbox driver("plat-omap/mailbox.c") is=20
> > also another option to support multiple OMAP architectures=20
> at the same=20
> > time. That mailbox driver has already had a message queuing feature=
=20
> > inside and it's buildable on OMAP3.
>=20
> Yeap, I have it in my to-do list, so if somebody doesn't beat=20
> me to it I play with that.

We already started looking into this :), made some progress,
will provide more updates in a day or two.

Regards
Ramesh Gupta G
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
