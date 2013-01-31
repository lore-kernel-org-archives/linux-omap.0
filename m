From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Failure to boot...
Date: Thu, 31 Jan 2013 13:04:37 +0000
Message-ID: <20130131130437.GP2637@n2100.arm.linux.org.uk>
References: <20130131014912.GM2637@n2100.arm.linux.org.uk> <20130131030203.GA8374@quad.lixom.net> <alpine.LFD.2.02.1301302312030.6300@xanadu.home> <20130131092024.GN2637@n2100.arm.linux.org.uk> <20130131104044.GO2637@n2100.arm.linux.org.uk> <510A6877.9080307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60062 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab3AaNEt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 08:04:49 -0500
Content-Disposition: inline
In-Reply-To: <510A6877.9080307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 31, 2013 at 06:19:59PM +0530, Santosh Shilimkar wrote:
> On Thursday 31 January 2013 04:10 PM, Russell King - ARM Linux wrote:
>> On Thu, Jan 31, 2013 at 09:20:24AM +0000, Russell King - ARM Linux w=
rote:
>>> On Wed, Jan 30, 2013 at 11:19:40PM -0500, Nicolas Pitre wrote:
>>>> Better yet (IMHO): just enable the zboot command in U-Boot to let =
you
>>>> boot a zImage binary directly.
>>>
>>> I wish it were that easy but it isn't.  I've no idea where to get a
>>> version of uboot for my boards which supports that; TI have always
>>> supplied updates to uboot for me, and with the current state of TI
>>> being afaict in chaos.
>>>
>>> TI have always supplied a replacement X-Loader with each uboot upda=
te.
>>> I've no idea what X-Loader is or why both get updated together, but=
=2E..
>>>
>>> Moreover, I doubt that the 3430LDP, of which there are multiple ver=
sions,
>>> will ever see a uboot update.  It already suffers from a lack of co=
rrect
>>> kernel support due to random wiring changes between these versions =
(the
>>> keypad doesn't work correctly) and I've yet to indentify which vers=
ion
>>> it is despite downloading the circuits.  So trying to locate the ri=
ght
>>> uboot will be impossible there.
>>>
>>> So, I'm _stuck_ with uImages for these platforms.
>>
>> Right, so I'm now passing LOADADDR=3D which allows this to work - an=
d the
>> latest OMAP4430SDP boot result shows almost the same sad broken stor=
y.
>>
> I just tried latest mainline (commit: 04c2eee5) and default config
> just boots fine.

Please read the notes at the bottom of the page, specifically:
 *=A0Build tree is currently created on an ad-hoc basis from Linus' tip=
, rmk's
   development tip and arm-soc for-next branches.

This system does *not* build and boot vanilla mainline kernels.  It is
(as the above says):

- Linus' tip
- My for-next plus a few other bits
- arm-soc for-next

all merged together.

Here's the diffstat between my for-next and the remainder of other stuf=
f
that gets built:

 arch/arm/mach-realview/core.c                   |  212 ++++++++
 arch/arm/mach-realview/core.h                   |    2 +
 arch/arm/mach-realview/include/mach/platform.h  |    2 +
 arch/arm/mach-realview/realview_eb.c            |   37 ++-
 arch/arm/mach-realview/realview_pb11mp.c        |   33 ++-
 arch/arm/mach-realview/realview_pba8.c          |    3 +-
 arch/arm/mach-realview/realview_pbx.c           |    3 +-
 arch/arm/mach-versatile/core.c                  |  482 +++++++++++++++=
+++-
 arch/arm/mach-versatile/include/mach/platform.h |    6 +
 arch/arm/mach-versatile/versatile_pb.c          |   17 +-
 drivers/dma/amba-pl08x.c                        |   26 +-
 drivers/tty/serial/omap-serial.c                |   30 ++
 drivers/tty/serial/serial_core.c                |   23 +-
 include/linux/serial_core.h                     |    2 +
 include/sound/soc-dmaengine.h                   |   26 +
 sound/soc/Kconfig                               |    5 +
 sound/soc/Makefile                              |    3 +
 sound/soc/sa11x0/Kconfig                        |   14 +
 sound/soc/sa11x0/Makefile                       |    5 +
 sound/soc/sa11x0/sa11x0-assabet.c               |  432 +++++++++++++++=
++
 sound/soc/sa11x0/sa11x0-ssp.c                   |  345 +++++++++++++
 sound/soc/sa11x0/sa11x0-ssp.h                   |   11 +
 sound/soc/soc-dmaengine.c                       |  591 +++++++++++++++=
++++++++
 23 files changed, 2283 insertions(+), 27 deletions(-)

As far as OMAP goes, that's basically additional bits for serial DMA
support that I was working on, best pieced back together before the
serial driver was majorly reworked a couple of merge windows ago.
These have been there for at least the last three months.

The rest are for SA11x0 Assabet sound support, and DMA support on
Versatile/Realview platforms.

> I was looking at your build system output which shows the boot
> state "OMAP4430 SDP: fail". Your config seems to be with
> CONFIG_ARCH_MULTIPLATFORM=3Dy and indeed this kernel doesn't
> boot. Seems to abort very early in boot. Am looking at it.

Thanks.

> P.S Btw, the load address issue with multi-platform build
> was highlighted on the list in past by Tony [1]
>
> [1] http://www.spinics.net/lists/linux-omap/msg84146.html

That's no good to me if it only goes to linux-omap.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
