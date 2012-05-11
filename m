From: Paul Walmsley <paul@pwsan.com>
Subject: Re: New OMAP build warning
Date: Fri, 11 May 2012 02:33:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205110233260.3201@utopia.booyaka.com>
References: <20120511072753.GA6253@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37444 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298Ab2EKIdr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 04:33:47 -0400
In-Reply-To: <20120511072753.GA6253@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, 11 May 2012, Russell King - ARM Linux wrote:

> arch/arm/plat-omap/usb.c: In function 'omap_otg_init':
> arch/arm/plat-omap/usb.c:40: warning: unused variable 'status'
> 
> caused by:
> 
> commit eeb3711b89d68e147e05e7b43a49ecc5009dc157
> Author: Paul Walmsley <paul@pwsan.com>
> Date:   Fri Apr 13 06:34:32 2012 -0600
> 
>     ARM: OMAP2+: clean up some cppcheck warnings

Thanks, this has been fixed by:

http://marc.info/?l=linux-omap&m=133660322929805&w=2


- Paul
