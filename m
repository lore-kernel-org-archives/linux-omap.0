From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc7-omap1-git 1/2] twl4030-core: move to drivers/mfd
Date: Thu, 2 Oct 2008 12:47:11 -0700
Message-ID: <200810021247.11953.david-b@pacbell.net>
References: <200810011947.55057.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:45356 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752400AbYJBUMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 16:12:06 -0400
In-Reply-To: <200810011947.55057.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Wednesday 01 October 2008, David Brownell wrote:
> NOTE: minor weirdness. =A0The twl403-pwrirq initializes earlier (?)
> than before ... but "i2c_omap i2c_omap.1: controller timed out"

I'm seeing a bunch of these ... not clear why.  Usually while
booting ... but regardless, lack of fault recovery makes for
lots of trouble.


> is the response to its first I2C request. =A0So it bails, causing
> twl4030_usb and then rtc_twl4030 request_irq() calls to fail, and
> those drivers probe() calls fail.
>=20
> But, for the first time in a long while, the USB host now enumerates
> my Ethernet adapter!! =A0So it's a net win in terms of overall behavi=
or,
> since I can now get the time from NTP (loss of RTC doesn't hurt).
>=20
> Make the pwrirq code retry that first write (setting the mask to
> the value the core already set it) ... and pwrirq comes up, RTC,
> the transceiver glue. =A0And USB can't enumerate that adapter. :(

My retry hack is appended.  If anyone has an idea what's up with
the I2C driver, it'd be good to fix ... although I'm happy to see
what fault handling bugs these errors turn up.

More info on the USB thing:  the issue is that if the external
hub is connected when MUSB comes up, it misbehaves.  If it's
plugged in later, it works.  The misbehavior may involve not
seeing the external hub; or it may instead be errors in some
operations talking to a devices hooked up to it.

- Dave


Usually a single retry lets this chip behave.
---
 drivers/i2c/chips/twl4030-pwrirq.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/i2c/chips/twl4030-pwrirq.c
+++ b/drivers/i2c/chips/twl4030-pwrirq.c
@@ -161,6 +161,8 @@ static int twl4030_pwrirq_thread(void *d
 	return 0;
 }
=20
+#include <linux/delay.h>
+
 static int __init twl4030_pwrirq_init(void)
 {
 	int i, err;
@@ -168,8 +170,16 @@ static int __init twl4030_pwrirq_init(vo
 	twl4030_pwrirq_mask =3D 0xff;
 	twl4030_pwrirq_pending_unmask =3D 0;
=20
+/* HEY:  core already did this.
+ * But that's surely not why we
+ * sometimes see timeouts here ...
+ */
+for (i =3D 0; i < 5; i++) {
 	err =3D twl4030_i2c_write_u8(TWL4030_MODULE_INT, twl4030_pwrirq_mask,
 					TWL4030_INT_PWR_IMR1);
+if (!err) break;
+msleep(10);
+}
 	if (err)
 		return err;
=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
