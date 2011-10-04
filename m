From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] OMAP4460: Clock: Adding support for 4460 specific
 clocks
Date: Mon, 3 Oct 2011 17:43:32 -0700
Message-ID: <20111004004331.GR6324@atomide.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
 <1316705361-12175-7-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.00.1109291911390.26728@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51200 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752635Ab1JDAne (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 20:43:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1109291911390.26728@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, Vishwanath BS <vishwanath.bs@ti.com>

* Paul Walmsley <paul@pwsan.com> [110929 17:40]:
> Hi
> 
> On Thu, 22 Sep 2011, Keerthy wrote:
> 
> > From: Vishwanath BS <vishwanath.bs@ti.com>
> > 
> > OMAP4460 specific clocks are not getting added as the
> > cpu_is_omap44xx is choosing only OMAP4430 specific clock nodes.
> > Changing it to add to OMAP4460 specific clocks also.
> > This is clocks are required of temperature sensor.
> > 
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > Cc: paul@pwsan.com 
> 
> Thanks, this patch has been queued for 3.2.

Should this be a fix for the -rc cycle instead?

Tony
