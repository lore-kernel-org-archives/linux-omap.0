From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc2-omap1-git 1/7] regulator get_status()
Date: Tue, 20 Jan 2009 02:45:47 -0800
Message-ID: <200901200245.47817.david-b@pacbell.net>
References: <200901200244.36238.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:44262 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756632AbZATLBS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2009 06:01:18 -0500
In-Reply-To: <200901200244.36238.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Based on previous LKML discussions:

 * Update docs for regulator sysfs class attributes to highlight
   the fact that all current attributes are intended to be control
   inputs, including notably "state" and "opmode" which previously
   implied otherwise.

 * Define a new regulator driver get_status() method, which is the
   first method reporting regulator outputs instead of inputs.
   It can report on/off and error status; or instead of simply
   "on", report the actual operating mode.

For the moment, this is a sysfs-only interface, not accessible to 
regulator clients.  Such clients can use the current notification
interfaces to detect errors, if the regulator reports them.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
This is in the -next tree and on track to merge to mainline.

 Documentation/ABI/testing/sysfs-class-regulator |   57 ++++++++++++++++++----
 drivers/regulator/core.c                        |   46 +++++++++++++++++
 include/linux/regulator/driver.h                |   17 ++++++
 3 files changed, 111 insertions(+), 9 deletions(-)

--- a/Documentation/ABI/testing/sysfs-class-regulator
+++ b/Documentation/ABI/testing/sysfs-class-regulator
@@ -4,8 +4,8 @@ KernelVersion:	2.6.26
 Contact:	Liam Girdwood <lrg@slimlogic.co.uk>
 Description:
 		Some regulator directories will contain a field called
-		state. This reports the regulator enable status, for
-		regulators which can report that value.
+		state. This reports the regulator enable control, for
+		regulators which can report that input value.
 
 		This will be one of the following strings:
 
@@ -14,16 +14,54 @@ Description:
 		'unknown'
 
 		'enabled' means the regulator output is ON and is supplying
-		power to the system.
+		power to the system (assuming no error prevents it).
 
 		'disabled' means the regulator output is OFF and is not
-		supplying power to the system..
+		supplying power to the system (unless some non-Linux
+		control has enabled it).
 
 		'unknown' means software cannot determine the state, or
 		the reported state is invalid.
 
 		NOTE: this field can be used in conjunction with microvolts
-		and microamps to determine regulator output levels.
+		or microamps to determine configured regulator output levels.
+
+
+What:		/sys/class/regulator/.../status
+Description:
+		Some regulator directories will contain a field called
+		"status". This reports the current regulator status, for
+		regulators which can report that output value.
+
+		This will be one of the following strings:
+
+			off
+			on
+			error
+			fast
+			normal
+			idle
+			standby
+
+		"off" means the regulator is not supplying power to the
+		system.
+
+		"on" means the regulator is supplying power to the system,
+		and the regulator can't report a detailed operation mode.
+
+		"error" indicates an out-of-regulation status such as being
+		disabled due to thermal shutdown, or voltage being unstable
+		because of problems with the input power supply.
+
+		"fast", "normal", "idle", and "standby" are all detailed
+		regulator operation modes (described elsewhere).  They
+		imply "on", but provide more detail.
+
+		Note that regulator status is a function of many inputs,
+		not limited to control inputs from Linux.  For example,
+		the actual load presented may trigger "error" status; or
+		a regulator may be enabled by another user, even though
+		Linux did not enable it.
 
 
 What:		/sys/class/regulator/.../type
@@ -58,7 +96,7 @@ Description:
 		Some regulator directories will contain a field called
 		microvolts. This holds the regulator output voltage setting
 		measured in microvolts (i.e. E-6 Volts), for regulators
-		which can report that voltage.
+		which can report the control input for voltage.
 
 		NOTE: This value should not be used to determine the regulator
 		output voltage level as this value is the same regardless of
@@ -73,7 +111,7 @@ Description:
 		Some regulator directories will contain a field called
 		microamps. This holds the regulator output current limit
 		setting measured in microamps (i.e. E-6 Amps), for regulators
-		which can report that current.
+		which can report the control input for a current limit.
 
 		NOTE: This value should not be used to determine the regulator
 		output current level as this value is the same regardless of
@@ -87,7 +125,7 @@ Contact:	Liam Girdwood <lrg@slimlogic.co
 Description:
 		Some regulator directories will contain a field called
 		opmode. This holds the current regulator operating mode,
-		for regulators which can report it.
+		for regulators which can report that control input value.
 
 		The opmode value can be one of the following strings:
 
@@ -101,7 +139,8 @@ Description:
 
 		NOTE: This value should not be used to determine the regulator
 		output operating mode as this value is the same regardless of
-		whether the regulator is enabled or disabled.
+		whether the regulator is enabled or disabled.  A "status"
+		attribute may be available to determine the actual mode.
 
 
 What:		/sys/class/regulator/.../min_microvolts
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -312,6 +312,47 @@ static ssize_t regulator_state_show(stru
 }
 static DEVICE_ATTR(state, 0444, regulator_state_show, NULL);
 
+static ssize_t regulator_status_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	int status;
+	char *label;
+
+	status = rdev->desc->ops->get_status(rdev);
+	if (status < 0)
+		return status;
+
+	switch (status) {
+	case REGULATOR_STATUS_OFF:
+		label = "off";
+		break;
+	case REGULATOR_STATUS_ON:
+		label = "on";
+		break;
+	case REGULATOR_STATUS_ERROR:
+		label = "error";
+		break;
+	case REGULATOR_STATUS_FAST:
+		label = "fast";
+		break;
+	case REGULATOR_STATUS_NORMAL:
+		label = "normal";
+		break;
+	case REGULATOR_STATUS_IDLE:
+		label = "idle";
+		break;
+	case REGULATOR_STATUS_STANDBY:
+		label = "standby";
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return sprintf(buf, "%s\n", label);
+}
+static DEVICE_ATTR(status, 0444, regulator_status_show, NULL);
+
 static ssize_t regulator_min_uA_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
@@ -1744,6 +1785,11 @@ static int add_regulator_attributes(stru
 		if (status < 0)
 			return status;
 	}
+	if (ops->get_status) {
+		status = device_create_file(dev, &dev_attr_status);
+		if (status < 0)
+			return status;
+	}
 
 	/* some attributes are type-specific */
 	if (rdev->desc->type == REGULATOR_CURRENT) {
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -21,6 +21,17 @@
 struct regulator_dev;
 struct regulator_init_data;
 
+enum regulator_status {
+	REGULATOR_STATUS_OFF,
+	REGULATOR_STATUS_ON,
+	REGULATOR_STATUS_ERROR,
+	/* fast/normal/idle/standby are flavors of "on" */
+	REGULATOR_STATUS_FAST,
+	REGULATOR_STATUS_NORMAL,
+	REGULATOR_STATUS_IDLE,
+	REGULATOR_STATUS_STANDBY,
+};
+
 /**
  * struct regulator_ops - regulator operations.
  *
@@ -72,6 +83,12 @@ struct regulator_ops {
 	int (*set_mode) (struct regulator_dev *, unsigned int mode);
 	unsigned int (*get_mode) (struct regulator_dev *);
 
+	/* report regulator status ... most other accessors report
+	 * control inputs, this reports results of combining inputs
+	 * from Linux (and other sources) with the actual load.
+	 */
+	int (*get_status)(struct regulator_dev *);
+
 	/* get most efficient regulator operating mode for load */
 	unsigned int (*get_optimum_mode) (struct regulator_dev *, int input_uV,
 					  int output_uV, int load_uA);
