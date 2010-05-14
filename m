From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Fri, 14 May 2010 14:49:56 -0500
Message-ID: <4BEDA964.9070704@ti.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>	 <g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>	 <r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com> <AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44354 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757520Ab0ENTuf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 May 2010 15:50:35 -0400
In-Reply-To: <AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "Menon, Nishanth" <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On 5/14/2010 2:27 PM, Felipe Contreras wrote:
[...]
>
> So, I tried your patches, and a simple test app worked fine without
> modification, but a real video decoding hanged the device
> completely... some spinlock was stuck. I don't know if it's because of
> your patches, or because of the state of the bridge at that point.
> I'll try first to rebase to the latest to have a better idea of what's
> happening.
>

You may want to check if you have this patch "DSPBRIDGE: Fix declaration 
and initialization of sync objects"[1]

This is the one I know fixes a spinlock issue and which description is 
not clear enough to state that.

File fixed was: drivers/dsp/bridge/wmd/msg_sm.c

[1]http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=b3900e6df1f4e16b59d506a299cd5084c67a6ede

Regards,

- omar
