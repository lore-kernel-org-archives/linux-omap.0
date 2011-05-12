From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] omap: rx51: Don't power up speaker amplifier at bootup
Date: Thu, 12 May 2011 14:28:23 +0300
Message-ID: <1305199703-32589-2-git-send-email-jhnikula@gmail.com>
References: <1305199703-32589-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1305199703-32589-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vget.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Speaker amplifier is accidentally powered up in early TWL gpio setup. This
causes a few mA of needless battery current consumption. Without this patch
the amplifier can be shutdown only by having one active audio playback and
shutdown cycle to speaker output.

Thanks to Kalle Jokiniemi <kalle.jokiniemi@nokia.com> for noticing the issue.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 8242e99..0374562 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -561,7 +561,7 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 	gpio_request(gpio + 6, "backlight_pwm");
 	gpio_direction_output(gpio + 6, 0);
 	gpio_request(gpio + 7, "speaker_en");
-	gpio_direction_output(gpio + 7, 1);
+	gpio_direction_output(gpio + 7, 0);
 
 	return 0;
 }
-- 
1.7.4.4
