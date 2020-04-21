Return-Path: <SRS0=Pap7=6F=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62E3C55186
	for <linux-omap@archiver.kernel.org>; Tue, 21 Apr 2020 23:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E44D20724
	for <linux-omap@archiver.kernel.org>; Tue, 21 Apr 2020 23:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgDUX2A (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 21 Apr 2020 19:28:00 -0400
Received: from muru.com ([72.249.23.125]:50810 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUX2A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 21 Apr 2020 19:28:00 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A6D8B8081;
        Tue, 21 Apr 2020 23:28:45 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Lee Jones <lee.jones@linaro.org>, Jiri Slaby <jslaby@suse.cz>,
        Johan Hovold <johan@kernel.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCHv6 0/4] n_gsm serdev support and protocol driver for droid4 modem
Date:   Tue, 21 Apr 2020 16:27:48 -0700
Message-Id: <20200421232752.3070-1-tony@atomide.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

Here's v4 set of n_gsm serdev support patches, and the related protocol
driver for the modem found on Motorola Mapphone phones and tablets
like droid4.

This series only adds basic character device support for the serdev
driver. Other serdev consumer drivers for specific devices will be
posted separately.

The patches are against v5.6-rc series.

Regards,

Tony


Changes since v5:
- Cosmetic fixes for issues noted by Pavel

Changes since v4:
- Use drivers/tty/serdev/protocol directory for the driver instead of
  drivers/mfd as discussed on the lists for v3 set of patches
- Fix remove to call kfree only after removing device from the list

Changes since v3:
- Update list of folks in Cc, looks like I sent v3 only to Lee and lkml
- Init privdata before motmdm_register_dlci calls gsm_serdev_register_dlci
- Update binding based on Rob's comments for license and "allOf"

Changes since v2:
- Drop useless send_command indirection, use static motmdm_send_command

Changes since v1:

- Simplified usage and got rid of few pointless inline functions
- Added consumer MFD driver, devicetree binding, and dts changes


Tony Lindgren (4):
  tty: n_gsm: Add support for serdev drivers
  serdev: ngsm-motmdm: Add Motorola TS 27.010 serdev modem driver for
    droid4
  dt-bindings: serdev: motmdm: Add binding for motorola-mdm
  ARM: dts: omap4-droid4: Enable basic modem support

 .../serdev/motorola,mapphone-mdm6600.yaml     |   34 +
 .../boot/dts/motorola-mapphone-common.dtsi    |    6 +
 drivers/tty/n_gsm.c                           |  372 +++++
 drivers/tty/serdev/Kconfig                    |    2 +
 drivers/tty/serdev/Makefile                   |    2 +
 drivers/tty/serdev/protocol/Kconfig           |   14 +
 drivers/tty/serdev/protocol/Makefile          |    3 +
 .../tty/serdev/protocol/serdev-ngsm-motmdm.c  | 1191 +++++++++++++++++
 include/linux/serdev-gsm.h                    |  168 +++
 9 files changed, 1792 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serdev/motorola,mapphone-mdm6600.yaml
 create mode 100644 drivers/tty/serdev/protocol/Kconfig
 create mode 100644 drivers/tty/serdev/protocol/Makefile
 create mode 100644 drivers/tty/serdev/protocol/serdev-ngsm-motmdm.c
 create mode 100644 include/linux/serdev-gsm.h

-- 
2.26.2
