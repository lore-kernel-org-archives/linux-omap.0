From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 4/4] ARM: dts: AM33XX: Add lis331dlh device tree data
 to am335x-evm
Date: Mon, 17 Sep 2012 15:35:59 -0700
Message-ID: <20120917153559.e07ca263.akpm@linux-foundation.org>
References: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
	<1347866602-2088-5-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57267 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670Ab2IQWgB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 18:36:01 -0400
In-Reply-To: <1347866602-2088-5-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, eric.piel@tremplin-utc.net, jic23@cam.ac.uk, greg@kroah.com, broonie@opensource.wolfsonmicro.com, dmitry.torokhov@gmail.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

On Mon, 17 Sep 2012 12:53:22 +0530
AnilKumar Ch <anilkumar@ti.com> wrote:

> Add lis331dlh device tree data to am335x-evm.dts. In AM335x EVM
> lis331dlh accelerometer is connected to I2C2 bus. So this patch
> change the status of I2C2 node to "okay" to use I2C2 bus. Also
> added all the required platform data to am335x-evm.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am335x-evm.dts |   39 ++++++++++++++++++++++++++++++++++++++

Your arch/arm/boot/dts/am335x-evm.dts differs significantly from the
one in linux-next (it should not do so), so I didn't do anything with
this patch.
