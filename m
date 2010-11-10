From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Mistral AM37x (with AM3715) devel board networking broken
Date: Wed, 10 Nov 2010 18:33:13 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930234992269@dbde02.ent.ti.com>
References: <E1PFgDD-0002jm-KX@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60806 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755930Ab0KJNDW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 08:03:22 -0500
In-Reply-To: <E1PFgDD-0002jm-KX@amazonia.comcast.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Rick Bronson [mailto:rick@efn.org] 
> Sent: Tuesday, November 09, 2010 10:24 AM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: RE: Mistral AM37x (with AM3715) devel board networking broken
> 
> Hi Sanjeev,
> 
>   Thanks much for the help.
> 
> > I tried building the latest on l-o master and was able to 
> boot consistently
> > in 4 times I tried. Didn't notice the gpio clock related 
> error I noticed in
> > your boot log.
> > 
> > 
> > U-Boot 2010.09 (Nov 08 2010 - 17:11:45)
> > 
> > OMAP3630/3730-GP ES2.0, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
> > OMAP3 EVM board + LPDDR/NAND
> 
>  Note that mine is ES1.0 (yours is ES2.0):
> 
> OMAP3630/3730-GP ES1.0, CPU-OPP2, L3-165MHz, Max CPU Clock 1 
> Ghz                
> 
>   Not sure if that's any clue.
> 
>   Tonight I got the latest stuff:
> 
> git clone 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-oma
> p-2.6.git
> 
>   and built it up with:
> 
> make omap2plus_defconfig ARCH=arm
> 
>   And got this
> 
> http://www.efn.org/~rick/pub/boot6.log
> 
>   It's basically the same, I get the 3 warnings and sometimes 
> eth0 works
> and sometimes it doesn't.  Note that my board works flawlessly with
> the kernel on the SD Card.
> 
>   What compiler are you using?  I tried CodeSourcery
> 2009q1 and 2010q1 with the same results.

[sp] I am mostly using 2009q1; but have use 2010q1 earlier in JUL;
     didn't see any issues back then.

> 
>   How did you configure your u-boot?

[sp] It is default configuration on the u-boot master. 

> 
>   Could you send me your boot up text?  Could you send me your
> u-boot.bin (and or your uImage) so I can try it?  I might help me
> figure out what's going on.

[sp] Will send offline

~sanjeev

> 
>  Thanks again.
> 
>  Rick
> 