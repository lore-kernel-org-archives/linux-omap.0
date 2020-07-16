Return-Path: <SRS0=N3tb=A3=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB5DC433EA
	for <linux-omap@archiver.kernel.org>; Thu, 16 Jul 2020 12:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B9F207BB
	for <linux-omap@archiver.kernel.org>; Thu, 16 Jul 2020 12:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgGPM5m (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbgGPM5m (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jul 2020 08:57:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7813C08C5C0;
        Thu, 16 Jul 2020 05:57:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 32D9D2A56F1
Received: by jupiter.universe (Postfix, from userid 1000)
        id B956A4800FF; Thu, 16 Jul 2020 14:57:37 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 0/4] Subject: panel-dsi-cm: update bindings
Date:   Thu, 16 Jul 2020 14:57:29 +0200
Message-Id: <20200716125733.83654-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The cleanup series for omapdrm's DSI code got too big. Reviewing
this is not fun and the same goes for keeping track of the change
requests. Let's do the cleanup in smaller steps instead. This is
the first batch, which updates the binding (txt -> yaml) and
modifies the DT slightly.

Changes since PATCHv1 [0]:

PATCHv1..PATCHv2:
 * Update binding as suggested by Sam
  * Remove 'port' from required list
  * Drop 'lanes' and 'port' from example ('lanes' is a port property
    used by OMAP's DSI controller)
  * Drop the label from example
  * Add '...' at end of file
 * Fix , in patch description from patch 2
 * Apply Reviewed-by tags

[0] https://lore.kernel.org/dri-devel/20200629223315.118256-1-sebastian.reichel@collabora.com/

-- Sebastian

Sebastian Reichel (4):
  dt-bindings: display: panel-dsi-cm: convert to YAML
  ARM: dts: omap: add channel to DSI panels
  ARM: dts: omap4-droid4: add panel compatible
  ARM: dts: omap4-droid4: add panel orientation

 .../bindings/display/panel/panel-dsi-cm.txt   | 29 -------
 .../bindings/display/panel/panel-dsi-cm.yaml  | 86 +++++++++++++++++++
 .../boot/dts/motorola-mapphone-common.dtsi    |  6 +-
 arch/arm/boot/dts/omap3-n950.dts              |  3 +-
 arch/arm/boot/dts/omap3.dtsi                  |  3 +
 arch/arm/boot/dts/omap4-sdp.dts               |  6 +-
 arch/arm/boot/dts/omap4.dtsi                  |  6 ++
 arch/arm/boot/dts/omap5.dtsi                  |  6 ++
 8 files changed, 111 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/panel-dsi-cm.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-dsi-cm.yaml

-- 
2.27.0

