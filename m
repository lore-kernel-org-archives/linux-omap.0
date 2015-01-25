From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 4/4] tty: Remove external interface for tty_set_termios()
Date: Sun, 25 Jan 2015 14:44:54 -0500
Message-ID: <1422215094-3216-5-git-send-email-peter@hurleysoftware.com>
References: <1422215094-3216-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422215094-3216-1-git-send-email-peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

tty_set_termios() is an internal helper intended for file scope use.

UART drivers which are capable of driving the RTS pin must
properly handle the tiocmset() method, regardless of termios settings.
A failure to do so is a UART driver bug and should be fixed there.
Do not use this interface to workaround UART driver bugs.

Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
---
 drivers/bluetooth/hci_ath.c | 15 ++-------------
 drivers/tty/tty_ioctl.c     |  3 +--
 include/linux/tty.h         |  1 -
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 2ff6dfd..9c4dcf4 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -51,33 +51,22 @@ struct ath_struct {
 
 static int ath_wakeup_ar3k(struct tty_struct *tty)
 {
-	struct ktermios ktermios;
 	int status = tty->driver->ops->tiocmget(tty);
 
 	if (status & TIOCM_CTS)
 		return status;
 
-	/* Disable Automatic RTSCTS */
-	ktermios = tty->termios;
-	ktermios.c_cflag &= ~CRTSCTS;
-	tty_set_termios(tty, &ktermios);
-
 	/* Clear RTS first */
-	status = tty->driver->ops->tiocmget(tty);
+	tty->driver->ops->tiocmget(tty);
 	tty->driver->ops->tiocmset(tty, 0x00, TIOCM_RTS);
 	mdelay(20);
 
 	/* Set RTS, wake up board */
-	status = tty->driver->ops->tiocmget(tty);
+	tty->driver->ops->tiocmget(tty);
 	tty->driver->ops->tiocmset(tty, TIOCM_RTS, 0x00);
 	mdelay(20);
 
 	status = tty->driver->ops->tiocmget(tty);
-
-	/* Enable Automatic RTSCTS */
-	ktermios.c_cflag |= CRTSCTS;
-	status = tty_set_termios(tty, &ktermios);
-
 	return status;
 }
 
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index d73f695..69fc0b8 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -533,7 +533,7 @@ EXPORT_SYMBOL(tty_termios_hw_change);
  *	Locking: termios_rwsem
  */
 
-int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
+static int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 {
 	struct ktermios old_termios;
 	struct tty_ldisc *ld;
@@ -566,7 +566,6 @@ int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 	up_write(&tty->termios_rwsem);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tty_set_termios);
 
 /**
  *	set_termios		-	set termios values for a tty
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 0992238..8c316b6 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -491,7 +491,6 @@ static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
 
 extern void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old);
 extern int tty_termios_hw_change(struct ktermios *a, struct ktermios *b);
-extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 
 extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
 extern void tty_ldisc_deref(struct tty_ldisc *);
-- 
2.2.2
