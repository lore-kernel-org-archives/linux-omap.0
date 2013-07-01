From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v3 1/4] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC
 configurations in device_probe
Date: Mon, 01 Jul 2013 11:16:28 +0300
Message-ID: <1372666588.22014.43.camel@sauron.fi.intel.com>
References: <1372010299-30141-1-git-send-email-pekon@ti.com>
	 <1372010299-30141-2-git-send-email-pekon@ti.com>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:56306 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879Ab3GAIRS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jul 2013 04:17:18 -0400
In-Reply-To: <1372010299-30141-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, arnd@arndb.de, jp.francois@cynove.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

Hi Pekon,

On Sun, 2013-06-23 at 23:28 +0530, Pekon Gupta wrote:
> +---------------------------------------+---------------+---------------+
> | ECC scheme				|ECC calculation|Error detection|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_HAMMING_CODE_DEFAULT		|S/W		|S/W		|
> |OMAP_ECC_HAMMING_CODE_HW		|H/W (GPMC)	|S/W		|
> |OMAP_ECC_HAMMING_CODE_HW_ROMCODE	|H/W (GPMC)	|S/W		|
> +---------------------------------------+---------------+---------------+
> |(requires CONFIG_MTD_NAND_ECC_BCH)	|		|		|
> |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW	|H/W (GPMC)	|S/W		|
> +---------------------------------------+---------------+---------------+
> |(requires CONFIG_MTD_NAND_OMAP_BCH)	|		|		|
> |OMAP_ECC_BCH8_CODE_HW			|H/W (GPMC)	|H/W (ELM)	|
> +---------------------------------------+---------------+---------------+

This is a nice table, and you are doing very good job clearly
classifying what is going on. I'd suggest to also put stuff like this to
comments in the code.

> This patch
> - separates the configurations for various ECC schemes.
> - fixes dependency issues based on Kconfig options.
> - cleans up redundant code
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>

This does not apply to l2-mtd.git, could you please re-base?

-- 
Best Regards,
Artem Bityutskiy

