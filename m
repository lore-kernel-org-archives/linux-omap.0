From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/5] OMAP: McSPI: Implement McSPI in HWMOD way
Date: Thu, 19 Aug 2010 17:56:43 -0700
Message-ID: <87fwyacd9w.fsf@deeprootsystems.com>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
	<AANLkTikS0tX3GA+1LXnqbZYuuWteOTq7dH13i-icKYD2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36680 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab0HTA4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 20:56:46 -0400
Received: by pvg2 with SMTP id 2so978872pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Aug 2010 17:56:45 -0700 (PDT)
In-Reply-To: <AANLkTikS0tX3GA+1LXnqbZYuuWteOTq7dH13i-icKYD2@mail.gmail.com>
	(Grant Likely's message of "Fri, 13 Aug 2010 16:44:30 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Charulatha V <charu@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, rnayak@ti.com, p-basak2@ti.com, govindraj.raja@ti.com

Grant Likely <grant.likely@secretlab.ca> writes:

> On Fri, Aug 13, 2010 at 8:05 AM, Charulatha V <charu@ti.com> wrote:
>> This patch series implements McSPI Module in HWMOD FW way
>> and use the runtime PM layer.
>
> Hi Charulatha,
>
> I'll go through and review the patches, but I'm unfamiliar with HWMOD.
> Is there a description of HWMOD that you can point me at?

Hi Grant,

If you want to skip my rambling, the source for omap_hwmod is in mainline:

   arch/arm/mach-omap2/omap_hwmod.c
   arch/arm/plat-omap/include/plat/omap_hwmod.h

omap_hwmod is short for OMAP hardware module.  It is essentially a
central way of describing each IP block in an OMAP SoC, and the way they
are connected together to make an SoC.  An omap_hwmod for a given IP
block contains base address, IRQs, DMA channels etc. (as would a device
tree node) but also includes information on any master/slave interfaces
to model how IP blocks are connected on the SoC and many other details.
With my PM hat on, the most important part of an omap_hwmod is that it
also defines lots of details about the PM register and capabilities of a
given IP block.

Part of omap_hwmod is the data (which is now auto-generated for current
and future OMAPs), and the other part is the code.  In the code, the
omap_hwmod layer also provides an API so that functionality common to
all IP blocks (clock management, power states, idle modes, resets, etc.)
can be handled in a common way.

Drivers do not interact directly with omap_hwmod and it is considered
OMAP core code.  In other threads, you've seen a little bit of the
omap_device layer.  The omap_device layer encapsulates the omap_hwmod
layer.  An omap_device consists of at least one (but possibly several)
omap_hwmods.  Drivers do not interact directly with omap_device either,
but instead use runtime PM to trigger the custom bus code which would
call omap_device_* which in turn would call into omap_hwmod_*.  Also,
from the omap_hwmod data, platform_devices are generated (including
resources) so drivers get the common data in standard ways.

So, with that background, we're going through some major work in several
OMAP drivers to convert them to work across multiple OMAP SoCs (OMAP2, 3
and 4.)  To make the drivers more general, this means adding the hwmod
data for the device IP, building the omap_device for the device and
converting the driver to use runtime PM instead of direct clock management.

You see all these changes happening in a single patch because the are
quite dependent on one another.  This driver seems to have needed pretty
significant cleanup as well, so I agree that this last patch should be
broken up into parts.  

I think it could be broken up into at least two parts:
cleanup/restructure work to handle more data coming via platform_data,
followed by the conversion to runtime PM.

Kevin


