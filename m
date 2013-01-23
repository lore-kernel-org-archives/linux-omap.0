From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/2] ARM: dts: omap3-overo: Add pwm-leds and audio support
Date: Wed, 23 Jan 2013 18:56:50 +0100
Message-ID: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>
List-Id: linux-omap@vger.kernel.org

Hello Benoit,

This patchset adds some new DT supports to the Overo products.
The first patch converts the PMIC LEDB output to use the pwm-leds,
newly merged in your branch for_3.9/dts. The second patch
adds the audio support.

Best regards,

Florian

Florian Vaussard (2):
  ARM: dts: omap3-overo: Add support for pwm-leds
  ARM: dts: omap3-overo: Add audio support

 arch/arm/boot/dts/omap3-overo.dtsi |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

-- 
1.7.5.4
