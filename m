From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: Audio support via omap-twl4030 and pwm
 support
Date: Wed, 6 Feb 2013 08:21:56 +0100
Message-ID: <51120494.6020407@ti.com>
References: <50FE64DC.2030808@ti.com> <510788B9.9050907@ti.com> <20130130220532.GA22517@atomide.com> <20130204195251.GS22517@atomide.com> <5110D4ED.6030306@ti.com> <20130205184014.GK25185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39982 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172Ab3BFHWA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Feb 2013 02:22:00 -0500
In-Reply-To: <20130205184014.GK25185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/05/2013 07:40 PM, Tony Lindgren wrote:
>> For some reason the CONFIG_DEBUG_SECTION_MISMATCH got disabled in my=
 rolling
>> kernel config...
>=20
> At least gcc version 4.3.5 (Debian 4.3.5-4) shows them. What's
> the compiler you have?=20

It show for me as well now that I have enabled the
CONFIG_DEBUG_SECTION_MISMATCH in my config.

My GCC is:
armv7a-hardfloat-linux-gnueabi-gcc (Gentoo 4.7.2 p1.3, pie-0.5.5) 4.7.2

> Yes let's do that rather than start copying things around. I'll apply
> the following fix to the omap-for-v3.9/twl branch.

Cool, thanks Tony. I will drop my patch and pick the one from omap-for-=
v3.9/twl.

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
