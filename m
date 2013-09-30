From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 RESEND 1/3] usb: musb: am35x: use SIMPLE_DEV_PM_OPS
Date: Mon, 30 Sep 2013 21:02:07 +0200
Message-ID: <1380567729-27868-1-git-send-email-zonque@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This makes am35x_pm_ops const and will stub the struct out in case
CONFIG_PM_SLEEP is not set.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

I'm resending this series because I've just learned that
SIMPLE_DEV_PM_OPS will stub itself out in case CONFIG_PM_SLEEP is
not set. That makes the the code even smaller.

 drivers/usb/musb/am35x.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 5c310c6..7f1e990 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -615,23 +615,16 @@ static int am35x_resume(struct device *dev)
 
 	return 0;
 }
-
-static struct dev_pm_ops am35x_pm_ops = {
-	.suspend	= am35x_suspend,
-	.resume		= am35x_resume,
-};
