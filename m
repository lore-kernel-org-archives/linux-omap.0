From: Roger Quadros <rogerq@ti.com>
Subject: Re: Pandaboard: DT Boot fails when initramfs is loaded
Date: Mon, 12 Aug 2013 15:17:07 +0300
Message-ID: <5208D243.6080309@ti.com>
References: <20130811133119.GA15024@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48441 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab3HLMRM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Aug 2013 08:17:12 -0400
In-Reply-To: <20130811133119.GA15024@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-omap@vger.kernel.org

Hi,

On 08/11/2013 04:31 PM, Sebastian Reichel wrote:
> Hi,
> 
> I try to boot the mainline omap kernel (I tried current mainline
> kernel from git and mainline 3.10-rc1+) on my Pandaboard using
> U-Boot as follows:
> 
> mmcinfo
> ext2load mmc 0:2 0x80000000 /boot/uImage
> ext2load mmc 0:2 0x81600000 /boot/uInitrd
> ext2load mmc 0:2 0x90000000 /boot/omap4-panda.dtb
> bootm 0x80000000 0x81600000 0x90000000

What is the size of your uImage and uInitrd? Are you sure the load addresses
are far apart to not cause overwrite?

cheers,
-roger

