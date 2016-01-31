From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/5] nokia-modem: kernel based PM
Date: Sun, 31 Jan 2016 02:19:42 +0100
Message-ID: <1454203187-688-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Some may remember, that in-kernel modem PM was still on the
TODO list for the N9xx modem driver. This patchset adds this
by hooking to the phonet interface state. In other words:

'ifconfig phonet0 up' will enable the modem and 'ifconfig
phonet0 down' will disable the modem. The actual state is
mapped to the carrier state (which was more or less the
case already).

So using the modem can be done like this now:

0. nokia-modem should be loaded with pm=2
1. ifconfig phonet0 up
2. wait for carrier on phonet0
3. communicate with the modem via isi on phonet0
4. ifconfig phonet0 down

The old pm method (exporting the gpios) is still available
and still the default for now. The plan is to switch the default
pm method in some future kernel release (when support for
the simpler interface has been added to ofono).

-- Sebastian

Sebastian Reichel (5):
  HSI: nokia-modem: simplify kernel access to gpios
  HSI: nokia-modem: kernel based PM
  HSI: ssi-protocol: export modem info via sysfs
  HSI: nokia-modem: drop support for disabled pm
  HSI: ssi-protocol: clear carrier flag on open

 drivers/hsi/clients/nokia-modem.c  | 240 +++++++++++++++++++++++++++++++------
 drivers/hsi/clients/ssi_protocol.c |  56 ++++++++-
 include/linux/hsi/ssi_protocol.h   |  20 ++++
 3 files changed, 277 insertions(+), 39 deletions(-)

-- 
2.7.0.rc3
