From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: cm-t35: add mux initialization
Date: Mon, 7 Dec 2009 09:44:46 -0800
Message-ID: <20091207174446.GY24013@atomide.com>
References: <cover.1259481545.git.mike@compulab.co.il>
 <4B1BCE62.1050005@compulab.co.il>
 <20091207162209.GV24013@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C863C8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58025 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758145AbZLGRoq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 12:44:46 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309C863C8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Mike Rapoport <mike@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [091207 08:35]:
> Tony Lindgren wrote: 
> > * Mike Rapoport <mike@compulab.co.il> [091206 07:30]:
> > > Tony,
> > > Any chance this can go to 2.6.33?
> > 
> > Sure, I was just waiting to hear back if the OUTPUT_PULLUP is
> > needed for sure? Or is just OUTPUT enough for musb to work?
> > 
> > Tony
> > 
> 
> OUTPUT should work too. The ULPI spec recommends a weak pull-up
> on STP line, but we needn't really have that. Plain OUTPUT is sufficient.

OK, thanks for checking that. Mike, what do you prefer to do?

I guess in some cases the pull may be needed for a pin
to change faster if an external pull is not used?

We could add the OUTPUT_PULL defines, but we should probably
mark them with comments that they should be rarely needed.

Regards,

Tony

