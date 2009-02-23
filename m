From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/4] dsp-bridge: cleanup and remove HW_MBOX_IsFull
Date: Tue, 24 Feb 2009 00:22:45 +0200
Message-ID: <94a0d4530902231422y6b044cb2qe686c7e106ff2e5e@mail.gmail.com>
References: <94a0d4530902212246h4160ae83pf435b5c6faf88237@mail.gmail.com>
	 <1235295144-22097-1-git-send-email-felipe.contreras@gmail.com>
	 <1235295144-22097-2-git-send-email-felipe.contreras@gmail.com>
	 <1235295144-22097-3-git-send-email-felipe.contreras@gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E211807CE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:3133 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbZBWWWt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 17:22:49 -0500
Received: by fg-out-1718.google.com with SMTP id 16so20318fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2009 14:22:46 -0800 (PST)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E211807CE@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>

On Tue, Feb 24, 2009 at 12:06 AM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Hi Felipe,
>
>> HW_MBOX_IsFull has many convoluted macros and is used only once. Clean
>> it up so it's easier to see what it's actually doing.
>
> -- Is this the reason you added a new function that checks if fifo is full or is there any issue with the existing function ?

fifo_full should do exactly the same as HW_MBOX_IsFulll, I just
removed all the macros and used __raw_readl instead. I could have
removed the fifo_full function and do the __raw_readl directly, but I
thought this way it was more readable.

The main reason I cleaned the function was for performance reasons;
remove unnecessary checks, extra steps, and the function call (now
inline).

-- 
Felipe Contreras
