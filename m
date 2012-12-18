From: Loic Pallardy <loic.pallardy-ext@stericsson.com>
Subject: [PATCH 7/9] mailbox: add IRQF_NO_SUSPEND flag
Date: Tue, 18 Dec 2012 14:10:10 +0100
Message-ID: <1355836212-17956-8-git-send-email-loic.pallardy-ext@stericsson.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Loic PALLARDY <loic.pallardy@st.com>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Linus Walleij <linus.walleij@linaro.org>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Loic Pallardy <loic.pallardy-ext@stericsson.com>
List-Id: linux-omap@vger.kernel.org

Coprocessor must be accessible during suspend transitions.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/mailbox/mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index c0a8e49..57cb566 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -311,7 +311,8 @@ static int mailbox_startup(struct mailbox *mbox)
 	}
 
 	if (!mbox->use_count++) {
-		ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
+		ret = request_irq(mbox->irq, mbox_interrupt,
+				IRQF_SHARED | IRQF_NO_SUSPEND,
 				mbox->name, mbox);
 		if (unlikely(ret)) {
 			pr_err("failed to register mailbox interrupt:%d\n",
-- 
1.7.11.1
