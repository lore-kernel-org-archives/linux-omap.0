From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv3 13/14] mailbox: check for NULL nb in mailbox_put
Date: Tue, 12 Mar 2013 22:24:30 -0500
Message-ID: <1363145070-14786-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@copitl.com>, Loic Pallardy <loic.pallardy@st.com>, Suman Anna <s-anna@ti.com>, Fernando Guzman Lugo <lugo.fernando@gmail.com>
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
