From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: hwmod: Add new sysc_type3 into omap_hwmod
 required for am33xx
Date: Mon, 12 Mar 2012 10:13:45 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A831810F02@DBDE01.ent.ti.com>
References: <1329481488-27771-1-git-send-email-hvaibhav@ti.com>
 <4F3E545F.8070802@ti.com>
 <B5906170F1614E41A8A28DE3B8D12143317A918A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37309 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855Ab2CLKNz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 06:13:55 -0400
In-Reply-To: <B5906170F1614E41A8A28DE3B8D12143317A918A@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>

On Tue, Feb 21, 2012 at 10:49:47, Bedia, Vaibhav wrote:
> Hi Benoit,
> 
> On Fri, Feb 17, 2012 at 18:51:35, Cousson, Benoit wrote:
> > Hi Vaibhav,
> > 
> > On 2/17/2012 1:24 PM, Vaibhav Hiremath wrote:
> > > In case of AM33xx family of devices (like cpsw) have different sysc
> > > bit field offsets defined,
> > 
> > It is really used by several IPs, or it is just an unique exception?
> > 
> > For an exception, you can just define the omap_hwmod_sysc_fields for 
> > that IP.
> > This is what SmartReflex is using for example.
> > 
> 
> I haven't really check TI81xx code but we might need to share these SYSC types
> with a few IPs in that family also. How can the sharing of the sysc data be handled?
> 

Benoit,

Any comments on this patch? 

Thanks,
Vaibhav

> Regards,
> Vaibhav B.
> 

