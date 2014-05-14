From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Add DRA7xx CPSW Ethernet support in Device Tree
Date: Wed, 14 May 2014 16:12:54 -0700
Message-ID: <20140514231254.GA13427@atomide.com>
References: <1399968246-21166-1-git-send-email-mugunthanvnm@ti.com>
 <5371DD94.1050400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17211 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbaENXM7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 19:12:59 -0400
Content-Disposition: inline
In-Reply-To: <5371DD94.1050400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Mugunthan V N <mugunthanvnm@ti.com> [140513 01:54]:
> Tony/Benoit
> 
> On Tuesday 13 May 2014 01:34 PM, Mugunthan V N wrote:
> > Adding device tree entry for CPSW to make it work in Dual EMAC mode.
> >
> > DRA7 cpsw phy sel driver patch has been pulled in net-next git with the
> > following commit id *d415fa1b88748d664b7b6a310dd8e699d2686cf7*
> >
> > Mugunthan V N (3):
> >   pinctrl: dra7: dt-bindings: add pin off modes for dra7 SoC
> >   arm/dts: dra7xx: Add CPSW and MDIO module nodes for dra7xx
> >   arm/dts: dra7xx: Enable CPSW and MDIO for dra7xx EVM
> >
> >  arch/arm/boot/dts/dra7-evm.dts    | 103 ++++++++++++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/dra7.dtsi       |  59 ++++++++++++++++++++++
> >  include/dt-bindings/pinctrl/dra.h |   8 +++
> >  3 files changed, 170 insertions(+)
> >
> 
> This patch series depends on Cross bar dt patch set
> http://comments.gmane.org/gmane.linux.drivers.devicetree/73025

That's not enabled yet and sounds like it needs some more work.
I suggest you repost this tested without the crossbar.

Regards,

Tony
