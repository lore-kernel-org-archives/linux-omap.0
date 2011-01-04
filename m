From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v3 1/4] TI816X: Update common omap platform files
Date: Tue, 4 Jan 2011 23:08:37 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A57AF93@dbde02.ent.ti.com>
References: <1294075737-22320-1-git-send-email-hemantp@ti.com>
 <alpine.DEB.2.00.1101031603070.10403@utopia.booyaka.com>
 <20110104015008.GX7771@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51126 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab1ADRjm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 12:39:42 -0500
In-Reply-To: <20110104015008.GX7771@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Tony Lindgren wrote on Tuesday, January 04, 2011 7:20 AM:

> * Paul Walmsley <paul@pwsan.com> [110103 15:06]:
>> Hello Hemant
>> 
>> On Mon, 3 Jan 2011, Hemant Pedanekar wrote:
>> 
>>> This patch updates the common platform files with TI816X support. Also
>>> adds new files for TI816X modules base addresseses and irq definitions.
>>> 
>>> The approach taken in this patch is to add TI816X as part of OMAP3
>>> variant where the cpu class is considered as OMAP34XX and the type is
>>> TI816X. This means, both cpu_is_omap34xx() and cpu_is_ti816x() checks
>>> return success on TI816X. 
>> 
>> Looks like you should add a CONFIG_ARCH_OMAPTI816X Kconfig option for this
>> chip.  I suspect that many handheld device manufacturers won't want to
>> include TI816X-specific code/data in their builds, and vice versa.
> 
> Please use CONFIG_SOC_OMAPTI816X instead, eventually we should use
> CONFIG_ARCH_OMAPX only for something that requires different compiler
> options. 
> 
> Regards,
> 
> Tony

Thanks Tony and Paul for comments.

This means following cases need to handle:
1) Multi-OMAP build.
2) OMAP3 build for OMAP3xxx as well as TI816X SoCs - have precedence to default
OMAP3 only build at most of the places. Note that this build will not really be
optimized for either of them - some areas being irq macro, clock data handling
with various run time checks being executed, few cpu_is_ti816x checks being
executed etc.
3) OMAP3 build for OMAP3xxx SoCs only - This should be same as having
CONFIG_ARCH_OMAP3 alone as earlier without TI816X patches. Thus,
CONFIG_SOC_OMAPTI816X should  be disabled in this case.
4) OMAP3 build for TI816X only - CONFIG_SOC_OMAPTI816X should be enabled here,
which should lead to apply TI816X specific changes to OMAP3 code.

Am I getting this correct? Looking at above, it seems another config option like
CONFIG_SOC_OMAP3XXX is also needed in addition to CONFIG_SOC_OMAPTI816X.

Please let me know your comments about this.

Thanks 
-
Hemant