From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 04/15] ARM: OMAP2+: hwmod: Update the reset API for
 AM33XX
Date: Tue, 6 Nov 2012 06:06:20 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB635A4@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-5-git-send-email-vaibhav.bedia@ti.com>
 <5097639C.7000800@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC0336F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33646 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093Ab2KFGG1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 01:06:27 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC0336F@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Mon, Nov 05, 2012 at 23:27:52, Bedia, Vaibhav wrote:
> On Mon, Nov 05, 2012 at 12:28:36, Hiremath, Vaibhav wrote:
> [...]
> > > -	u32 mask = 1 << shift;
> > > -
> > > -	/* Check the current status to avoid  de-asserting the line twice */
> > > -	if (am33xx_prm_is_hardreset_asserted(shift, inst, rstctrl_offs) == 0)
> > > -		return -EEXIST;
> > 
> > Any specific reason why you have removed this check?
> 
> During bootup the hardreset line is asserted, so wouldn't that check lead
> to the function always returning without doing anything?
> 

The check is,

/* Check the current status to avoid  de-asserting the line twice */
if (am33xx_prm_is_hardreset_asserted(shift, inst, rstctrl_offs) == 0)
	return -EEXIST;


The code is checking whether the line is already de-asserted (== 0), so I am 
not sure how this will change if hardreset line is asserted during bootup.

Thanks,
Vaibhav

