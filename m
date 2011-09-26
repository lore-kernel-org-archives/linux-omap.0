From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/11] arm/dts: OMAP4: Add a main ocp entry bound to
 l3-noc driver
Date: Mon, 26 Sep 2011 14:44:30 -0700
Message-ID: <20110926214430.GH6324@atomide.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-11-git-send-email-b-cousson@ti.com>
 <20110923225825.GB6324@atomide.com>
 <4E806C50.80300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50739 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752517Ab1IZVof (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 17:44:35 -0400
Content-Disposition: inline
In-Reply-To: <4E806C50.80300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [110926 04:39]:
> On 9/24/2011 12:58 AM, Tony Lindgren wrote:
> >* Benoit Cousson<b-cousson@ti.com>  [110923 12:50]:
> >
> >How about just remove omap3_l3_init and omap4_l3_init completely
> >instead?
> >
> >There should not be any need for the platform glue code if the
> >driver, it's OK for us to require that either DT is passed from
> >the bootloader or as appended DT as soon as the appended DT patches
> >are merged.
> 
> Yeah, but we should still allow the others board files to work in
> case DT is not passed by the bootloader. Otherwise the DT support
> need to be added to every other boards, and in that case that
> generic board become useless. The effort / duplication will be much
> important if we start hacking every boards with some DT code in
> them.

OK..
 
> Whereas that code is simple and will be removed easily when the DT
> migration will be completed.

..let's keep it around until we have board-generic booting
and mounting root.

Regards,

Tony
