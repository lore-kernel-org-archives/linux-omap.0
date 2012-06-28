From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: hwmod: Add new sysc_type3 into omap_hwmod
 required for am33xx
Date: Thu, 28 Jun 2012 14:40:27 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5D46A@DBDE01.ent.ti.com>
References: <1329481488-27771-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204271934230.10308@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42936 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab2F1Oke convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 10:40:34 -0400
In-Reply-To: <alpine.DEB.2.00.1204271934230.10308@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>

On Sat, Apr 28, 2012 at 07:04:38, Paul Walmsley wrote:
> On Fri, 17 Feb 2012, Vaibhav Hiremath wrote:
> 
> > In case of AM33xx family of devices (like cpsw) have different sysc
> > bit field offsets defined,
> > 
> > sysc_type3:
> > |  3     2  |  1    0  |
> > | STDBYMODE | IDLEMODE |
> > 
> > So introduce new sysc_type3 in omap_hwmod common data.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> Thanks, queued for 3.5.
> 

We missed this patch last time, can you pleas make sure to include it this 
time.

Thanks,
Vaibhav
