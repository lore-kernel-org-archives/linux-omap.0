From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 01/04] OMAP3 SRF: Generic shared resource f/w
Date: Fri, 17 Oct 2008 13:13:59 +0530
Message-ID: <02bd01c9302c$1e630570$LocalHost@wipultra1382>
References: <B85A65D85D7EB246BE421B3FB0FBB59301B038E9DC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41581 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbYJQHoI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 03:44:08 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9H7i1Qk004821
	for <linux-omap@vger.kernel.org>; Fri, 17 Oct 2008 02:44:06 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B038E9DC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Dasgupta, Romit'" <romit@ti.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Dasgupta, Romit [mailto:romit@ti.com] 
> Sent: Friday, October 17, 2008 1:06 PM
> To: Nayak, Rajendra; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 01/04] OMAP3 SRF: Generic shared resource f/w
> 
> >> 1) curr_level of the shared_resource is not updated in
> >> update_resource_level
> >
> >Yes, its not. Its done as part of the platform specific 
> change_level call.
> 
> [Romit] Kindly see below. I was thinking that it is better 
> that we do not access any fields of struct shared_resource 
> from outside this file. Would the line below solve the problem?

The actual *target_level* of the resource will depend on the resource type.
Hence for say a "per_pwrdm_latency" resource if some user request's for a 
latency of no more than 130ms, it inturn translates to a PWRDM_RET level
depending on the specific latency to go to RET/OFF.

So what is currently done is the current_level of the resource in the above case 
is set to PWRDM_RET and if done the way you are suggesting will be set to 130ms.
 
> 
> >> >+static int update_resource_level(struct shared_resource *resp)
> >> >+{
> >> >+      struct users_list *user;
> >> >+      unsigned long target_level;
> >> >+      int ret;
> >> >+
> >> >+      /* Regenerate the target_value for the resource */
> >> >+      target_level = RES_DEFAULTLEVEL;
> >> >+      list_for_each_entry(user, &resp->users_list, node)
> >> >+              if (user->level > target_level)
> >> >+                      target_level = user->level;
> >> >+
> >> >+      pr_debug("SRF: Changing Level for resource %s to %ld\n",
> >> >+                              resp->name, target_level);
> >> >+      ret = resp->ops->change_level(resp, target_level);
> >> >+      if (ret) {
> >> >+              printk(KERN_ERR "Unable to Change"
> >> >+                                      "level for resource
> >> %s to %ld\n",
> >> >+              resp->name, target_level);
> >> >+      } else 
> 	          resp->curr_level = target_level; /* [Romit]  
> Should be done here.*/
> >> >+      return ret;
> >> >+}
> >
> >> 2) resource_request invokes spin_lock_irqsave and then if it
> >> is a request for a new device it invokes get_user().
> >> get_user() calls kmalloc with GFP_KERNEL. So it can sleep.
> >> Hence you will sleep with spinlocks held!!
> >
> >Right, so I'll probably have to add a GFP_ATOMIC flag to that.
> >I am now thinking If I really need spinlocks, think I can do 
> with mutex's instead.
> >The spinlocks were put in place to take care of the omap-pm 
> hooks from
> >clock f/w which no longer seem to be needed.
> [Romit] Trying to review the rest of the patches in the 
> patchset to get a better picture.
> 
> 

