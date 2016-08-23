From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 0/2] AM335x-ICE: Add support for rotary switch
Date: Tue, 23 Aug 2016 11:46:47 +0530
Message-ID: <20160823061649.3394-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <moritz.fischer@ettus.com>, John Stultz <john.stultz@linaro.org>, Vignesh R <vigneshr@ti.com>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Daniel Hung-yu Wu <hywu@google.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Grant Grundler <grundler@chromium.org>, Rob Herring <robh+dt@kernel.org>, S Twiss <stwiss.opensource@diasemi.com>, linux-input@vger.kernel.org, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This series adds support for rotary-switch on AM335x-ICE that is
connected to TI PCA9536 I2C GPIO expander.
First patch adds new generic driver to read status of group of GPIO
lines and report the value as an input event. The second patch adds DT
entries for the same.

v1: https://lkml.org/lkml/2016/8/12/7

Vignesh R (2):
  input: misc: Add generic input driver to read encoded GPIO lines
  ARM: dts: am335x-icev2: Add nodes for gpio-decoder

 .../devicetree/bindings/input/gpio-decoder.txt     |  23 ++++
 arch/arm/boot/dts/am335x-icev2.dts                 |   9 ++
 drivers/input/misc/Kconfig                         |  12 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/gpio_decoder.c                  | 130 +++++++++++++++++++++
 5 files changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-decoder.txt
 create mode 100644 drivers/input/misc/gpio_decoder.c

-- 
2.9.2
