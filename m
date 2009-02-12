From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Thu, 12 Feb 2009 15:10:09 +0200
Message-ID: <20090212151009.f1920110.jarkko.nikula@nokia.com>
References: <cf33789c708e166cea5350a1d3c19e20c6bf0056.1234439236.git.ext-atal.shargorodsky@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45837 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076AbZBLNKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 08:10:06 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1CD9GtP015615
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 15:10:03 +0200
In-Reply-To: <cf33789c708e166cea5350a1d3c19e20c6bf0056.1234439236.git.ext-atal.shargorodsky@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shargorodsky Atal (EXT-Teleca/Helsinki)" <ext-atal.shargorodsky@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 12 Feb 2009 13:54:54 +0100
"Shargorodsky Atal (EXT-Teleca/Helsinki)"
<ext-atal.shargorodsky@nokia.com> wrote:

> This patch allows I2C_OMAP to be compiled as a module.
> Only drivers/i2c/busses/i2c-omap.c can be compiled as a module,
> but not arch/arm/plat-omap/i2c.c , so let the contents of i2c.c
> to compile into the kernel if I2C_OMAP was selected to compile in
> or as a module.
> 
> Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
> ---
>  arch/arm/plat-omap/Makefile |    3 +--
>  arch/arm/plat-omap/i2c.c    |    4 ++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 175bfd6..fe4738e 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -4,7 +4,7 @@
> 
>  # Common support
>  obj-y := common.o sram.o clock.o devices.o dma.o mux.o gpio.o \
> -        usb.o fb.o io.o dss.o
> +        usb.o fb.o io.o dss.o i2c.o

Can you base this on linux-omap? There is no dss there so patch doesn't
apply.

Generally I agree the patch since it fixes linking error when
CONFIG_I2C_OMAP=m and arch/arm/plat-omap/i2c.o cannot be compiled as a
module because it is for board initialization code.


Jarkko
