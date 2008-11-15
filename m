From: David Brownell <david-b@pacbell.net>
Subject: [patch/fyi 3/3] regulator can report "off"
Date: Sat, 15 Nov 2008 12:45:45 -0800
Message-ID: <200811151245.45333.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:20783 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752016AbYKOUyM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Nov 2008 15:54:12 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Add REGULATOR_MODE_OFF (zero) as a valid option ...

Update the display of regulator_ops.get_mode() values to report
the mode as "off" if it's neither an error (negative number)
nor one of the defined REGISTER_MODE_* constants.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 Documentation/ABI/testing/sysfs-class-regulator |    1 +
 drivers/regulator/core.c                        |    2 ++
 include/linux/regulator/consumer.h              |   12 +++++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

--- a/Documentation/ABI/testing/sysfs-class-regulator
+++ b/Documentation/ABI/testing/sysfs-class-regulator
@@ -95,6 +95,7 @@ Description:
 		'normal'
 		'idle'
 		'standby'
+		'off'
 		'unknown'
 
 		The modes are described in include/linux/regulator/consumer.h
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -280,6 +280,8 @@ static ssize_t regulator_print_opmode(ch
 		return sprintf(buf, "idle\n");
 	case REGULATOR_MODE_STANDBY:
 		return sprintf(buf, "standby\n");
+	case REGULATOR_MODE_OFF:
+		return sprintf(buf, "off\n");
 	}
 	return sprintf(buf, "unknown\n");
 }
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -71,9 +71,19 @@
  * NOTE: Most regulators will only support a subset of these modes. Some
  * will only just support NORMAL.
  *
- * These modes can be OR'ed together to make up a mask of valid register modes.
+ * These modes can be OR'ed together to make up a mask of the modes which
+ * may be passed, one at a time, to regulator_set_mode().
+ *
+ * Additionally, two more regulator states are reported in some cases
+ * by regulator_get_mode():
+ *
+ *  OFF        Regulator supplies no current or voltage; very efficient.
+ *
+ *  error      These values are indicated by negative errno codes, and
+ *             represent various out-of-regulation states.
  */
 
+#define REGULATOR_MODE_OFF			0x0
 #define REGULATOR_MODE_FAST			0x1
 #define REGULATOR_MODE_NORMAL			0x2
 #define REGULATOR_MODE_IDLE			0x4
