From: twebb <taliaferro62@gmail.com>
Subject: Re: OMAP34xx vs OMAP 35xx
Date: Mon, 29 Sep 2008 09:52:27 -0400
Message-ID: <dbdb2ea60809290652q1b501770yff7e4643dd33065a@mail.gmail.com>
References: <dbdb2ea60809260745m3652748bm2d2773213c57a6b5@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301AFF40D64@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:56709 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbYI2Nw2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:52:28 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2126356wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 29 Sep 2008 06:52:27 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301AFF40D64@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

>
> The "3" in OMAP3 stands for 3rd generation of OMAP devices - both OMAP34x and OMAP35x.
>
> Besides the silicon technology differences (and minor pin-outs) there are varied number of changes between these processor families. One key difference is that OMAP35x family comprises of OMAP3503 (ARM only device), OMAP3515 (ARM + Graphics), OMAP3525 (ARM + C64x+ based IVA) and OMAP3530 (ARM + Graphics + IVA). OMAP3430 will be more closer to OMAP3530.
> See http://focus.ti.com/general/docs/gencontent.tsp?contentId=46725 for more details.
>
> As for OMAP3430SDP and OMAP3EVM, the differences are many. They use cases for both these boards were quite different. It translates to form-factor, on-board peripherals, ...
>

Thanks for the response.  I understand the makeup of the various
OMAP35xx processors.  I guess my confusion centers around specific
support for the OMAP35x EVM platform.  I have that platform, running
the SDK v1.0.0 (from TI).  However, I downloaded the 2.6.26
(tag=v2.6.26-omap2) kernel from the l-o git and had several issues: a)
omap3_evm_defconfig needed modifications to add appropriate mtd
support; b) no output on LCD.  Any ideas on the display issue?
(Perhaps I should submit this to the list under a new subject.)

Does the linux-omap git support the OMAP35x EVM as a platform?  I've
gotten previous feedback from a few folks who say omapzoom.git is the
better place to start, but others say that linux-omap.git is the
better place.  Since neither works straight out of the git it's
difficult for me to judge which is further along in it's support of
35x EVM.

Thanks,
twebb
