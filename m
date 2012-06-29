From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V3 3/3] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef
 around __omap2_set_globals
Date: Fri, 29 Jun 2012 05:44:27 -0700
Message-ID: <20120629124427.GE4202@atomide.com>
References: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
 <1340895567-22766-4-git-send-email-hvaibhav@ti.com>
 <4FEC72C2.7010106@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5D620@DBDE01.ent.ti.com>
 <4FEC7B33.5030500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64005 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab2F2Moa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 08:44:30 -0400
Content-Disposition: inline
In-Reply-To: <4FEC7B33.5030500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

* Benoit Cousson <b-cousson@ti.com> [120628 08:46]:
> On 06/28/2012 05:39 PM, Hiremath, Vaibhav wrote:
> >On Thu, Jun 28, 2012 at 20:35:38, Cousson, Benoit wrote:
> >>
> >>OMAP4 does not have the SDRC but the EMIF like TI8XX.
> >>
> >
> >Benoit,
> >
> >This selection is happening for SOC_OMAP2420 and not for OMAP4.
> 
> Hehe, indeed, I missed the context and was fooled by the config ARCH_OMAP4.
> 
> I don't have any comment then :-)

That's very close to Acked-by then?

Tony
