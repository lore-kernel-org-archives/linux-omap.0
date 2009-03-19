From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value
Date: Thu, 19 Mar 2009 23:35:17 +0200
Message-ID: <94a0d4530903191435g7785a334v6e0a6988f344bbc@mail.gmail.com>
References: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-3-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-4-git-send-email-felipe.contreras@gmail.com>
	 <496565EC904933469F292DDA3F1663E60287D6286E@dlee06.ent.ti.com>
	 <94a0d4530903191404y14b5331eoaccb3f11c1846f9d@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E60287D62895@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:33963 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbZCSVfV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 17:35:21 -0400
Received: by fg-out-1718.google.com with SMTP id 16so139254fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2009 14:35:17 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E60287D62895@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

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
