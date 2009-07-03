From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND][PATCH 0/2] McSPI Slave and DMA ,FIFO support
Date: Thu, 2 Jul 2009 17:05:17 -0700
Message-ID: <200907021705.18048.david-b@pacbell.net>
References: <42120.10.24.255.18.1245765231.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:43431 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752266AbZGCAFP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jul 2009 20:05:15 -0400
In-Reply-To: <42120.10.24.255.18.1245765231.squirrel@dbdmail.itg.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net

On Tuesday 23 June 2009, Hemanth V wrote:
> This series of 2 patches adds support for McSPI slave
> and DMA,FIFO. It incorporates review comments from
> Kevin Hilman and Tony Lindgren
> 
> 
> PATCH[1/2]: Changes to arch specific files
> PATCH[2/2]: omap2_mcspi.c file changes

Needs some changes yet:

  - Split out slave support as a separate patch.
    That's not really supported by the interface yet.

  - You sent the two patches with the same $SUBJECT;
    which indicates they are the *SAME* patch ...
    either make it be one patch, or change $SUBJECT
    (perhaps to match what you used above).

The stuff in #1 should have Tony's ack.


> 
>  arch/arm/mach-omap2/devices.c           |    5
>  arch/arm/plat-omap/include/mach/mcspi.h |   16 +
>  drivers/spi/omap2_mcspi.c               |  353
> ++++++++++++++++++++++++++++++++++++++++------
> 
> 
> 


