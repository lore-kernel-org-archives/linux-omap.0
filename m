From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 04/15] ARM: OMAP2+: hwmod: Update the reset API for
 AM33XX
Date: Mon, 5 Nov 2012 17:57:52 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC0336F@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-5-git-send-email-vaibhav.bedia@ti.com>
 <5097639C.7000800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44561 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753651Ab2KER6E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 12:58:04 -0500
In-Reply-To: <5097639C.7000800@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Mon, Nov 05, 2012 at 12:28:36, Hiremath, Vaibhav wrote:
[...]
> > -	u32 mask = 1 << shift;
> > -
> > -	/* Check the current status to avoid  de-asserting the line twice */
> > -	if (am33xx_prm_is_hardreset_asserted(shift, inst, rstctrl_offs) == 0)
> > -		return -EEXIST;
> 
> Any specific reason why you have removed this check?

During bootup the hardreset line is asserted, so wouldn't that check lead
to the function always returning without doing anything?

Regards,
Vaibhav
