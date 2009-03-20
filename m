From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value
Date: Fri, 20 Mar 2009 12:17:31 +0200
Message-ID: <94a0d4530903200317h403210f2u622b837be1e5d9a8@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E60287D628DC@dlee06.ent.ti.com>
	 <94a0d4530903191706t40fc9b8ctb90583f620d7509d@mail.gmail.com>
	 <20090320.065404.91322906.Hiroshi.DOYU@nokia.com>
	 <20090320.093605.42784990.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:29917 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758232AbZCTKRe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 06:17:34 -0400
Received: by fg-out-1718.google.com with SMTP id e12so163280fga.17
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 03:17:31 -0700 (PDT)
In-Reply-To: <20090320.093605.42784990.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: grgupta@ti.com, h-kanigeri2@ti.com, x0095840@ti.com, linux-omap@vger.kernel.org, ameya.palande@nokia.com

On Fri, Mar 20, 2009 at 9:36 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner v=
alue
> Date: Fri, 20 Mar 2009 06:54:04 +0200 (EET)
>
>> From: ext Felipe Contreras <felipe.contreras@gmail.com>
>> Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner =
value
>> Date: Fri, 20 Mar 2009 01:06:16 +0100
>>
>> > On Fri, Mar 20, 2009 at 2:00 AM, Guzman Lugo, Fernando <x0095840@t=
i.com> wrote:
>> > >
>> > >
>> > >
>> > > This is a stress test, it creates 4 processes and each process w=
ill do 1000 transfers using streams, so the trace is:
>> > >
>> > > STRM_Issue -> =C2=A0WMD_CHNL_AddIOReq =C2=A0-> IO_Schedule
>> > >
>> > > IO_Schedule schedules a call to IO_DPC using task let.
>> > >
>> > > IO_DPC -> IO_DispatchChnl -> InputChnl -> CHNLSM_InterruptDSP2
>> > >
>> > > Also =C2=A0 =C2=A0 =C2=A0IO_DispatchChnl -> OutputChnl -> CHNLSM=
_InterruptDSP2.
>> > >
>> > >
>> > > As we can call a lot CHNLSM_InterruptDSP2 in this test, there is=
 a problem with the timeout. However running other tests, videos and mp=
3 there no problems. I think we should change to 10ms, only to make sur=
e there is no problem when CHNLSM_InterruptDSP2 is called a lot.
>> > >
>> > > Let me know if you are agreed. Or have some comments about it.
>> >
>> > Well again, the best way to implement the wait for a slot in the
>> > mailbox is with interrupts, not busy-looping. If we busy-loop too =
much
>> > that would increase the CPU usage, and that would be bad.
>>
>> I think that s/w queuing of messages would be more efficient to allo=
w
>> multiple senders to continue thier work anyway, especially in the ca=
se
>> of having these streamings.
>
> Migrating to the existing mailbox driver("plat-omap/mailbox.c") is
> also another option to support multiple OMAP architectures at the sam=
e
> time. That mailbox driver has already had a message queuing feature
> inside and it's buildable on OMAP3.

Yeap, I have it in my to-do list, so if somebody doesn't beat me to it
I play with that.

Is there a way to play with the existing mailbox driver independently
of dsp-bridge?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
