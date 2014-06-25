From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Wed, 25 Jun 2014 12:27:35 -0300
Message-ID: <20140625152735.GA17792@arch.cereza>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:46992 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515AbaFYP2W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2014 11:28:22 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so1255656yho.30
        for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2014 08:28:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403612666-31197-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>

On 24 Jun 05:54 PM, Pekon Gupta wrote:
> +&gpmc {
> +	ranges = <0 0 0 0x01000000>;	/* address range = 16MB (minimum GPMC partition) */
> +	nand@0,0 {
> +		status = "disabled";
> +		reg = <0 0 4>;		/* device IO registers */
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bbcape_nand_flash_pins>;
> +		ti,nand-ecc-opt = "bch8";
> +		ti,elm-id = <&elm>;

Don't you need something like this to turn on the elm device?

&elm {
	status = "okay";
};

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
