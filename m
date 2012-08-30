From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm/dts: Cleanup regulator naming and remove @0,1..
Date: Thu, 30 Aug 2012 13:48:26 -0700
Message-ID: <20120830204825.GE1303@atomide.com>
References: <1343653940-16614-1-git-send-email-rnayak@ti.com>
 <1343653940-16614-3-git-send-email-rnayak@ti.com>
 <20120824202725.GA1303@atomide.com>
 <503C6380.4090107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:44036 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab2H3Us3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 16:48:29 -0400
Content-Disposition: inline
In-Reply-To: <503C6380.4090107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, b-cousson@ti.com

* Rajendra Nayak <rnayak@ti.com> [120827 23:22]:
> Hi Tony,
> 
> >* Rajendra Nayak<rnayak@ti.com>  [120730 06:17]:
> >>regulators do not have a 'reg' property, hence the regulator@0,
> >>regulator@1 do not make sense. get rid of it.
> >
> >Looks like this needs to be refreshed to apply. Care to
> >refresh against current devel-dt branch in case other
> >places need the same change?
> 
> Looks like devel-dt is missing the PATCH 1/2 from this series,
> which you have already pushed in the -rc for merge.
> With that applied, this ones applies cleanly too.

Oh OK thanks :) I'll apply it on top of the fix and merge
into devel-dt.

Tony
