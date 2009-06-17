From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [APPLIED] [PATCH 2/2] OMAP: Zoom2: Fix file system loading issue
Date: Wed, 17 Jun 2009 08:52:27 -0700
Message-ID: <874ouezwlg.fsf@deeprootsystems.com>
References: <1244767797-22860-1-git-send-email-vikram.pandita@ti.com>
	<notify-1245247047@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D1877@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:56948 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbZFQPw2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 11:52:28 -0400
Received: by wf-out-1314.google.com with SMTP id 26so222122wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 08:52:30 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F53D1877@dbde02.ent.ti.com> (Vikram Pandita's message of "Wed\, 17 Jun 2009 20\:49\:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

>>This patch has been applied to the linux-omap
>>by youw fwiendly patch wobot.
>>
>>Branch in linux-omap: omap-fixes
>>
>>Initial commit ID (Likely to change): f84eca35d44fd64cdde542f12d08eb04ca534954
>>
>>PatchWorks
>>http://patchwork.kernel.org/patch/29668/
>
> This patch breaks the zoom2 build.
> ...	
> 	arch/arm/mach-omap2/board-zoom-debugboard.c:87: error: 'UPF_IRQ_TRIG_HIGH' undeclared here (not 	in a function)
> 	make[1]: *** [arch/arm/mach-omap2/board-zoom-debugboard.o] Error 1
> 	make: *** [arch/arm/mach-omap2] Error 2
> ...
>
> There is a dependency on 8250 patch:
> http://lists.arm.linux.org.uk/lurker/attach/1@20090612.173251.776f9eda.attach
>
>
> how do you want to address this issue?
>

Tony,

IMO, We should probably stage the 8250 UPF_* change in l-o as well
while we wait for the linux-serial lag.

Kevin
