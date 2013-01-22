From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Tue, 22 Jan 2013 13:45:55 +0000
Message-ID: <50FE9813.8060207@mimc.co.uk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com> <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna> <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com> <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk> <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com> <50FE66AC.2090306@mimc.co.uk> <874ni95ry6.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:43761 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751103Ab3AVNp4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 08:45:56 -0500
In-Reply-To: <874ni95ry6.fsf@dell.be.48ers.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Paul Walmsley <paul@pwsan.com>, Matt Porter <mporter@ti.com>, Richard Cochran <richardcochran@gmail.com>, "Menon, Nishanth" <nm@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 22/01/13 12:21, Peter Korsgaard wrote:
>>>>>> "Mark" == Mark Jackson <mpfj-list@mimc.co.uk> writes:
> 
> Hi,
> 
>  Mark> Bytes transferred = 3963919 (3c7c0f hex)
>  Mark> ## Booting kernel from Legacy Image at 80000000 ...
>  Mark>    Image Name:   Linux
>  Mark>    Image Type:   ARM Linux Kernel Image (uncompressed)
>  Mark>    Data Size:    3963855 Bytes = 3.8 MiB
>  Mark>    Load Address: 80008000
>  Mark>    Entry Point:  80008000
>  Mark>    Verifying Checksum ... OK
>  Mark>    Loading Kernel Image ... OK
>  Mark> OK
> 
> I haven't tried a recent -next build, but what is your kernel command
> line and did you try without EARLY_PRINTK?
> 

Kernel command line: console=ttyO0,115200n8 earlyprintk debug root=/dev/mmcblk0p2 ro rootfstype=ext2
rootwait

I understand that MMC is not in the mainline.

Aha ... I tried without EARLY_PRINTK and it now boots up to the point of rootfs access.

Cheers
Mark J.
