From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 141/304] ARM: OMAP1: ams-delta: Fix audio permanently muted
Date: Mon, 28 Jan 2019 10:40:58 -0500
Message-ID: <20190128154341.47195-141-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

[ Upstream commit 2afdb4c41d7876e430b9bc6e2d7e2fe28609fd6a ]

Since commit 1137ceee76ba ("ARM: OMAP1: ams-delta: Don't request unused
GPIOs"), on-board audio has appeared muted.  Believed to be unused GPIO
pin "hookflash1", apparently set high regardless of the corresponding
bit of "latch2" port attempted to be set low during .init_machine(),
has been identified as the reason.

According to Amstrad E3 wiki, the purpose of the pin hasn't been
clearly identified.  Original Amstrad software used to produce a high
pulse on it when the phone was taken off hook or recall was pressed.
With the current finding, we can assume the pin provides a kind of
audio mute function.

Proper resolution of the issue should be done in two steps:
- resolution of an issue with the pin state not reflecting the value
  the corresponding bit of the port was attempted to be initialized
  with,
- extension of on-board audio driver with a new control.

For now, rename the pin to "audio_mute" to reflect its function and,
as a quick fix, hogg it as output low so on-board audio can produce
audible sound again.

Fixes: 1137ceee76ba ("ARM: OMAP1: ams-delta: Don't request unused GPIOs")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap1/board-ams-delta.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 17886744dbe6..55bf73710a59 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -247,8 +247,8 @@ static struct platform_device latch2_gpio_device = {
 #define LATCH2_PIN_SCARD_CMDVCC		11
 #define LATCH2_PIN_MODEM_NRESET		12
 #define LATCH2_PIN_MODEM_CODEC		13
-#define LATCH2_PIN_HOOKFLASH1		14
-#define LATCH2_PIN_HOOKFLASH2		15
+#define LATCH2_PIN_AUDIO_MUTE		14
+#define LATCH2_PIN_HOOKFLASH		15
 
 static struct regulator_consumer_supply modem_nreset_consumers[] = {
 	REGULATOR_SUPPLY("RESET#", "serial8250.1"),
@@ -588,6 +588,8 @@ static int gpiochip_match_by_label(struct gpio_chip *chip, void *data)
 static struct gpiod_hog ams_delta_gpio_hogs[] = {
 	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT, "keybrd_dataout",
 		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
+	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_AUDIO_MUTE, "audio_mute",
+		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
 	{},
 };
 
-- 
2.19.1
