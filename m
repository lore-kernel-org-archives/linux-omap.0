From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Re: [PATCH v6 0/7] nand prefetch-irq support and ecc layout chanage
Date: Mon, 20 Dec 2010 10:45:53 +1300
Message-ID: <201012201045.53688.manningc2@actrix.gen.nz>
References: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:52943 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755295Ab0LSVp4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Dec 2010 16:45:56 -0500
In-Reply-To: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Saturday 27 November 2010 04:34:30 Sukumar Ghorai wrote:
> The following set of patches applies on linux-2.6.
>
> The main motivations behind this patch series are -
>         1. support NAND I/O in irq mode.
>         2. support of different ECC schema.
>         3. also to make ecc layout as like in romcode ecc layout

Why change the ECC layout?

Be very careful when you change ECC layouts. This can break production 
systems.

For example if people are running something earlier and then want to deliver a 
new kernel with 2.6.37 then their existing NAND file systems will no longer 
be readable.

Changes to ECC should only be done for very good reasons and should be 
controlled with a Kconfig with the default being the existing ECC layout.

-- Charles

