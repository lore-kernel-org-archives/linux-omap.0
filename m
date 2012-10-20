From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMP35xx booting issue
Date: Sat, 20 Oct 2012 06:28:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210200627180.9865@utopia.booyaka.com>
References: <CAPjKCR8wzfPxuts4_i-P-X+fru2C-QwZcp_g=w_eHi0SJ_PgiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53140 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981Ab2JTG2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 02:28:53 -0400
In-Reply-To: <CAPjKCR8wzfPxuts4_i-P-X+fru2C-QwZcp_g=w_eHi0SJ_PgiA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anil Kumar <anilkumar880@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, balbi@ti.com

On Sat, 20 Oct 2012, Anil Kumar wrote:

> I am trying to boot devkit8000(based on OMP35xx) with kernel 3.6
> and board stopped booting here (kernel logs  [1]). It looks Paul also
> faced same type issue or i am missing some some thing ?

3.6 boots fine for me on Beagle.

> Waiting for root device /dev/mmcblk0p2...

You might want to doublecheck the board file you're using and make sure 
the regulators are configured appropriately.


- Paul
