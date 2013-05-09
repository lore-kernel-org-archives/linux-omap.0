From: Tony Lindgren <tony@atomide.com>
Subject: Re: arch/arm/mach-omap2/id.c - IS_ERR_OR_NULL()
Date: Thu, 9 May 2013 08:39:33 -0700
Message-ID: <20130509153933.GA31554@atomide.com>
References: <20130509090911.GM21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57911 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab3EIPjg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 May 2013 11:39:36 -0400
Content-Disposition: inline
In-Reply-To: <20130509090911.GM21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130509 02:14]:
> So, I eliminated all but a very few of these from arch/arm, and I notice
> today that there's a new couple of instances introduced by:

Sorry I should have noticed that fnord, I had it in my muttrc but had
a an unnecessary \ in the expression so it did not work.  

Here's a patch to fix the issue.

Hmm maybe we could redefine IS_ERR_OR_NULL as error in some ARM header
as long as drivers don't include it?

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 9 May 2013 08:27:25 -0700
Subject: [PATCH] ARM: OMAP2+: Remove bogus IS_ERR_OR_NULL checking from id.c

Commit 6770b211 (ARM: OMAP2+: Export SoC information to userspace)
had some broken return value handling as noted by Russell King:

+       soc_dev = soc_device_register(soc_dev_attr);
+       if (IS_ERR_OR_NULL(soc_dev)) {
+               kfree(soc_dev_attr);
+               return;
+       }
+
+       parent = soc_device_to_device(soc_dev);
+       if (!IS_ERR_OR_NULL(parent))
+               device_create_file(parent, &omap_soc_attr);

This is nonsense.  For the first, IS_ERR() is sufficient.  For the second,
tell me what error checking is required in the return value of this
function:

struct device *soc_device_to_device(struct soc_device *soc_dev)
{
        return &soc_dev->dev;
}

when you've already determined that the passed soc_dev is a valid pointer.
If you read the comments against the prototype:

/**
 * soc_device_to_device - helper function to fetch struct device
 * @soc: Previously registered SoC device container
 */
struct device *soc_device_to_device(struct soc_device *soc);

if "soc" is valid, it means the "previously registered SoC device container"
must have succeeded and that can only happen if the struct device has been
registered.  Ergo, there will always be a valid struct device pointer for
any registered SoC device container.  Therefore, if soc_device_register()
succeeds, then the return value from soc_device_to_device() will always be
valid and no error checking of it is required.

Simples.  The rule as ever applies here: get to know the APIs your using
and don't fumble around in the dark hoping that you'll get this stuff
right.

Fix it as noted by Russell.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 9bc5a18..1272c41 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -648,13 +648,12 @@ void __init omap_soc_device_init(void)
 	soc_dev_attr->revision = soc_rev;
 
 	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR_OR_NULL(soc_dev)) {
+	if (IS_ERR(soc_dev)) {
 		kfree(soc_dev_attr);
 		return;
 	}
 
 	parent = soc_device_to_device(soc_dev);
-	if (!IS_ERR_OR_NULL(parent))
-		device_create_file(parent, &omap_soc_attr);
+	device_create_file(parent, &omap_soc_attr);
 }
 #endif /* CONFIG_SOC_BUS */
