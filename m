From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: twl4030-power: Fix PM idle pin configuration to not
 conflict with regulators
Date: Tue, 2 Sep 2014 17:24:45 -0700
Message-ID: <20140903002445.GD11766@atomide.com>
References: <20140819152405.GA12002@atomide.com>
 <20140902082931.GA32460@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30453 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751130AbaICAZF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2014 20:25:05 -0400
Content-Disposition: inline
In-Reply-To: <20140902082931.GA32460@breakpoint.cc>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Lee Jones <lee.jones@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bigeasy@linutronix.de

* Sebastian Andrzej Siewior <sebastian@breakpoint.cc> [140902 01:29]:
> On 2014-08-19 08:24:05 [-0700], Tony Lindgren wrote:
> > 
> > This allows us to enable the PMIC configuration for n900.
> > 
> > Fixes: 43fef47f94a1 (mfd: twl4030-power: Add a configuration to turn off oscillator during off-idle)
> 
> My beaglebone-ab does not like this. With this patch applied I end up
> with:
> [    2.437316] Waiting for root device /dev/mmcblk0p2...
> [    4.428192] mmc0: card never left busy state
> [    4.432647] mmc0: error -110 whilst initialising SD card

I assume you mean beagleboard-ab, not beaglebone-ab :)
 
> I noticed this after I disabled lock debugging and tracing (syscall tracing
> was enabled). Enabling both again makes the error go away.
> With debugging + tracing disabled (so the error pops up) and git bisect
> I get this commit (daebabd57) reported.

OK. Sounds like we still have a race between the regulator code
and twl4030-power.c for accessing some twl registers.

> A diff between a good/bad bootlog (with lock-debug + tracing switched
> off):
> 
> | smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver initialized
> | smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver initialized
> | hsusb2_vbus: disabling
> | VPLL2: disabling
> | VUSB3V1: disabling
> |+VDAC: disabling
> |+VAUX3: disabling

This seems to be the reason. Seems you're on v3.17-rc3, but with
commit daebabd57 we are not even touching the group registers that
twl-regulator.c accesses for VDAC and VAUX3 as they are set to
TWL4030_RESCONFIG_UNDEF. So I'm a bit baffled what's going on.

> reverting this commit on top of -rc3 makes mmc0 work again.

Again, I assume you're talking about reverting daebabd57,
not 43fef47f94a1. Anyways, here's a debug hack I used earlier to
dump out the twl configuration in late_initcall and via sysfs
so maybe try that and see what the values are with working
and non-working case?

Regards,

Tony

--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -358,6 +358,146 @@ out:
 	return err;
 }
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+static void twl4030_dump_resource(unsigned index, struct seq_file *s)
+{
+	int addr;
+	int err;
+	u8 type;
+	u8 grp;
+	u8 remap;
+
+	addr = res_config_addrs[index];
+
+	err = twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &grp,
+			      addr + DEV_GRP_OFFSET);
+	if (err) {
+		pr_err("TWL4030 Resource group 0x%02x could not be read\n",
+			addr);
+		return;
+	}
+
+	err = twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &type,
+				addr + TYPE_OFFSET);
+	if (err < 0) {
+		pr_err("TWL4030 Resource type 0x%02x could not be read\n",
+			addr);
+		return;
+	}
+
+	err = twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &remap,
+			      addr + REMAP_OFFSET);
+	if (err < 0) {
+		pr_err("TWL4030 Resource 0x%02x remap could not be read\n",
+			addr);
+		return;
+	}
+
+	if (s)
+		seq_printf(s, "%i: addr: 0x%04x grp: 0x%04x type: 0x%04x remap: 0x%04x\n",
+			   index, addr, grp, type, remap);
+	else
+		printk("%i: addr: 0x%04x grp: 0x%04x type: 0x%04x remap: 0x%04x\n",
+		       index, addr, grp, type, remap);
+}
+
+static void twl4030_dump_resources(void)
+{
+	int i;
+
+	for (i = 1; i <= RES_MAIN_REF; i++)
+		twl4030_dump_resource(i, NULL);
+}
+
+static struct dentry *dbg_root;
+
+static int dbg_show(struct seq_file *s, void *unused)
+{
+	unsigned long offset = (unsigned long)s->private;
+
+	twl4030_dump_resource(offset, s);
+
+	return 0;
+}
+
+static ssize_t dbg_write(struct file *file,
+			 const char __user *user_buf,
+			 size_t count, loff_t *ppos)
+{
+	struct seq_file *seqf;
+	unsigned long offset;
+	u8 val;
+	int res;
+
+	res = kstrtou8_from_user(user_buf, count, 0x10, &val);
+        if (res < 0)
+                return res;
+
+	seqf = file->private_data;
+	offset = (unsigned long)seqf->private;
+	offset = res_config_addrs[offset];
+
+	res = twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
+			       val, offset + DEV_GRP_OFFSET);
+	if (res < 0) {
+		pr_err("TWL4030 failed to program devgroup\n");
+		return res;
+	}
+
+	*ppos += count;
+
+	return count;
+}
+
+static int dbg_open(struct inode *inode, struct file *file)
+{
+        return single_open(file, dbg_show, inode->i_private);
+}
+
+static const struct file_operations dbg_fops = {
+        .open           = dbg_open,
+        .read           = seq_read,
+        .write          = dbg_write,
+        .llseek         = seq_lseek,
+        .release        = single_release,
+};
+
+static void __init dbg_init(struct twl4030_resconfig *rconfig)
+{
+	int i;
+
+	dbg_root = debugfs_create_dir("twl4030-power", NULL);
+	if (IS_ERR(dbg_root) || !dbg_root)
+		return;
+
+	for (i = 1; i <= RES_MAIN_REF; i++) {
+		u8 name[16];
+
+		sprintf(name, "0x%02x", res_config_addrs[i]);
+		(void)debugfs_create_file(name, S_IRUGO,
+					  dbg_root,
+					  (void *)i,
+					  &dbg_fops);
+	}
+}
+
+static int __init dbg_initcall(void)
+{
+	twl4030_dump_resources();
+
+	return 0;
+}
+late_initcall(dbg_initcall);
+
+#else
+static inline void dbg_init(struct twl4030_resconfig *rconfig)
+{
+}
+#endif
+
 static int twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 {
 	int rconfig_addr;
@@ -864,6 +1004,8 @@ relock:
 		return err2;
 	}
 
+	dbg_init(pdata->resource_config);
+
 	return err;
 }
 
