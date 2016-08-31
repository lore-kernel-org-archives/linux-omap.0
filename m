From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Wed, 31 Aug 2016 10:47:18 -0700
Message-ID: <20160831174717.oe3hkwtayanunlrs@atomide.com>
References: <20160829223542.18871-1-tony@atomide.com>
 <CAL_JsqK=JLN+ujvyVv62E-d1sB_DgeZCGP5Pddt9ohPkypHdEg@mail.gmail.com>
 <20160830003922.462byzmpnq277h2u@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160830003922.462byzmpnq277h2u@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Tom Rini <trini@konsulko.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160829 17:40]:
> * Rob Herring <robh+dt@kernel.org> [160829 17:24]:
> > On Mon, Aug 29, 2016 at 5:35 PM, Tony Lindgren <tony@atomide.com> wrote:
> > >                 if (!strcmp("hw-incomplete-pins", status)) {
> > >                         dev_info(&pdev->dev,
> > >                                  "Unusable hardware: Not pinned out\n");
> > >                         err = -ENODEV;
> > >                         goto out;
> > >                 }
> > >                 if (!strcmp("hw-missing-daughter-card")) {
> > >                         err = -EPROBE_DEFER;
> > 
> > This implies we're going to change this on the fly? I guess
> > disabled->okay can already happen.
> 
> Well let's assume the bootloader sets some i2c controlled daughter
> board with "fail-hw-missing-daughter-card", then in theory kernel
> could probe it if it pops up on the i2c bus later on. Not sure if
> we want to do this, but it seems we could..

I've dropped that part, if there ever is need we can revisit it.
Probably disabled->okay change is enough here.

> > > +static bool __of_device_is_incomplete(const struct device_node *device,
> > > +                                     const char **status)
> > > +{
> > > +       const char *s, *m = "fail-";
> > > +       int slen, mlen;
> > > +
> > > +       if (!device)
> > > +               return false;
> > > +
> > > +       s = __of_get_property(device, "status", &slen);
> > 
> > You can use the string helper function here (or is the lock a problem?).
> 
> I'll check.

We have of_property_read_string calls of_find_property which takes
devtree_lock. So sticking with __of_get_property.

Updated patch below with the &status fixed in the description
and speculative use case example left out.

Regards,

Tony

8< ------------------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 12 Apr 2016 11:37:55 -0700
Subject: [PATCHv3] of: Add generic handling for ePAPR 1.1 fail-sss states

We have devices that are in incomplete state, but still need to be
probed to allow properly idling them for PM. Some examples are
devices that are not pinned out on certain packages, or otherwise
unusable on some SoCs.

Setting status = "disabled" cannot be used for this case. Setting
"disabled" makes Linux ignore these devices so they are not probed
and can never get idled properly by Linux PM runtime.

The proper way deal with the incomplete devices is to probe them,
then allow the driver to check the state, and then disable or idle
the device using PM runtime. To do this, we need to often enable
the device and run some device specific code to idle the device.

Also boards may have needs to disable and idle unused devices.
This may be needed for example if all resources are not wired
for a certain board variant.

It seems we can use the ePAPR 1.1 status fail-sss to do this.
Quoting "Table 2-4 Values for status property" we have "fail-sss":

"Indicates that the device is not operational. A serious error was
 detected in the device and it is unlikely to become operational
 without repair. The sss portion of the value is specific to the
 device and indicates the error condition detected."

We can handle these fail states can be handled in a generic
way. So let's introduce a generic status = "fail-" that
describes a situation where a device driver probe should just
shut down or idle the device if possible and then bail out.
This allows the SoC variant and board specific dts files to set
the status as needed.

The suggested usage in a device driver probe is:

static int foo_probe(struct platform_device *pdev)
{
	int err;
	const char *status;
	...

        pm_runtime_enable(&pdev->dev);
        pm_runtime_get_sync(&pdev->dev);
        pm_runtime_use_autosuspend(&pdev->dev);
	...

	/* Configure device, load firmware, idle device */
	...

	if (of_device_is_incomplete(pdev->dev.of_node, &status)) {
		if (!strcmp("hw-incomplete-pins", status)) {
			dev_info(&pdev->dev,
				 "Unusable hardware: Not pinned out\n");
			err = -ENODEV;
			goto out;
		}
		if (!strcmp("hw-buggy-dma")) {
			dev_warn(&pdev->dev,
				 "Replace hardware for working DMA\n");
		}
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

Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v2:

- Fixed description example for &status and left out deferred
  probe example

 drivers/of/base.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/of.h |  8 +++++++
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -550,8 +550,8 @@ EXPORT_SYMBOL(of_machine_is_compatible);
  *
  *  @device: Node to check for availability, with locks already held
  *
- *  Returns true if the status property is absent or set to "okay" or "ok",
- *  false otherwise
+ *  Returns true if the status property is absent or set to "okay", "ok",
+ *  or starting with "fail-", false otherwise
  */
 static bool __of_device_is_available(const struct device_node *device)
 {
@@ -566,7 +566,8 @@ static bool __of_device_is_available(const struct device_node *device)
 		return true;
 
 	if (statlen > 0) {
-		if (!strcmp(status, "okay") || !strcmp(status, "ok"))
+		if (!strcmp(status, "okay") || !strcmp(status, "ok") ||
+		    !strncmp(status, "fail-", 5))
 			return true;
 	}
 
@@ -595,6 +596,63 @@ bool of_device_is_available(const struct device_node *device)
 EXPORT_SYMBOL(of_device_is_available);
 
 /**
+ *  __of_device_is_incomplete - check if a device is incomplete
+ *
+ *  @device: Node to check for partial failure with locks already held
+ *  @status: Status string for optional handling of the fail-sss state
+ */
+static bool __of_device_is_incomplete(const struct device_node *device,
+				      const char **status)
+{
+	const char *s, *m = "fail-";
+	int slen, mlen;
+
+	if (!device)
+		return false;
+
+	s = __of_get_property(device, "status", &slen);
+	if (!s)
+		return false;
+
+	mlen = strlen(m);
+	if (slen <= mlen)
+		return false;
+
+	if (strncmp("fail-", s, mlen))
+		return false;
+
+	*status = s + mlen;
+
+	return true;
+}
+
+/**
+ *  of_device_is_incomplete - check if a device is incomplete
+ *
+ *  @device: Node to check for partial failure
+ *  @status: Status string for optional handling of the fail-sss state
+ *
+ *  Returns true if the status property is set to "fail-sss",
+ *  false otherwise. Fore more information, see fail-sss in ePAPR 1.1
+ *  "Table 2-4 Values for status property".
+ *
+ *  The caller can optionally try to handle the error based on the
+ *  status string.
+ */
+bool of_device_is_incomplete(const struct device_node *device,
+			     const char **status)
+{
+	unsigned long flags;
+	bool res;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+	res = __of_device_is_incomplete(device, status);
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
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -320,6 +320,8 @@ extern int of_device_is_compatible(const struct device_node *device,
 extern int of_device_compatible_match(struct device_node *device,
 				      const char *const *compat);
 extern bool of_device_is_available(const struct device_node *device);
+extern bool of_device_is_incomplete(const struct device_node *device,
+				    const char **status);
 extern bool of_device_is_big_endian(const struct device_node *device);
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
@@ -504,6 +506,12 @@ static inline bool of_device_is_available(const struct device_node *device)
 	return false;
 }
 
+static inline bool of_device_is_incomplete(const struct device_node *device,
+					   const char **status)
+{
+	return false;
+}
+
 static inline bool of_device_is_big_endian(const struct device_node *device)
 {
 	return false;
-- 
2.9.3
