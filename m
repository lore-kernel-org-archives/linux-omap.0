From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 6/6] OMAP4: Sync up omap4430 defconfig
Date: Thu, 10 Dec 2009 00:28:12 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309C863E9@dbde02.ent.ti.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
 <1260383350-32681-2-git-send-email-santosh.shilimkar@ti.com>
 <1260383350-32681-3-git-send-email-santosh.shilimkar@ti.com>
 <1260383350-32681-4-git-send-email-santosh.shilimkar@ti.com>
 <1260383350-32681-5-git-send-email-santosh.shilimkar@ti.com>
 <1260383350-32681-6-git-send-email-santosh.shilimkar@ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FAAFE85C@dbde02.ent.ti.com>,<EAF47CD23C76F840A9E7FCE10091EFAB02BC0A8251@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54702 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756888AbZLIS6Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 13:58:24 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A8251@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>

Shilimkar, Santosh wrote:
> > >-----Original Message-----
> > >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> > >Shilimkar, Santosh
> > >Sent: Wednesday, December 09, 2009 12:29 PM
> > >To: tony@atomide.com
> > >Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org; linux@arm.linux.org.uk;
> > >Shilimkar, Santosh
> > >Subject: [PATCH 6/6] OMAP4: Sync up omap4430 defconfig
> > >
> > >Enable minimum features to boot omap4430 on es1.0 samples
> > >
> > >Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > >---
> > > arch/arm/configs/omap_4430sdp_defconfig |  146 ++++++++++++++++++-------------
> > > 1 files changed, 84 insertions(+), 62 deletions(-)
> > >
> > >diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
> > >index a464ca3..49df3ad 100644
> > >--- a/arch/arm/configs/omap_4430sdp_defconfig
> > >+++ b/arch/arm/configs/omap_4430sdp_defconfig
> > >@@ -1,26 +1,29 @@
> > > #
> > > # Automatically generated make config: don't edit
> > >-# Linux kernel version: 2.6.30-rc7
> > >-# Tue Jun  9 12:36:23 2009
> > >+# Linux kernel version: 2.6.32
> > >+# Sun Dec  6 23:37:45 2009
> > <snip>
> > >-# CONFIG_SYSFS_DEPRECATED=y is not set
> > >-# CONFIG_SYSFS_DEPRECATED_V2=y is not set
> > >+CONFIG_SYSFS_DEPRECATED_V2=y
> >
> > This is a deprecated feature and don't introduce it back again.
> > There haven been patches in recent past to get rid of this.
> Thanks Vikram. The thing is some of the busy box people are using get confused
> and stuck without this.
> 
> Do you have pointers to those patches ?
> 

Poky, and other open-embedded based distros expect this to
be disabled to work correctly

The solution is to upgrade busybox, not enable a deprecated
CONFIG option.

Patches to update the different OMAP defconfig were posted
to l-o a few months ago.

Here's one.such patch.
<http://patchwork.kernel.org/patch/40949/>

- Anand
