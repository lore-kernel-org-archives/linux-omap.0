From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Tue, 22 Jan 2013 13:21:21 +0100
Message-ID: <874ni95ry6.fsf@dell.be.48ers.dk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
	<50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
	<f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
	<20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
	<alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
	<50FE66AC.2090306@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:44937 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab3AVMV2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 07:21:28 -0500
Received: by mail-bk0-f49.google.com with SMTP id jm19so3686250bkc.22
        for <linux-omap@vger.kernel.org>; Tue, 22 Jan 2013 04:21:25 -0800 (PST)
In-Reply-To: <50FE66AC.2090306@mimc.co.uk> (Mark Jackson's message of "Tue, 22
	Jan 2013 10:15:08 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Matt Porter <mporter@ti.com>, Richard Cochran <richardcochran@gmail.com>, "Menon, Nishanth" <nm@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

>>>>> "Mark" == Mark Jackson <mpfj-list@mimc.co.uk> writes:

Hi,

 Mark> Bytes transferred = 3963919 (3c7c0f hex)
 Mark> ## Booting kernel from Legacy Image at 80000000 ...
 Mark>    Image Name:   Linux
 Mark>    Image Type:   ARM Linux Kernel Image (uncompressed)
 Mark>    Data Size:    3963855 Bytes = 3.8 MiB
 Mark>    Load Address: 80008000
 Mark>    Entry Point:  80008000
 Mark>    Verifying Checksum ... OK
 Mark>    Loading Kernel Image ... OK
 Mark> OK

I haven't tried a recent -next build, but what is your kernel command
line and did you try without EARLY_PRINTK?

-- 
Bye, Peter Korsgaard
