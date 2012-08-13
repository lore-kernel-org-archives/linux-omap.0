From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] mfd/regulator: tps65217: Move regulator plat data
 handling to regulator
Date: Mon, 13 Aug 2012 08:23:54 -0700
Message-ID: <20120813152354.GB5745@kroah.com>
References: <1344870365-11645-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40992 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab2HMPYA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Aug 2012 11:24:00 -0400
Received: by yenl14 with SMTP id l14so2038650yen.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Aug 2012 08:23:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344870365-11645-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, dan.carpenter@oracle.com, rdunlap@xenotime.net, sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-omap@vger.kernel.org, stable@vger.kernel.org

On Mon, Aug 13, 2012 at 08:36:05PM +0530, AnilKumar Ch wrote:
> Regulator platform data handling was mistakenly added to MFD
> driver. So we will see build errors if we compile MFD drivers
> without CONFIG_REGULATOR. This patch moves regulator platform
> data handling from TPS65217 MFD driver to regulator driver.
> 
> This makes MFD driver independent of REGULATOR framework so
> build error is fixed if CONFIG_REGULATOR is not set.
> 
> drivers/built-in.o: In function `tps65217_probe':
> tps65217.c:(.devinit.text+0x13e37): undefined reference
> to `of_regulator_match'
> 
> This patch also fix allocation size of tps65217 platform data.
> Current implementation allocates a struct tps65217_board for each
> regulator specified in the device tree. But the structure itself
> provides array of regulators so one instance of it is sufficient.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> This patch is tested on BeagleBone with regulator device node
> additions. And this is based on mfd/master.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
