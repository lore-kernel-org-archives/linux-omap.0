From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 08/13] mailbox: add IRQF_NO_SUSPEND flag
Date: Mon, 11 Feb 2013 22:57:07 -0600
Message-ID: <1360645032-9668-9-git-send-email-s-anna@ti.com>
References: <1360645032-9668-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360645032-9668-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <greg@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Loic Pallardy <loic.pallardy@st.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, Omar Ramirez Luna <omar.luna@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Loic Pallardy <loic.pallardy@st.com>

Coprocessor must be accessible during suspend transitions.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mailbox/mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 08da5b0..35813f5 100644
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
1.8.1.2
