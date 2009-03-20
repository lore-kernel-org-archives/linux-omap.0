From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value
Date: Thu, 19 Mar 2009 19:00:34 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287D628DC@dlee06.ent.ti.com>
References: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-3-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-4-git-send-email-felipe.contreras@gmail.com>
	 <496565EC904933469F292DDA3F1663E60287D6286E@dlee06.ent.ti.com>
	 <94a0d4530903191404y14b5331eoaccb3f11c1846f9d@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E60287D62895@dlee06.ent.ti.com>
 <94a0d4530903191435g7785a334v6e0a6988f344bbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57492 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbZCTAAq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 20:00:46 -0400
In-Reply-To: <94a0d4530903191435g7785a334v6e0a6988f344bbc@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>




This is a stress test, it creates 4 processes and each process will do 1000 transfers using streams, so the trace is:

STRM_Issue ->  WMD_CHNL_AddIOReq  -> IO_Schedule

IO_Schedule schedules a call to IO_DPC using task let.

IO_DPC -> IO_DispatchChnl -> InputChnl -> CHNLSM_InterruptDSP2

Also      IO_DispatchChnl -> OutputChnl -> CHNLSM_InterruptDSP2.


As we can call a lot CHNLSM_InterruptDSP2 in this test, there is a problem with the timeout. However running other tests, videos and mp3 there no problems. I think we should change to 10ms, only to make sure there is no problem when CHNLSM_InterruptDSP2 is called a lot.

Let me know if you are agreed. Or have some comments about it.

Regards,
Fernando.


-----Original Message-----
From: Felipe Contreras [mailto:felipe.contreras@gmail.com] 
Sent: Thursday, March 19, 2009 3:35 PM
To: Guzman Lugo, Fernando
Cc: linux-omap@vger.kernel.org; Kanigeri, Hari; Hiroshi DOYU; Ameya Palande; Felipe Contreras
Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value

On Thu, Mar 19, 2009 at 11:19 PM, Guzman Lugo, Fernando <x0095840@ti.com> wrote:
>
> Yes, I applied this; in fact I have applied all the patches. If I increase the timeout there are no problems. The test I run creates 4 process and each one does several a lot of calls to InputChnl and OutputChnl, so I think this test is using the mailbox a lot and would be better a bigger timeout. What do you think?

How fast are these messages sent? Can you track down which functions
are calling CHNLSM_InterruptDSP2 and making these timeouts happen.

I think it's safe to leave the timeout at 10, but that means it's
possible the code will be busy-looping up to 10 ms which will increase
the CPU load. Somebody from Nokia (Siarhei?) suggested to idle-wait
for the mbox empty irq, I think that's the best way to implement this,
but at least for the use cases I'm interested in (video
encoding/decoding) timeouts don't seem to be an issue anymore.

-- 
Felipe Contreras

