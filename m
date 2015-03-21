From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 3/4] Documentation: DT: lis302: update wakeup binding
Date: Sat, 21 Mar 2015 21:19:04 +0100
Message-ID: <1426969145-4478-4-git-send-email-sre@kernel.org>
References: <1426969145-4478-1-git-send-email-sre@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:59432 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbbCUUTj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 21 Mar 2015 16:19:39 -0400
In-Reply-To: <1426969145-4478-1-git-send-email-sre@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Eric Piel <eric.piel@tremplin-utc.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.or>

From: Sebastian Reichel <sre@kernel.or>

This updated the documentation of the DT binding to
describe the added wakeup threshold and second wakeup
engine.

It also adds a note, that the axis values may be
negative.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/misc/lis302.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/lis302.txt b/Documentation/devicetree/bindings/misc/lis302.txt
index 6def86f..2a19bff 100644
--- a/Documentation/devicetree/bindings/misc/lis302.txt
+++ b/Documentation/devicetree/bindings/misc/lis302.txt
@@ -46,11 +46,18 @@ Optional properties for all bus drivers:
 				interrupt 2
  - st,wakeup-{x,y,z}-{lo,hi}:	set wakeup condition on x/y/z axis for
 				upper/lower limit
+ - st,wakeup-threshold:		set wakeup threshold
+ - st,wakeup2-{x,y,z}-{lo,hi}:	set wakeup condition on x/y/z axis for
+				upper/lower limit for second wakeup
+				engine.
+ - st,wakeup2-threshold:	set wakeup threshold for second wakeup
+				engine.
  - st,highpass-cutoff-hz=:	1, 2, 4 or 8 for 1Hz, 2Hz, 4Hz or 8Hz of
 				highpass cut-off frequency
  - st,hipass{1,2}-disable:	disable highpass 1/2.
  - st,default-rate=:		set the default rate
- - st,axis-{x,y,z}=:		set the axis to map to the three coordinates
+ - st,axis-{x,y,z}=:		set the axis to map to the three coordinates.
+				Negative values can be used for inverted axis.
  - st,{min,max}-limit-{x,y,z}	set the min/max limits for x/y/z axis
 				(used by self-test)
 
-- 
2.1.4

