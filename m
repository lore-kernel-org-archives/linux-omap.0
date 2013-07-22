From: Paul Walmsley <paul@pwsan.com>
Subject: Re: linux-3.11-rc1: Internal error: Oops - undefined instruction:
 0 [#1] SMP ARM on OMAP3/AM335x
Date: Mon, 22 Jul 2013 16:55:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307221652350.10891@utopia.booyaka.com>
References: <51ECFBAC.7090900@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47267 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343Ab3GVQzb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 12:55:31 -0400
In-Reply-To: <51ECFBAC.7090900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: catalin.marinas@arm.com, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Mesfin, Yebio" <ymesfin@ti.com>

On Mon, 22 Jul 2013, Roger Quadros wrote:

> I observe the following problem on booting v3.11-rc1 on OMAP3 beagle board.
> 
> [    5.888946] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> [    5.896057] Modules linked in:
> [    5.899322] CPU: 0 PID: 9 Comm: rcu_sched Not tainted 3.11.0-rc2-00001-g1ea701a #876
> [    5.907501] task: ce0720c0 ti: ce07a000 task.ti: ce07a000
> [    5.913208] PC is at check_and_switch_context+0x130/0x4dc
> [    5.918914] LR is at check_and_switch_context+0xd8/0x4dc

It affects 3730beaglexm and am335xbonelt here too.

http://www.pwsan.com/omap/testlogs/test_v3.11-rc2/20130721203314/boot/am335xbonelt/am335x-bone/am335xbonelt_log.txt
http://www.pwsan.com/omap/testlogs/test_v3.11-rc2/20130721203314/boot/3730beaglexm/3730beaglexm_log.txt


- Paul
