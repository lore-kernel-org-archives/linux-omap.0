From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 2/2] OMAP: omap_device: Add a method to build an omap_device
 from a DT node
Date: Tue, 27 Sep 2011 18:04:59 +0200
Message-ID: <4E81F42B.5070806@ti.com>
References: <1316724745-24896-1-git-send-email-b-cousson@ti.com> <1316724745-24896-3-git-send-email-b-cousson@ti.com> <20110927014632.GB20588@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34456 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328Ab1I0QFH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 12:05:07 -0400
In-Reply-To: <20110927014632.GB20588@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 9/27/2011 3:46 AM, Grant Likely wrote:
> On Thu, Sep 22, 2011 at 10:52:25PM +0200, Benoit Cousson wrote:

[...]

>> +Required properties:
>> +- compatible: Every devices present in OMAP SoC should be in the
>> +  form: "ti,XXX"
>> +- ti,hwmods: list of hwmods attached to a device. Must contain at least
>> +  one hwmod.
> 
> Nit: This should specify that ti,hwmods is a list of hwmod names
> (ascii strings), and that the hwmod names come from the OMAP
> documentation.  Don't respin the patch over this though, just do a
> follow-up patch.

OK, but since you asked later to remove the DT helpers, I will have to resend it anyway:-)

[...]

>> +/*
>> + * XXX: DT helper functions that should be replaced by more generic
>> + * API introduced by Stephen Warren once they'll be in mainline.
>> + */
>> +static int _dt_count_property_string(const char *prop, int len)
>> +{
>> +	int i = 0;
>> +	size_t l = 0, total = 0;
>> +
>> +	if (!prop || !len)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; len>= total; total += l, prop += l) {
>> +		l = strlen(prop) + 1;
>> +		if (*prop != 0)
>> +			i++;
>> +	}
>> +	return i;
>> +}
>> +
>> +static int _dt_get_property(const char *prop, int len, int index, char *output,
>> +			    int size)
>> +{
>> +	int i = 0;
>> +	size_t l = 0, total = 0;
>> +
>> +	if (!prop || !len)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; len>= total; total += l, prop += l) {
>> +		l = strlcpy(output, prop, size) + 1;
>> +		if (*prop != 0) {
>> +			if (i++ == index)
>> +				return 0;
>> +		}
>> +	}
>> +	return -ENODEV;
>> +}
> 
> Don't merge this.  Kevin or I could put Stephen's patch into a separate
> branch that both Kevin and I pull.  There's no need to merge temporary
> code.
> 
> That said, I just looked at Stephen's iterator, and even without it
> this particular hunk shouldn't be merged here.  A
> of_property_count_strings() function is useful in and of itself, and
> of_property_read_string() could be extended with an
> of_property_read_string_index() version.  Both changes should be in
> the common drivers/of code, and you can easily do them.

I'm fine with that, but in that case, and in order to be consistent with the existing of_property_read_string, I should include the find_property in these functions. Whereas in my case, it was supposed to be done before.

Please find below a first version of this patch.

Regards,
Benoit

---
>From 4403f8a00090e5ea1814a5242947b81c348947a1 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Tue, 27 Sep 2011 17:45:43 +0200
Subject: [PATCH] of: Add helpers to get one string in multiple strings property

Add of_property_read_string_index and of_property_count_strings
to retrieve one string inside a property that will contains
severals strings.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 drivers/of/base.c  |   85 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |   18 +++++++++++
 2 files changed, 103 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 3ff22e3..d97d53e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -662,6 +662,91 @@ int of_property_read_string(struct device_node *np, const char *propname,
 EXPORT_SYMBOL_GPL(of_property_read_string);
 
 /**
+ * of_property_read_string_index - Find and read a string from a multiple
+ * strings property.
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @index:	index of the string in the list of strings
+ * @out_string:	pointer to null terminated return string, modified only if
+ *		return value is 0.
+ *
+ * Search for a property in a device tree node and retrieve a null
+ * terminated string value (pointer to data, not a copy) in the list of strings
+ * contained in that property.
+ * Returns 0 on
+ * success, -EINVAL if the property does not exist, -ENODATA if property
+ * does not have a value, and -EILSEQ if the string is not null-terminated
+ * within the length of the property data.
+ *
+ * The out_string pointer is modified only if a valid string can be decoded.
+ */
+int of_property_read_string_index(struct device_node *np, const char *propname,
+				  int index, const char **output)
+{
+	struct property *prop = of_find_property(np, propname, NULL);
+	int i = 0;
+	size_t l = 0, total = 0;
+	const char *p;
+
+	if (!prop)
+		return -EINVAL;
+	if (!prop->value)
+		return -ENODATA;
+	if (strnlen(prop->value, prop->length) >= prop->length)
+		return -EILSEQ;
+
+	p = prop->value;
+
+	for (i = 0; total < prop->length; total += l, p += l) {
+		l = strlen(p) + 1;
+		if ((*p != 0) && (i++ == index)) {
+			*output = p;
+			return 0;
+		}
+	}
+	return -ENODATA;
+}
+EXPORT_SYMBOL_GPL(of_property_read_string_index);
+
+
+/**
+ * of_property_count_strings - Find and return the number of strings from a
+ * multiple strings property.
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ *
+ * Search for a property in a device tree node and retrieve the number of null
+ * terminated string contain in it. Returns the number of strings on
+ * success, -EINVAL if the property does not exist, -ENODATA if property
+ * does not have a value, and -EILSEQ if the string is not null-terminated
+ * within the length of the property data.
+ */
+int of_property_count_strings(struct device_node *np, const char *propname)
+{
+	struct property *prop = of_find_property(np, propname, NULL);
+	int i = 0;
+	size_t l = 0, total = 0;
+	const char *p;
+
+	if (!prop)
+		return -EINVAL;
+	if (!prop->value)
+		return -ENODATA;
+	if (strnlen(prop->value, prop->length) >= prop->length)
+		return -EILSEQ;
+
+	p = prop->value;
+
+	for (i = 0; total < prop->length; total += l, p += l) {
+		l = strlen(p) + 1;
+		if (*p != 0)
+			i++;
+	}
+	return i;
+}
+EXPORT_SYMBOL_GPL(of_property_count_strings);
+
+/**
  * of_parse_phandle - Resolve a phandle property to a device_node pointer
  * @np: Pointer to device node holding phandle property
  * @phandle_name: Name of property holding a phandle value
diff --git a/include/linux/of.h b/include/linux/of.h
index 9180dc5..9eadc4e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -203,6 +203,11 @@ extern int of_property_read_u32_array(const struct device_node *np,
 extern int of_property_read_string(struct device_node *np,
 				   const char *propname,
 				   const char **out_string);
+extern int of_property_read_string_index(struct device_node *np,
+					 const char *propname,
+					 int index, const char **output);
+extern int of_property_count_strings(struct device_node *np,
+				     const char *propname);
 extern int of_device_is_compatible(const struct device_node *device,
 				   const char *);
 extern int of_device_is_available(const struct device_node *device);
@@ -256,6 +261,19 @@ static inline int of_property_read_string(struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_property_read_string_index(struct device_node *np,
+						const char *propname, index,
+						const char **out_string)
+{
+	return -ENOSYS;
+}
+
+static inline int of_property_count_strings(struct device_node *np,
+					    const char *propname)
+{
+	return -ENOSYS;
+}
+
 static inline const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp)
-- 
1.7.0.4


