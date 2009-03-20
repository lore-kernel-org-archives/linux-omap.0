From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value
Date: Fri, 20 Mar 2009 02:06:16 +0200
Message-ID: <94a0d4530903191706t40fc9b8ctb90583f620d7509d@mail.gmail.com>
References: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-3-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-4-git-send-email-felipe.contreras@gmail.com>
	 <496565EC904933469F292DDA3F1663E60287D6286E@dlee06.ent.ti.com>
	 <94a0d4530903191404y14b5331eoaccb3f11c1846f9d@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E60287D62895@dlee06.ent.ti.com>
	 <94a0d4530903191435g7785a334v6e0a6988f344bbc@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E60287D628DC@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:7167 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbZCTAGT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 20:06:19 -0400
Received: by fg-out-1718.google.com with SMTP id e12so126619fga.17
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2009 17:06:16 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E60287D628DC@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

On Fri, Mar 20, 2009 at 2:00 AM, Guzman Lugo, Fernando <x0095840@ti.com=
> wrote:
>
>
>
> This is a stress test, it creates 4 processes and each process will d=
o 1000 transfers using streams, so the trace is:
>
> STRM_Issue -> =C2=A0WMD_CHNL_AddIOReq =C2=A0-> IO_Schedule
>
> IO_Schedule schedules a call to IO_DPC using task let.
>
> IO_DPC -> IO_DispatchChnl -> InputChnl -> CHNLSM_InterruptDSP2
>
> Also =C2=A0 =C2=A0 =C2=A0IO_DispatchChnl -> OutputChnl -> CHNLSM_Inte=
rruptDSP2.
>
>
> As we can call a lot CHNLSM_InterruptDSP2 in this test, there is a pr=
oblem with the timeout. However running other tests, videos and mp3 the=
re no problems. I think we should change to 10ms, only to make sure the=
re is no problem when CHNLSM_InterruptDSP2 is called a lot.
>
> Let me know if you are agreed. Or have some comments about it.

Well again, the best way to implement the wait for a slot in the
mailbox is with interrupts, not busy-looping. If we busy-loop too much
that would increase the CPU usage, and that would be bad.

That's why I want to use the 1ms timeout; to find issues that cause
increase in CPU load.

But for now I think 10ms is the safest, as it's the current value. If
somebody wants to pin-point issues, then the timeout should be
decreased.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
