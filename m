From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 14/15] ARM: OMAP2+: omap2plus_defconfig: Enable Mailbox
Date: Sat, 3 Nov 2012 13:17:50 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFEA96@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-15-git-send-email-vaibhav.bedia@ti.com>
 <50950C09.6000108@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59856 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755918Ab2KCNR5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 09:17:57 -0400
In-Reply-To: <50950C09.6000108@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Sat, Nov 03, 2012 at 17:50:25, Kevin Hilman wrote:
> On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
> > AM33XX PM code depends on Mailbox module for IPC
> > between MPU and WKUP_M3.
> 
> OK, but what if I try to build for AM33xx without starting from 
> omap2plus_defconfig?

I honestly didn't think about this scenario.

> 
> IOW, instead of changing the default defconfig, AM33xx should select 
> this when PM
> is enabled.   Something like the (untested) change below.
> 

Will try it out. Thanks for the suggestion.

Regards,
Vaibhav 

