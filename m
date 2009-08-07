From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Sat, 8 Aug 2009 01:46:35 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49256 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933625AbZHGUQu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 16:16:50 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

On OMAP3 we are creating a space for DSP components to have shared buffers using the boot arguments.

mem=88M@0x80000000 mem=128M@0x88000000

This creates a 40M hole for DSP components, the drivers dynamically do a request mem region and ioremap of pre-defined address space with in the 40M region.

With the above setup, we see the system running for a while but then ends up with exception. 

"Unable to handle kernel paging request at virtual address c7381000"

The address reported here is not in kernel space, and this doesn't result in a kernel panic.

Other observation:
- The same setup works fine with no hole or space created. The 40M space for DSP components will be allocated at the end (216M).
- If we increase the mem hole region we can make the system fail with in less time.
- Free returns expected memory map

While I am still debugging the issue, I thought of posting this message to know if there are any known issues with ARM architecture in handling such non contiguous space / mem hole.

I see some special boot parameters for other architectures like exactmap, we don't see similar stuff on ARM. Do we need to port any such support for ARM ?

Kindly advice,

Thanks.

Regards,
Khasim

