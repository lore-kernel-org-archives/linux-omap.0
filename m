From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/2] ARM: OMAP4: clock data: Lock ABE DPLL on all
	revisions
Date: Fri, 4 Jan 2013 17:11:59 +0000
Message-ID: <20130104171159.GA2637@n2100.arm.linux.org.uk>
References: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com> <1357294163-4317-2-git-send-email-peter.ujfalusi@ti.com> <50E6F0CA.60309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40254 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040Ab3ADRMO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jan 2013 12:12:14 -0500
Content-Disposition: inline
In-Reply-To: <50E6F0CA.60309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 04, 2013 at 09:10:02AM -0600, Jon Hunter wrote:
> 
> On 01/04/2013 04:09 AM, Peter Ujfalusi wrote:
> > To avoid issues with audio caused by non locked ABE DPLL we should
> > make sure it is locked in all OMAP4 revisions.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > asda d
> 
> Not sure what the above is ;-)

And there I was, thinking it was referring to a chain of UK supermarkets. :)
