From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next,
 working on 3.2
Date: Thu, 4 Oct 2012 22:57:04 +0200
Message-ID: <20121004225704.0c08c862@skate>
References: <20120504155255.140b4e3f@skate>
	<87397fewso.fsf@ti.com>
	<20120504175124.GI5613@atomide.com>
	<878vh78q7b.fsf@ti.com>
	<20121004180747.3b342904@skate>
	<87vcequpf7.fsf@deeprootsystems.com>
	<20121004221118.4316181d@skate>
	<CAKQ2WVp71=ULs_yK7Tkuo=8F4hATq0YCQ6RtV0ziJQQmnrib_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:46304 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab2JDU5P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 16:57:15 -0400
In-Reply-To: <CAKQ2WVp71=ULs_yK7Tkuo=8F4hATq0YCQ6RtV0ziJQQmnrib_g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?UTF-8?B?QmFsbGV0YsOy?= i Serra <eballetbo@iseebcn.com>
Cc: linux-omap@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Kevin Hilman <khilman@deeprootsystems.com>, Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>


On Thu, 4 Oct 2012 22:30:58 +0200, Enric Balletb=C3=B2 i Serra wrote:

> I recently tested kernel 3.6-rc5 and worked for me. Let me check tomo=
rrow
> kernel 3.6. Which u-boot version are you using?

2011.12 + a few patches to make the NAND of the IGEPv2 rev6 work. Let
me try to build a recent U-Boot (which now includes the SPL for the
IGEP) and see if it improves the situation.

However, I believe that the rule is that the kernel shouldn't depend
too much on initialization done by the bootloader, so it still seems
like an issue to me.

Best regards,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
