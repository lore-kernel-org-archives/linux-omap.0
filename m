From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v4 0/4] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Mon, 01 Jul 2013 13:43:51 +0300
Message-ID: <1372675431.22014.60.camel@sauron.fi.intel.com>
References: <1372672313-4104-1-git-send-email-pekon@ti.com>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60313 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753352Ab3GAKju (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jul 2013 06:39:50 -0400
In-Reply-To: <1372672313-4104-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: tony@atomide.com, benoit.cousson@linaro.org, arnd@arndb.de, avinashphilipk@gmail.com, jp.francois@cynove.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, 2013-07-01 at 15:21 +0530, Pekon Gupta wrote:
> +---------------------------------------+---------------+---------------+
> | ECC scheme				|ECC calculation|Error detection|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_HAMMING_CODE_DEFAULT		|S/W		|S/W		|
> |OMAP_ECC_HAMMING_CODE_HW		|H/W (GPMC)	|S/W		|
> |OMAP_ECC_HAMMING_CODE_HW_ROMCODE	|H/W (GPMC)	|S/W		|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH4_CODE_HW_DETECTION_SW	|H/W (GPMC)	|S/W (lib/bch.h)|
> |OMAP_ECC_BCH4_CODE_HW			|H/W (GPMC)	|H/W (ELM)	|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW	|H/W (GPMC)	|S/W (lib/bch.h)|
> |OMAP_ECC_BCH8_CODE_HW			|H/W (GPMC)	|H/W (ELM)	|
> +---------------------------------------+---------------+---------------+

Pushed patches 1-3 to l2-mtd.git, thanks. I had to fix the table because
you use tabs there, and git log makes the table look messy. Please, use
spaces instead next time.

Thanks!

-- 
Best Regards,
Artem Bityutskiy

