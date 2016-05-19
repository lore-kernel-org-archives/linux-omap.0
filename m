From: Vignesh R <vigneshr@ti.com>
Subject: [RFC PATCH 0/2] AM335x-ICE: Add support for rotary-encoder
Date: Thu, 19 May 2016 14:33:59 +0530
Message-ID: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Johan Hovold <johan@kernel.org>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Vignesh R <vigneshr@ti.com>, Masanari Iida <standby24x7@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, S Twiss <stwiss.opensource@diasemi.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Moritz Fischer <moritz.fischer@ettus.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Timo Teras <timo.teras@iki.fi>, Guido Martinez <guido@vanguardiasur.com.ar>, Clifton Barnes <clifton.a.barnes@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


This series adds support for rotary-encoder on AM335x-ICE that is
connected to TI PCA9536 I2C GPIO expander.

The rotary encoder is different from the incremental encoders in the
sense that GPIO line status directly reflect the position(number)
pointed by the dial of the encoder. So, there is no need to count steps
or know the direction of rotation. Patch 1/2 adds DT property
"rotary-encoder,absolute-encoder" to support this encoder. Since, such
encoders do not actually require IRQ lines (as the encoder state can
always be known by reading GPIO lines at that moment), support for
polling based input is added.
The second patch adds DT entry for the rotary-encoder present on
AM335x ICE board.

Tested on AM335x ICE board that has above described rotary-encoder
without IRQs (polling mode).
I don't have hardware with incremental encoder or encoder with IRQ,
please give it a spin on incremental encoders for sanity.

Vignesh R (2):
  Input: rotary-encoder- Add support for absolute encoder
  ARM: dts: am335x-icev2: Add rotary-encoder node

 .../devicetree/bindings/input/rotary-encoder.txt   |   4 +
 Documentation/input/rotary-encoder.txt             |   9 ++
 arch/arm/boot/dts/am335x-icev2.dts                 |  11 ++
 drivers/input/misc/Kconfig                         |  11 ++
 drivers/input/misc/rotary_encoder.c                | 165 ++++++++++++++++-----
 5 files changed, 166 insertions(+), 34 deletions(-)

-- 
2.8.2
