From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2 0/3] Add support for charging battery in Nokia RX-51
Date: Tue, 19 Nov 2013 11:18:02 +0100
Message-ID: <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch series finally bringing support for charging battery on
Nokia N900 (RX-51) without any proprietary Nokia bits in userspace.

I removed hook function from bq2415x_charger driver and replaced it
by Jenny TC power_supply notifier code. This simplify usage of
bq2415x driver and also allow adding DT support in future because
driver does not need board specific function anymore (only static data)=
=2E

I tested this series with linux 3.12-rc5 on Nokia N900.

Pali Roh=C3=A1r (3):
  power_supply: Add power_supply notifier
  bq2415x_charger: Use power_supply notifier for automode
  RX-51: Add platform data for bq24150a charger

 arch/arm/mach-omap2/board-rx51-peripherals.c |   17 +++++-
 drivers/power/bq2415x_charger.c              |   77 ++++++++++++++++++=
++------
 drivers/power/power_supply_core.c            |   17 ++++++
 include/linux/power/bq2415x_charger.h        |   48 ++--------------
 include/linux/power_supply.h                 |   10 ++++
 5 files changed, 108 insertions(+), 61 deletions(-)

--=20
1.7.9.5
