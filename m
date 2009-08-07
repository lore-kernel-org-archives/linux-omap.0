From: "Wang Limei-E12499" <E12499@motorola.com>
Subject: Linux-omap PM:  Fix dead lock condition in resource_release(vdd1_opp)
Date: Sat, 8 Aug 2009 01:04:43 +0800
Message-ID: <DF4DCBD3DB270B419320B577AC0C3C8602F4801A@zmy16exm62.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail119.messagelabs.com ([216.82.241.195]:51935 "EHLO
	mail119.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbZHGRFJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 13:05:09 -0400
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id n77H594Z016245
	for <linux-omap@vger.kernel.org>; Fri, 7 Aug 2009 10:05:09 -0700 (MST)
Received: from il06vts04.mot.com (il06vts04.mot.com [129.188.137.144])
	by il06exr04.mot.com (8.13.1/Vontu) with SMTP id n77H58c6002174
	for <linux-omap@vger.kernel.org>; Fri, 7 Aug 2009 12:05:08 -0500 (CDT)
Received: from zmy16exm62.ds.mot.com (zmy16exm62.ap.mot.com [10.179.4.33])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id n77H57au002171
	for <linux-omap@vger.kernel.org>; Fri, 7 Aug 2009 12:05:08 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Wang Limei-E12499 <E12499@motorola.com>

Kevin,
 
I am using linux-omap pm-2.6.29
<http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=s
hortlog;h=pm-2.6.29>  branch,found a dead lock condition in:
arch/arm/plat-omap/resource.c->resource_release().   
 
The dead lock happens when using resource_request("vdd1_opp",&dev,...)
and resource_release("vdd1_opp", &dev) to set and release vdd1 opp
constraint. The  scenario is:  
 
plat-omap/resource.c/resource_release("vdd1_opp",
&dev)==>resource.c/update_resource_level()=>mach-omap2/resource34xx.c/se
t_opp().  In set_opp(),  if the target_level of vdd1 is less than
OPP3,will release the constraint set on VDD2 by calling
resource_release(), but it will never return because can not get the
mutex which is holding  by the previous caller. 
 
int resource_release(const char *name, struct device *dev)
{           .......
	down(&res_mutex);
	........
	/* Recompute and set the current level for the resource */
	ret = update_resource_level(resp);
res_unlock:
	up(&res_mutex);
	return ret;
}

int set_opp(struct shared_resource *resp, u32 target_level)
{
	.....
 if (resp == vdd1_resp) {
      if (target_level < 3)
           resource_release("vdd2_opp", &vdd2_dev);
}
 
The patch to fix this issue is below, will you pls review it and let me
know your feedback?
 
From: Limei Wang <e12499@motorola.com>
Date: Fri, 7 Aug 2009 11:40:35 -0500
Subject: [PATCH] OMAP PM: Fix dead lock bug in
resourc_release(vdd1_opp).
 

Signed-off-by: Limei Wang <e12499@motorola.com>
---
 arch/arm/plat-omap/resource.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
 
diff --git a/arch/arm/plat-omap/resource.c
b/arch/arm/plat-omap/resource.c
index ec31727..876fd12 100644
--- a/arch/arm/plat-omap/resource.c
+++ b/arch/arm/plat-omap/resource.c
@@ -418,10 +418,12 @@ int resource_release(const char *name, struct
device *dev)
    list_del(&user->node);
    free_user(user);
 
-   /* Recompute and set the current level for the resource */
-   ret = update_resource_level(resp);
 res_unlock:
    up(&res_mutex);
+
+   /* Recompute and set the current level for the resource */
+   if (!ret)
+       ret = update_resource_level(resp);
    return ret;
 }
 EXPORT_SYMBOL(resource_release);
--
1.5.6.3

 
Thanks,
Limei
