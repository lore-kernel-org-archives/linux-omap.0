From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] OMAP: omap_device: add omap_device_is_valid()
Date: Thu, 28 Jan 2010 09:19:17 -0800
Message-ID: <87ljfirvu2.fsf@deeprootsystems.com>
References: <1264532444-22706-1-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1001271727450.1248@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:64893 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab0A1RTU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 12:19:20 -0500
Received: by pwi21 with SMTP id 21so626973pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 09:19:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1001271727450.1248@utopia.booyaka.com> (Paul Walmsley's message of "Wed\, 27 Jan 2010 17\:30\:37 -0700 \(MST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> this looks fine.  Two quick comments:
>
> On Tue, 26 Jan 2010, Kevin Hilman wrote:
>
>> The omap_device struct contains a 'struct platform_device'.  Normally,
>> converting a platform_device pointer to an omap_device pointer
>> consists of simply doing a container_of(), as is done currently by the
>> to_omap_device() macro.
>> 
>> However, if this is attempted when using platform_device that has not
>> been created as part of the omap_device creation, the container_of()
>> will point to a memory location before the platform_device pointer
>> which will contain random data.
>> 
>> Therefore, we need a way to detect valid omap_device pointers.  This
>> patch solves this by using the simple magic number approach.
>
> Sounds okay; just FYI at some point in the future, it would be good for 
> one of us to take a whack at converting omap_device to contain 
> platform_device, the same way that platform_device contains struct device, 
> etc..

Hmm, not sure I follow...  

struct omap_device already contains a struct platform_device, which in
turn contains a struct device, so to get an omap_device from a struct
device, there are two container of operaions: to_platform_device() and
to_omap_device()


from omap_device.h:

struct omap_device {
	u32                             magic;
	struct platform_device		pdev;
        [...]
}
#define to_omap_device(x) container_of((x), struct omap_device, pdev)

from platform_device.h:
struct platform_device {
	const char	* name;
	int		id;
	struct device	dev;
        [...]
}
#define to_platform_device(x) container_of((x), struct platform_device, dev)

>> 
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>> Changes from original version:
>> - set magic value before omap_device_register()
>> 
>>  arch/arm/plat-omap/include/plat/omap_device.h |    2 ++
>>  arch/arm/plat-omap/omap_device.c              |   16 ++++++++++++++++
>>  2 files changed, 18 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
>> index 76d4917..4677ff7 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_device.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
>> @@ -62,6 +62,7 @@
>>   *
>>   */
>>  struct omap_device {
>> +	u32                             magic;
>>  	struct platform_device		pdev;
>>  	struct omap_hwmod		**hwmods;
>>  	struct omap_device_pm_latency	*pm_lats;
>> @@ -81,6 +82,7 @@ int omap_device_shutdown(struct platform_device *pdev);
>>  
>>  /* Core code interface */
>>  
>> +bool omap_device_is_valid(struct omap_device *od);
>>  int omap_device_count_resources(struct omap_device *od);
>>  int omap_device_fill_resources(struct omap_device *od, struct resource *res);
>>  
>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
>> index d8c75c8..187a08f 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -100,6 +100,8 @@
>>  # error Unknown OMAP device
>>  #endif
>>  
>> +#define OMAP_DEVICE_MAGIC 0xf00dcafe
>> +
>>  /* Private functions */
>>  
>>  /**
>> @@ -413,6 +415,8 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>>  	od->pm_lats = pm_lats;
>>  	od->pm_lats_cnt = pm_lats_cnt;
>>  
>> +	od->magic = OMAP_DEVICE_MAGIC;
>> +
>>  	ret = omap_device_register(od);
>>  	if (ret)
>>  		goto odbs_exit4;
>> @@ -599,6 +603,18 @@ int omap_device_align_pm_lat(struct platform_device *pdev,
>>  }
>>  
>>  /**
>> + * omap_device_is_valid()
>
> I think kerneldoc will want a short description after the function name.  
> Can plug this in here during the merge process if you want...

done, updated version below.

Thanks for comments,

Kevin

>From cd8cfaf6663da00645eca7bcf8f2faf1d5b96cf2 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Tue, 12 Jan 2010 16:37:47 -0800
Subject: [PATCH 1/2] OMAP: omap_device: add omap_device_is_valid()

The omap_device struct contains a 'struct platform_device'.  Normally,
converting a platform_device pointer to an omap_device pointer
consists of simply doing a container_of(), as is done currently by the
to_omap_device() macro.

However, if this is attempted when using platform_device that has not
been created as part of the omap_device creation, the container_of()
will point to a memory location before the platform_device pointer
which will contain random data.

Therefore, we need a way to detect valid omap_device pointers.  This
patch solves this by using the simple magic number approach.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    2 ++
 arch/arm/plat-omap/omap_device.c              |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 76d4917..4677ff7 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -62,6 +62,7 @@
  *
  */
 struct omap_device {
+	u32                             magic;
 	struct platform_device		pdev;
 	struct omap_hwmod		**hwmods;
 	struct omap_device_pm_latency	*pm_lats;
@@ -81,6 +82,7 @@ int omap_device_shutdown(struct platform_device *pdev);
 
 /* Core code interface */
 
+bool omap_device_is_valid(struct omap_device *od);
 int omap_device_count_resources(struct omap_device *od);
 int omap_device_fill_resources(struct omap_device *od, struct resource *res);
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d6b593d..ec0bcca 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -100,6 +100,8 @@
 # error Unknown OMAP device
 #endif
 
+#define OMAP_DEVICE_MAGIC 0xf00dcafe
+
 /* Private functions */
 
 /**
@@ -413,6 +415,8 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	od->pm_lats = pm_lats;
 	od->pm_lats_cnt = pm_lats_cnt;
 
+	od->magic = OMAP_DEVICE_MAGIC;
+
 	ret = omap_device_register(od);
 	if (ret)
 		goto odbs_exit4;
@@ -599,6 +603,18 @@ int omap_device_align_pm_lat(struct platform_device *pdev,
 }
 
 /**
+ * omap_device_is_valid - Check if pointer is a valid omap_device
+ * @od: struct omap_device *
+ *
+ * Return whether struct omap_device pointer @od points to a valid
+ * omap_device.
+ */
+bool omap_device_is_valid(struct omap_device *od)
+{
+	return (od && od->magic == OMAP_DEVICE_MAGIC);
+}
+
+/**
  * omap_device_get_pwrdm - return the powerdomain * associated with @od
  * @od: struct omap_device *
  *
-- 
1.6.6

