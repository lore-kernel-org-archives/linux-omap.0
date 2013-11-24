From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 0/3] DT support for bq2415x
Date: Sun, 24 Nov 2013 17:49:28 +0100
Message-ID: <1385311771-447-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This patchset adds DT support for the bq2415x charger, which is used in=
 the
Nokia N900. The changes depend on Pali Roh=C3=A1r's "[PATCH v2 0/3] Add=
 support for
charging battery in Nokia RX-51" patchset [0].

[0] https://lkml.org/lkml/2013/11/19/106

-- Sebastian

Sebastian Reichel (3):
  power_supply: add power_supply_get_by_phandle
  bq2415x_charger: add DT support
  dt: binding documentation for bq2415x charger

 .../devicetree/bindings/power/bq2415x.txt          | 43 +++++++++++++
 drivers/power/bq2415x_charger.c                    | 72 ++++++++++++++=
++------
 drivers/power/power_supply_core.c                  | 24 ++++++++
 include/linux/power_supply.h                       |  2 +
 4 files changed, 121 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/bq2415x.txt

--=20
1.8.4.3
