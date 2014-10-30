From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 02/10] ARM: dts: Fix wrong GPMC size mappings for omaps
Date: Thu, 30 Oct 2014 14:05:54 +0200
Message-ID: <545229A2.7000708@ti.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com> <1414628948-30702-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52419 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758889AbaJ3MGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2014 08:06:19 -0400
In-Reply-To: <1414628948-30702-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

On 10/30/2014 02:29 AM, Tony Lindgren wrote:
> The GPMC binding is obviously very confusing as the values
> are all over the place. People seem to confuse the GPMC partition
> size for the chip select, and the device IO size within the GPMC
> partition easily.
> 
> The ranges entry contains the GPMC partition size. And the
> reg entry contains the size of the IO registers of the
> device connected to the GPMC.
> 
> Let's fix the issue according to the following table:
> 
> Device          GPMC partition size     Device IO size
> connected       in the ranges entry     in the reg entry
> 
> NAND            0x01000000 (16MB)       4
> 16550           0x01000000 (16MB)       8
> smc91x          0x01000000 (16MB)       0xf
> smc911x         0x01000000 (16MB)       0xff
> OneNAND         0x01000000 (16MB)       0x20000 (128KB)
> 16MB NOR        0x01000000 (16MB)       0x01000000 (16MB)
> 32MB NOR        0x02000000 (32MB)       0x02000000 (32MB)
> 64MB NOR        0x04000000 (64MB)       0x04000000 (64MB)
> 128MB NOR       0x08000000 (128MB)      0x08000000 (128MB)
> 256MB NOR       0x10000000 (256MB)      0x10000000 (256MB)
> 
> Let's also add comments to the fixed entries while at it.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
