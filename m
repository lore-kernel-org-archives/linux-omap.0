From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Thu, 31 Mar 2011 17:53:04 +0300 (EEST)
Message-ID: <alpine.DEB.1.10.1103311722520.2634@esdhcp041196.research.nokia.com>
References: <20110314192538.GH7258@atomide.com> <alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com> <4D7FC70D.7050508@ti.com> <alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com> <4D80CA2F.8060300@ti.com>
 <alpine.DEB.1.10.1103161903250.2634@esdhcp041196.research.nokia.com> <20110329233243.GR4016@atomide.com> <87lizwskcc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:23229 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758063Ab1CaOz6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 10:55:58 -0400
In-Reply-To: <87lizwskcc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, nicolas.pitre@linaro.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 30 Mar 2011, Kevin Hilman wrote:
> Tony Lindgren <tony@atomide.com> writes:
>> FYI, looks like we've started hitting some booter -l kernel size limit
>> in addition to booter -f size limit.. Now kernels built with
>> omap2plus_defconfig won't boot on n900 any longer.

I guess you are seeing it just hanging at "Uncompressing Linux... done,
booting the kernel."?

>> I guess the way around that is to install the u-boot loader package.
>
> Alternatively CONFIG_KERNEL_LZMA=y will get the kernel zImage size back
> within size limits that will boot on n900.

Hmm, I'm a bit puzzled. For me, .38 works but .39-rc1 does not, and I
can't see any "special" limit exceeded. Also LZMA is broken:

 	Uncompressing Linux...

 	LZMA data is corrupt

 	-- System halted

I did some bisecting, and with the following commit reverted -rc1 works:

 	commit d239b1dc093d551046a909920b5310c1d1e308c1
 	Author: Nicolas Pitre <nicolas.pitre@linaro.org>
 	Date:   Mon Feb 21 04:57:38 2011 +0100

 	ARM: 6746/1: remove the 4x expansion presumption while decompressing the kernel

With the revert, also bigger gzipped kernel works.

A.
