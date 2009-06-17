From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [APPLIED] [PATCH 2/2] OMAP: Zoom2: Fix file system loading issue
Date: Wed, 17 Jun 2009 20:49:19 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F53D1877@dbde02.ent.ti.com>
References: <1244767797-22860-1-git-send-email-vikram.pandita@ti.com>
 <notify-1245247047@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56105 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbZFQPT0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 11:19:26 -0400
In-Reply-To: <notify-1245247047@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
>Lindgren
>Sent: Wednesday, June 17, 2009 8:57 AM
>To: linux-omap@vger.kernel.org
>Subject: [APPLIED] [PATCH 2/2] OMAP: Zoom2: Fix file system loading issue
>
>This patch has been applied to the linux-omap
>by youw fwiendly patch wobot.
>
>Branch in linux-omap: omap-fixes
>
>Initial commit ID (Likely to change): f84eca35d44fd64cdde542f12d08eb04ca534954
>
>PatchWorks
>http://patchwork.kernel.org/patch/29668/

This patch breaks the zoom2 build.
...	
	arch/arm/mach-omap2/board-zoom-debugboard.c:87: error: 'UPF_IRQ_TRIG_HIGH' undeclared here (not 	in a function)
	make[1]: *** [arch/arm/mach-omap2/board-zoom-debugboard.o] Error 1
	make: *** [arch/arm/mach-omap2] Error 2
...

There is a dependency on 8250 patch:
http://lists.arm.linux.org.uk/lurker/attach/1@20090612.173251.776f9eda.attach


how do you want to address this issue?


>
>Git (Likely to change, and takes a while to get mirrored)
>http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
>2.6.git;a=commit;h=f84eca35d44fd64cdde542f12d08eb04ca534954
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

