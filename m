From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: Add OMAP34xx pin muxing into I2C bus
 registration helper
Date: Tue, 10 Jun 2008 08:19:30 +0300
Message-ID: <20080610081930.644b9a11.jarkko.nikula@nokia.com>
References: <1213022801-25058-1-git-send-email-jarkko.nikula@nokia.com>
	<1213022801-25058-2-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47518 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbYFJFT2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 01:19:28 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5A5Ixfi028238
	for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 08:19:26 +0300
In-Reply-To: <1213022801-25058-2-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Mon,  9 Jun 2008 17:46:41 +0300
Jarkko Nikula <jarkko.nikula@nokia.com> wrote:

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/plat-omap/i2c.c |   51 +++++++++++++++++++++++++++
> +----------------- 1 files changed, 32 insertions(+), 19 deletions(-)
> 
> -static void __init omap_i2c_mux_pins(int bus_id)
> +static const int omap1_pins[][2] = {
> +	{ I2C_SCL, I2C_SDA },
> +};
> +static const int omap24xx_pins[][2] = {
> +	{ M19_24XX_I2C1_SCL, L15_24XX_I2C1_SDA },
> +	{ J15_24XX_I2C2_SCL, H19_24XX_I2C2_SDA },
> +};
> +static const int omap34xx_pins[][2] = {
> +	{ K21_34XX_I2C1_SCL, J21_34XX_I2C1_SDA},
> +	{ AF15_34XX_I2C2_SCL, AE15_34XX_I2C2_SDA},
> +	{ AF14_34XX_I2C3_SCL, AG14_34XX_I2C3_SDA},
> +	{ AD26_34XX_I2C4_SCL, AE26_34XX_I2C4_SDA},
> +};
> +
NAK to myself. Avoiding few #ifdefs is not an excuse for spending some
bytes here and also it doesn't look good to add muxing support for bus
4 where the module itself doesn't support it (yet).

Lazy me :-)

Jarkko
