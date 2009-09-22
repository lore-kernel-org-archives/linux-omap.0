From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: linux omap on sdp broken?
Date: Tue, 22 Sep 2009 13:00:44 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD991DFF@dbde02.ent.ti.com>
References: <782515bb0909181942v58ea0e95n8025eb47876116bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32787 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbZIVHap convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 03:30:45 -0400
In-Reply-To: <782515bb0909181942v58ea0e95n8025eb47876116bf@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Nishanth Menon
> Sent: Saturday, September 19, 2009 8:12 AM
> To: linux-omap
> Subject: linux omap on sdp broken?
> 
> Hi Folks,
> Has Anyone tried booting latest kernel from tmlind master 
> tree recently?
> Ref: 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-oma
> p-2.6.git
> 
> Starting kernel ...
> Uncompressing 
> Linux.........................................................
> ..............................................................
> ..........................................
> done, booting the kernel.
> 
> Gets stuck there..

I saw similar error on OMAP3EVM but "make distclean" followed
by regular "make" helped me.

~sanjeev

> Tried with
> arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2009q1-203) 4.3.3
> Copyright (C) 2008 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions. 
>  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A 
> PARTICULAR PURPOSE.
> 
> Also tried 2008q3 with no luck.
> 
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 