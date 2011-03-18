From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/2] omap3: voltage: fix variable type and name
Date: Fri, 18 Mar 2011 10:23:14 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C3084CE@dbde02.ent.ti.com>
References: <1300374757-23010-1-git-send-email-premi@ti.com>
	<1300374757-23010-3-git-send-email-premi@ti.com> <874o711p80.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49652 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202Ab1CRExY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Mar 2011 00:53:24 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2I4rKr7029211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 23:53:23 -0500
In-Reply-To: <874o711p80.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Hilman, Kevin 
> Sent: Friday, March 18, 2011 1:42 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/2] omap3: voltage: fix variable type and name
> 
> Sanjeev Premi <premi@ti.com> writes:
> 
> > In all usages, variables prm_mod_offs and prm_irqst_ocp_mod_offs
> > are expected to be "u16" but have been declared as "s16".
> 
> What kind of problem is that causing?

[sp] No, it wasn't causing any problems 0 because offset value wouldn't
     reach the signed / unsigned limits; but didn't seem right while
     reading the code.

~sanjeev

> 
> Kevin
> 
> > In addition, renamed prm_irqst_ocp_mod_offs to ocp_sysreg_prm_offs
> > for better association with the TRM. Original name perhaps came
> > from the current usage of this offset to reach PRM_IRQSTATUS_MPU
> > offset.

[snip]...[snip]
