From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: PandaBoard: remove unused power regulators
Date: Fri, 18 Mar 2011 16:43:25 -0700
Message-ID: <20110318234325.GD18583@atomide.com>
References: <1300216227-21138-1-git-send-email-x0132446@ti.com>
 <87y64dbypm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52751 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757646Ab1CRXn1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Mar 2011 19:43:27 -0400
Content-Disposition: inline
In-Reply-To: <87y64dbypm.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: David Anders <x0132446@ti.com>, linux-omap@vger.kernel.org, andy.green@linaro.org

* Kevin Hilman <khilman@ti.com> [110317 07:34]:
> David Anders <x0132446@ti.com> writes:
> 
> > the pandaboard does not use the VUSIM or VAUX1 power regulators on the TWL6030
> > and are left floating. if the VUSIM and VAUX1 power regulators are initilized,
> > noise on the unloaded regulators generates an overcurrent interrupt causing the
> > system to power down. this patch removes the initialization of the unused power
> > regulators of VUSIM and VAUX1.
> >
> > Signed-off-by: David Anders <x0132446@ti.com>
> 
> Thanks for finding and fixing the root cause.
> 
> Tested-by: Kevin Hilman <khilman@ti.com>

Applying into fixes.

Tony
