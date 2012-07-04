From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync
 timer
Date: Wed, 4 Jul 2012 19:41:10 +0300
Message-ID: <1341420070.2059.185.camel@sokoban>
References: <20120611004502.20034.8840.stgit@dusk>
	 <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com>
	 <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com>
	 <4FDA45F5.9090300@ti.com>
	 <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
	 <4FDB387C.7030003@ti.com>
	 <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>
	 <alpine.DEB.2.00.1207040652240.6760@utopia.booyaka.com>
	 <87mx3f38lh.fsf@ti.com>  <4FF46BF5.50308@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35038 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755Ab2GDQlV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jul 2012 12:41:21 -0400
In-Reply-To: <4FF46BF5.50308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On Wed, 2012-07-04 at 18:14 +0200, Benoit Cousson wrote:
> Hi Kevin,
> 
> On 07/04/2012 04:27 PM, Kevin Hilman wrote:
> 
> [...]
> 
> > Tested-by: Kevin Hilman <khilman@ti.com>
> > 
> > I confirm this version is now allowing CORE to hit retention during
> > suspend.
> > 
> > Benoit, I hope this is OK with you.  We need a fix for this in v3.5
> > since this is last core bug preventing CORE retention in v3.5.
> 
> On OMAP4 as well? I've just tried with the hwmod fix for AESS and USB
> and still cannot reach RET.
> 
> Am I missing some other patches for OMAP4?

You need also fixes for sl2if and mcpdm in addition to above.

-Tero


