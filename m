From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 1/5] arm/dts: OMAP4: Update DTS file with new GIC bindings
Date: Mon, 9 Jan 2012 14:31:44 +0100
Message-ID: <4F0AEC40.3040200@ti.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com> <1324388398-2683-2-git-send-email-b-cousson@ti.com> <20120106211558.GA7457@ponder.secretlab.ca> <4F07680E.8000404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52029 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754703Ab2AINb7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jan 2012 08:31:59 -0500
In-Reply-To: <4F07680E.8000404@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 1/6/2012 10:30 PM, Rob Herring wrote:
> On 01/06/2012 03:15 PM, Grant Likely wrote:
>> On Tue, Dec 20, 2011 at 02:39:54PM +0100, Benoit Cousson wrote:
>>> The GIC binding was updated in 3.2 and expect 3 interrupt-cells.
>>> - Update the #interrupt-cells
>>> - interrupt-parent seems to be needed as well for the top level GIC
>>
>> Hmmm... it shouldn't be.  If it is then it is a bug.
> 
> I think this is an old comment which I fixed in 3.2, so interrupt-parent
> can be removed.

I've just tried, and indeed, it works now.

Please find below the patch updated accordingly.

Thanks,
Benoit

---
>From f9ebe0ff11e7cbbba0d7499420ff2f358e44a297 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 25 Nov 2011 12:11:52 +0100
Subject: [PATCH v3 1/5] arm/dts: OMAP4: Update DTS file with new GIC bindings

The GIC binding was updated in 3.2 and expects 3 interrupt-cells.
- Update the #interrupt-cells

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap4.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4c61c82..4b2bff1 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -95,7 +95,7 @@
 		gic: interrupt-controller@48241000 {
 			compatible = "arm,cortex-a9-gic";
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <3>;
 			reg = <0x48241000 0x1000>,
 			      <0x48240100 0x0100>;
 		};
-- 
1.7.0.4


