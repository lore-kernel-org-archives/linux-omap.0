From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM: OMAP: 2430SDP: Use defines in asm/sizes.h
Date: Wed, 30 Apr 2008 07:49:01 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429042C61F4@dlee13.ent.ti.com>
References: <1209545030-31637-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:34865 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073AbYD3MtK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 08:49:10 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1209545030-31637-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

> Instead of manually calculating the partition sizes, it's
> better to use defines already set in include/asm-arm/sizes.h

I don't know that I agree with this for a flash device.  Knowing something about the block geometry of the device with out having to dig up the data sheet is pretty useful.

I'm not vouching for the original code's actual just what the intent might be.  You should have the 1st 4 blocks for a redundant x-loader, the next blocks for a size sufficient to hold a u-boot, then generally 1 block for u-boot environment, and then the definition from there as to how to have the kernel and file system has a few ways to go.

Really using the boot command line is best as compared to a static array here.

> Compile test only.
> 

It doesn't look like you did your math correctly.  How can these 2 partitions have the same .size in your patch given their original definition?

>  		.mask_flags	= MTD_WRITEABLE	/* force read-only */
>  	},
>  	{
>  		.name		= "U-Boot",
>  		.offset		= MTDPART_OFS_APPEND,
> -		.size		=  4*(64*2048),
> +		.size		= SZ_128K,
>  		.mask_flags	= MTD_WRITEABLE	/* force read-only */
>  	},
>  	{
>  		.name		= "U-Boot Environment",
>  		.offset		= MTDPART_OFS_APPEND,
> -		.size		= 2*(64*2048),
> +		.size		= SZ_128K,
>  	},

Regards,
Richard W.
