From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 0/7] omap: mailbox: hwmod support and dependent cleanup
 patches
Date: Sat, 06 Nov 2010 14:32:45 -0400
Message-ID: <4CD59F4D.8070903@ti.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48546 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804Ab0KFSck (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 6 Nov 2010 14:32:40 -0400
In-Reply-To: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11/5/2010 9:17 PM, Ramirez Luna, Omar wrote:
> hwmod support for omap2 and omap3 chips, plus cleanups.
>
> Tested on 3430 and 3630
>
> ** v2 **
> - Added omap4 hwmod support.
> - Moved "mailbox_ick" from hwmod to hwmod_if (omap 2/3)
> - Declared sysc classes for omap 2/3
>
> ** v1 **
> 1. omap: mailbox: initial hwmod support for omap3
> Changes were made to:
> - Rebase to latest code.
> - Detect the hwmod by filling prcm union for omap2, without
>    this it was unable to build the hwmod at runtime.
> - Replace magic number for defines.
> - Use ioremap again instead of relying on the one made by hwmod,
>    as noted in http://patchwork.kernel.org/patch/101661/
>
> 2. omap: mailbox: initial hwmod support for omap2
> Was only compiled tested!! Unfortunately I don't have the HW for it.
>
> 4. omap: mailbox: fix detection for previously supported chips
> Original patch was using features framework, but when compiled as a module
> it was breaking, this patch uses cpu_is_omap34xx macro instead. This is
> meant as a short term solution until proper cleanup is done, as suggested in:
>
> http://marc.info/?l=linux-arm-kernel&m=128534253231481&w=2
>
> Benoit Cousson (1):
>    OMAP4: hwmod data: add mailbox data
>
> Felipe Contreras (3):
>    OMAP3: hwmod data: add mailbox data
>    omap: mailbox: initial hwmod support
>    omap: mailbox: add omap_device latency information

Could you please try to use a consistent naming in the subject?
You use OMAP3, OMAP4, OMAP2 so it should be OMAP and not omap.

Thanks,
Benoit


>
> Omar Ramirez Luna (3):
>    OMAP2: hwmod data: add mailbox data
>    omap: mailbox: fix detection for previously supported chips
>    omap: mailbox: remove unreachable return
>
>   arch/arm/mach-omap2/devices.c              |  104 +++++++---------------------
>   arch/arm/mach-omap2/mailbox.c              |   39 +++++-----
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |   67 ++++++++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |   66 ++++++++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   66 ++++++++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   63 +++++++++++++++++
>   arch/arm/plat-omap/include/plat/mailbox.h  |    6 ++
>   7 files changed, 311 insertions(+), 100 deletions(-)
>

