From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 2/2] arm: omap3: pm34xx.c: Replace printk() with
 appropriate pr_*()
Date: Fri, 16 Mar 2012 11:02:28 -0700
Message-ID: <20120316180228.GA1894@animalcreek.com>
References: <1331852833-4357-1-git-send-email-mgreer@animalcreek.com>
 <1331852833-4357-3-git-send-email-mgreer@animalcreek.com>
 <4F633528.1040305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:54893 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab2CPSCa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 14:02:30 -0400
Content-Disposition: inline
In-Reply-To: <4F633528.1040305@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Mar 16, 2012 at 04:42:16PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 16-03-2012 3:07, Mark A. Greer wrote:
> 
> >From: "Mark A. Greer" <mgreer@animalcreek.com>

> >@@ -463,7 +462,7 @@ restore:
> >  	list_for_each_entry(pwrst,&pwrst_list, node) {
> >  		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
> >  		if (state>  pwrst->next_state) {
> >-			printk(KERN_INFO "Powerdomain (%s) didn't enter "
> >+			pr_info("Powerdomain (%s) didn't enter "
> >  			       "target state %d\n",
> 
>    Last line should have been realigned I think.

Okay, I'll fix this and the others in a bit.

Mark
--
