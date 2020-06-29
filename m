Return-Path: <SRS0=sQ2K=AK=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDDEC433E5
	for <linux-omap@archiver.kernel.org>; Mon, 29 Jun 2020 22:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F8721532
	for <linux-omap@archiver.kernel.org>; Mon, 29 Jun 2020 22:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgF2We6 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:34:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54002 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgF2We5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2020 18:34:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CD9AD2A1386
Received: by jupiter.universe (Postfix, from userid 1000)
        id B9E51480102; Tue, 30 Jun 2020 00:34:50 +0200 (CEST)
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
Subject: [PATCHv1 0/4] panel-dsi-cm: update bindings
Date:   Tue, 30 Jun 2020 00:33:11 +0200
Message-Id: <20200629223315.118256-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Subject: panel-dsi-cm: update bindings

The cleanup series for omapdrm's DSI code got too big. Reviewing
this is not fun and the same goes for keeping track of the change
requests. Let's do the cleanup in smaller steps instead. This is
the first batch, which updates the binding (txt -> yaml) and
modifies the DT slightly.

-- Sebastian

Sebastian Reichel (4):
  dt-bindings: display: panel-dsi-cm: convert to YAML
  ARM: dts: omap: add channel to DSI panels
  ARM: dts: omap4-droid4: add panel compatible
  ARM: dts: omap4-droid4: add panel orientation

 .../bindings/display/panel/panel-dsi-cm.txt   |  29 -----
 .../bindings/display/panel/panel-dsi-cm.yaml  | 100 ++++++++++++++++++
 .../boot/dts/motorola-mapphone-common.dtsi    |   6 +-
 arch/arm/boot/dts/omap3-n950.dts              |   3 +-
 arch/arm/boot/dts/omap3.dtsi                  |   3 +
 arch/arm/boot/dts/omap4-sdp.dts               |   6 +-
 arch/arm/boot/dts/omap4.dtsi                  |   6 ++
 arch/arm/boot/dts/omap5.dtsi                  |   6 ++
 8 files changed, 125 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/panel-dsi-cm.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-dsi-cm.yaml

-- 
2.27.0

