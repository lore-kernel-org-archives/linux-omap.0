From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/6] TI816X: Update common OMAP machine specific
 sources
Date: Fri, 10 Dec 2010 17:51:03 -0800
Message-ID: <20101211015103.GC3054@atomide.com>
References: <1281546664-11477-1-git-send-email-hemantp@ti.com>
 <20100916222459.GQ29610@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03569BEEA3@dbde02.ent.ti.com>
 <20101105205943.GS9264@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0369E7C04D@dbde02.ent.ti.com>
 <20101129192927.GG17222@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0369F61ACE@dbde02.ent.ti.com>
 <20101206165308.GB8345@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B036A17C7A5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27147 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab0LKBvM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 20:51:12 -0500
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036A17C7A5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

* Pedanekar, Hemant <hemantp@ti.com> [101210 16:58]:
> Tony Lindgren wrote on Monday, December 06, 2010 10:23 PM:
> 
> [...]
> >> Similarly, we will also need to add TI816X specific hwmods.
> >> 
> >> 4) TI816X series shares similarity with OMAP4 too - e.g., various IPs are
> >> same, CM module is closer to OMAP4 than OMAP3. Thus, regaring (1) above, I
> >> could use OMAP4 code instead of adding new "else if". Of course, again,
> >> there are above mentioned differences too.
> > 
> > We really want to use same code for the shared modules so
> > using feature
> > based detection is the way to go.
> > 
> Tony,
> 
> Just wanted to confirm: so you are suggesting we do not have any
> cpu_is_ti81xx() check in the code - is that correct? 

We can have that, but we should avoid it where possible.
And ideally cpu_is_ti81xx() would be just something like:

#define cpu_is_ti81xx()		\\
	cpu_is_omap34xx() && omap_has_aaa() && omap_has_bbb()

Regards,

Tony
