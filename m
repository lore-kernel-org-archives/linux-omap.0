From: tony@atomide.com
Subject: Checklist for submitting omap patches
Date: Fri, 28 Apr 2006 01:48:03 -0700
Message-ID: <20060428084803.GF31797@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

Following a short checklist for submitting omap patches. I've
also posted it to:

http://www.muru.com/linux/omap/README_OMAP_PATCHES

Does anybody have comments or something that should be added?

Regards,

Tony


Submitting OMAP patches version 20060428

As linux-omap tree is almost in sync with the mainline kernel, all core
omap patches need to in suitable format for sending upstream.

The reason for this is to produce a clean revision history, make
maintenance easier, and give proper credit to the patch author.

The core omap patches include anything that touches the following
directories:

arch/arm/plat-omap
arch/arm/mach-omap1
arch/arm/mach-omap2
include/asm-arm/arch-omap

Anything else is considered non-core omap code, and must be in separate
patches.

When submitting a patch, please check the following:

- Patch follows linux/Documentation/CodingStyle

- Patch follows linux/Documentation/SubmittingPatches

- Patch subject must be [PATCH] ARM: OMAP: Subject of the patch

- Patch body must contain short description of the patch

- Patch body must contain proper Signed-off-by: line

- Non-core patches are in separate patches
