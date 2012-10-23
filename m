From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Tue, 23 Oct 2012 19:18:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210231911500.26503@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com> <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com> <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59818 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab2JWTSX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 15:18:23 -0400
In-Reply-To: <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: balbi@ti.com, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

Hi

On Mon, 22 Oct 2012, Jean Pihet wrote:

> I tried the latest l-o with omap2plus defconfig on my Beagleboard B5
> (ES2.1) and could not reproduce the problem.
> I do not have the I2C error messages at boot, nor at user space start
> up. I tried to read/write the TWL RTC, successfully.
> 
> Another difference is the bootloader images. I have the following:
> - Texas Instruments X-Loader 1.4.2 (Feb  3 2009 - 15:34:17)
> - U-Boot 2009.01-dirty (Feb 19 2009 - 12:22:31)
> Could you send your bootloader images?

Just sent you a link via private E-mail.

> On the PM QoS side the commit 3db11fef moves the I2C code from the
> OMAP PM no-op layer to the PM QoS for CPU and DMA latency, which
> influences the cpuidle states. However CPU_IDLE is not set in
> omap2plus_defconfig so there should not be any effect.
> Do you have CPU_IDLE enabled?

No, it's omap2plus_defconfig.


- Paul
