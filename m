From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value
Date: Fri, 20 Mar 2009 09:36:05 +0200 (EET)
Message-ID: <20090320.093605.42784990.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E60287D628DC@dlee06.ent.ti.com>
	<94a0d4530903191706t40fc9b8ctb90583f620d7509d@mail.gmail.com>
	<20090320.065404.91322906.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54736 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbZCTHga convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 03:36:30 -0400
In-Reply-To: <20090320.065404.91322906.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grgupta@ti.com, h-kanigeri2@ti.com, felipe.contreras@gmail.com
Cc: x0095840@ti.com, linux-omap@vger.kernel.org, ameya.palande@nokia.com

=46rom: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner val=
ue
Date: Fri, 20 Mar 2009 06:54:04 +0200 (EET)

> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner v=
alue
> Date: Fri, 20 Mar 2009 01:06:16 +0100
>=20
> > On Fri, Mar 20, 2009 at 2:00 AM, Guzman Lugo, Fernando <x0095840@ti=
=2Ecom> wrote:
> > >
> > >
> > >
> > > This is a stress test, it creates 4 processes and each process wi=
ll do 1000 transfers using streams, so the trace is:
> > >
> > > STRM_Issue -> =A0WMD_CHNL_AddIOReq =A0-> IO_Schedule
> > >
> > > IO_Schedule schedules a call to IO_DPC using task let.
> > >
> > > IO_DPC -> IO_DispatchChnl -> InputChnl -> CHNLSM_InterruptDSP2
> > >
> > > Also =A0 =A0 =A0IO_DispatchChnl -> OutputChnl -> CHNLSM_Interrupt=
DSP2.
> > >
> > >
> > > As we can call a lot CHNLSM_InterruptDSP2 in this test, there is =
a problem with the timeout. However running other tests, videos and mp3=
 there no problems. I think we should change to 10ms, only to make sure=
 there is no problem when CHNLSM_InterruptDSP2 is called a lot.
> > >
> > > Let me know if you are agreed. Or have some comments about it.
> >=20
> > Well again, the best way to implement the wait for a slot in the
> > mailbox is with interrupts, not busy-looping. If we busy-loop too m=
uch
> > that would increase the CPU usage, and that would be bad.
>=20
> I think that s/w queuing of messages would be more efficient to allow
> multiple senders to continue thier work anyway, especially in the cas=
e
> of having these streamings.

Migrating to the existing mailbox driver("plat-omap/mailbox.c") is
also another option to support multiple OMAP architectures at the same
time. That mailbox driver has already had a message queuing feature
inside and it's buildable on OMAP3.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
