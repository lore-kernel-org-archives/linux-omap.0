From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] of: Add generic handling for hardware incomplete fail state
Date: Tue, 12 Apr 2016 11:37:55 -0700
Message-ID: <1460486275-12256-1-git-send-email-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We have devices that are in incomplete state, but still need to be
probed to allow properly idling them for PM. Some examples are
devices that are not pinned out on certain packages, or otherwise
not enabled for use on some SoCs.

Setting status = "disabled" cannot be used for this case. Setting
"disabled" makes Linux ignore these devices so they are not probed.

To proper way deal with the incomplete devices is to probe them,
then allow the driver to check the state, and the disable or idle
the device using PM runtime. To do this we need to often enable
the device and run some device specific code to idle the device.

Also boards may have needs to disable and idle unused devices.
This may be needed for example if all resources are not wired
for a certain board variant.

It seems we can use the ePAPR 1.1 status fail-sss to do this.
>From "Table 2-4 Values for status property" we have "fail-sss":

"Indicates that the device is not operational. A serious error was
 detected in the device and it is unlikely to become operational
 without repair. The sss portion of the value is specific to the
 device and indicates the error condition detected."

At least some of these fail states can be handled in a generic
way. So let's introduce a generic status = "fail-hw-incomplete"
that describes a situation where a device driver probe should
just shut down or idle the device if possible and then bail out.
This allows the SoC variant and board specific dts files to set
the status "fail-hw-incomplete" as needed.

The suggested usage in a device driver probe is:

static int foo_probe(struct platform_device *pdev)
{
	int err;
	...

        pm_runtime_enable(&pdev->dev);
        pm_runtime_get_sync(&pdev->dev);
        pm_runtime_use_autosuspend(&pdev->dev);
	...

	/* Configure device, load firmware, idle device */
	...

	if (of_device_is_incomplete(pdev->dev.of_node)) {
		err = -ENODEV;
		goto out;
	}

	/* Continue normal device probe */
	...

	return 0;

out:
	pm_runtime_dont_use_autosuspend(&pdev->dev);
	pm_runtime_put_sync(&pdev->dev);
	pm_runtime_disable(&pdev->dev);

	return err;
}

Then as needed, handling for other generic status = "fail-sss"
states can be added if needed as per ePAPR 1.1.

Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/of/base.c  | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/of.h |  6 ++++++
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index b299de2..8eb161f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -518,8 +518,8 @@ EXPORT_SYMBOL(of_machine_is_compatible);
  *
  *  @device: Node to check for availability, with locks already held
  *
- *  Returns true if the status property is absent or set to "okay" or "ok",
- *  false otherwise
+ *  Returns true if the status property is absent or set to "okay", "ok",
+ *  or "fail-hw-incomplete", false otherwise
  */
 static bool __of_device_is_available(const struct device_node *device)
 {
@@ -534,7 +534,8 @@ static bool __of_device_is_available(const struct device_node *device)
 		return true;
 
 	if (statlen > 0) {
-		if (!strcmp(status, "okay") || !strcmp(status, "ok"))
+		if (!strcmp(status, "okay") || !strcmp(status, "ok") ||
+		    !strcmp(status, "fail-hw-incomplete"))
 			return true;
 	}
 
@@ -563,6 +564,54 @@ bool of_device_is_available(const struct device_node *device)
 EXPORT_SYMBOL(of_device_is_available);
 
 /**
+ *  __of_device_is_incomplete - check if a device is incomplete
+ *
+ *  @device: Node to check for partial failure with locks already held
+ *
+ *  Returns true if the status is "fail-hw-incomplete", false otherwise.
+ */
+static bool __of_device_is_incomplete(const struct device_node *device)
+{
+	const char *status;
+	int statlen;
+
+	if (!device)
+		return false;
+
+	status = __of_get_property(device, "status", &statlen);
+	if (status == NULL)
+		return false;
+
+	if (statlen > 0) {
+		if (!strcmp(status, "fail-hw-incomplete"))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ *  of_device_is_incomplete - check if a device is incomplete
+ *
+ *  @device: Node to check for partial failure
+ *
+ *  Returns true if the status property is set to "fail-hw-incomplete",
+ *  false otherwise. Fore more information, see fail-sss in ePAPR 1.1
+ *  "Table 2-4 Values for status property".
+ */
+bool of_device_is_incomplete(const struct device_node *device)
+{
+	unsigned long flags;
+	bool res;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+	res = __of_device_is_incomplete(device);
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+	return res;
+}
+EXPORT_SYMBOL(of_device_is_incomplete);
+
+/**
  *  of_device_is_big_endian - check if a device has BE registers
  *
  *  @device: Node to check for endianness
diff --git a/include/linux/of.h b/include/linux/of.h
index 7fcb681..1d37db2 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -308,6 +308,7 @@ extern int of_property_read_string_helper(const struct device_node *np,
 extern int of_device_is_compatible(const struct device_node *device,
 				   const char *);
 extern bool of_device_is_available(const struct device_node *device);
+extern bool of_device_is_incomplete(const struct device_node *device);
 extern bool of_device_is_big_endian(const struct device_node *device);
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
@@ -480,6 +481,11 @@ static inline bool of_device_is_available(const struct device_node *device)
 	return false;
 }
 
+static inline bool of_device_is_incomplete(const struct device_node *device)
+{
+	return false;
+}
+
 static inline bool of_device_is_big_endian(const struct device_node *device)
 {
 	return false;
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
