From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 12/13] mailbox: check for NULL nb in mailbox_put
Date: Mon, 11 Feb 2013 22:57:11 -0600
Message-ID: <1360645032-9668-13-git-send-email-s-anna@ti.com>
References: <1360645032-9668-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360645032-9668-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <greg@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Loic Pallardy <loic.pallardy@st.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, Omar Ramirez Luna <omar.luna@linaro.org>, Suman Anna <s-anna@ti.com>, Fernando Guzman Lugo <lugo.fernando@gmail.com>
List-Id: linux-omap@vger.kernel.org

The mailbox_put function must check the notifier block for
NULL before trying to unregister it.

Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index eaaf87e..c38241a 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -473,7 +473,8 @@ EXPORT_SYMBOL(mailbox_get);
 
 void mailbox_put(struct mailbox *mbox, struct notifier_block *nb)
 {
-	blocking_notifier_chain_unregister(&mbox->notifier, nb);
+	if (nb)
+		blocking_notifier_chain_unregister(&mbox->notifier, nb);
 	mailbox_fini(mbox);
 }
 EXPORT_SYMBOL(mailbox_put);
-- 
1.8.1.2
