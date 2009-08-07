From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Fri, 7 Aug 2009 16:19:18 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620396C928A2@dlee02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52951 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbZHGVTb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 17:19:31 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Used to be you needed to build with CONFIG_ARCH_DISCONTIGMEM_ENABLE did you do this?

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Syed Mohammed, Khasim
> Sent: Friday, August 07, 2009 3:17 PM
> To: linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
> Subject: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
>
> Hi all,
>
> On OMAP3 we are creating a space for DSP components to have shared buffers
> using the boot arguments.
>
> mem=88M@0x80000000 mem=128M@0x88000000
>
> This creates a 40M hole for DSP components, the drivers dynamically do a
> request mem region and ioremap of pre-defined address space with in the 40M
> region.
>
> With the above setup, we see the system running for a while but then ends up
> with exception.
>
> "Unable to handle kernel paging request at virtual address c7381000"
>
> The address reported here is not in kernel space, and this doesn't result in a
> kernel panic.
>
> Other observation:
> - The same setup works fine with no hole or space created. The 40M space for
> DSP components will be allocated at the end (216M).
> - If we increase the mem hole region we can make the system fail with in less
> time.
> - Free returns expected memory map
>
> While I am still debugging the issue, I thought of posting this message to
> know if there are any known issues with ARM architecture in handling such non
> contiguous space / mem hole.
>
> I see some special boot parameters for other architectures like exactmap, we
> don't see similar stuff on ARM. Do we need to port any such support for ARM ?
>
> Kindly advice,
>
> Thanks.
>
> Regards,
> Khasim
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

