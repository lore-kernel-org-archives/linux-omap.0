From: "Wang Limei-E12499" <E12499@motorola.com>
Subject: RE: Linux-omap PM:  Fix dead lock condition in resource_release(vdd1_opp)
Date: Sat, 8 Aug 2009 04:55:40 +0800
Message-ID: <DF4DCBD3DB270B419320B577AC0C3C8602F48030@zmy16exm62.ds.mot.com>
References: <DF4DCBD3DB270B419320B577AC0C3C8602F4801A@zmy16exm62.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail153.messagelabs.com ([216.82.253.51]:10841 "EHLO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbZHGU4G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 16:56:06 -0400
Content-class: urn:content-classes:message
In-Reply-To: <DF4DCBD3DB270B419320B577AC0C3C8602F4801A@zmy16exm62.ds.mot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Limei-E12499 <E12499@motorola.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap-owner@vger.kernel.org

 
Re-sent to linux-omap-owner@vger.kernel.org. 

-----Original Message-----
From: Wang Limei-E12499 
Sent: Friday, August 07, 2009 12:05 PM
To: linux-omap@vger.kernel.org; Kevin Hilman
Cc: Wang Limei-E12499
Subject: Linux-omap PM: Fix dead lock condition in
resource_release(vdd1_opp)

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

int set_opp(struct shared_resource *resp, u32 target_level) {
	.....
 if (resp == vdd1_resp) {
      if (target_level < 3)
           resource_release("vdd2_opp", &vdd2_dev); }
 
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
b/arch/arm/plat-omap/resource.c index ec31727..876fd12 100644
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
