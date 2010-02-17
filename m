From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 16/24] omap4: Add i2c support on omap4 platform
Date: Wed, 17 Feb 2010 10:53:32 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF82BE@dbde02.ent.ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-14-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-16-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1002161616550.10478@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34363 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab0BQFYB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 00:24:01 -0500
In-Reply-To: <alpine.DEB.2.00.1002161616550.10478@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben@fluff.org.uk" <ben@fluff.org.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "Nayak, Rajendra" <rnayak@ti.com>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>, Ben Dooks <ben-linux@fluff.org>

Thanks Paul,

I am just summarizing all my responses in this email.
<snip>
> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, February 17, 2010 4:51 AM
> To: Shilimkar, Santosh
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; ben@fluff.org.uk; sameo@linux.intel.com;
> lrg@slimlogic.co.uk; Nayak, Rajendra; Syed, Rafiuddin; Ben Dooks
> Subject: Re: [PATCH 16/24] omap4: Add i2c support on omap4 platform
> 
> Hello Santosh,
> 
> one general comment on this patch, before the specific comments.  Rather
> than adding more cpu_is_omap*() all over, please instead convert this code
> to use flags passed in via platform_data.  The I2C hwmod conversion
> patches are one attempt to do that via the hwmod mechanism; you can use
> that as an example of one way to do that with this driver.

1. As you suggested most of the driver clock related modifications can be avoided
with dummy_nodes. Will do that. 

2. Some drivers like gptimer, the clock node names
chosen are different between omap4 and rest of the omaps. Since we do clk_get
based on clk names, such cases, we need cpu check. Another way is to keep same 
clock nodes which means need to change database scripts. 
Which one you prefer ?

3. I shall the possibility of passing flags via board-files instead of 
cpu_is_xxxx() checks in  drivers. This is ofcourse much cleaner approach 
if it's doable.
