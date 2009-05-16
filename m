From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM
	MDK (Re: LDP support)
Date: Sat, 16 May 2009 09:19:04 +0100
Message-ID: <20090516081904.GB15328@n2100.arm.linux.org.uk>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030555A7D9@dbde02.ent.ti.com> <4A03F8DD.4070307@windriver.com> <87hbzv8rua.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33908 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbZEPIT2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 04:19:28 -0400
Content-Disposition: inline
In-Reply-To: <87hbzv8rua.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: "stanley.miao" <stanley.miao@windriver.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Fri, May 08, 2009 at 07:47:09PM +0300, Kalle Valo wrote:
> "stanley.miao" <stanley.miao@windriver.com> writes:
> 
> >> Looks like you used the CodeSourcery 2007q3 toolchain. This had been
> >> reported earlier. Switching to 2008q3 works.
> >
> > Yeah, Now the kernel booted. it's compiler's problem.
> 
> I was bitten by the same problem few weeks ago. Any chance of getting a
> warning/error if using 2007q3 compiler until the problem is fixed?

Is there any way of detecting the 2007q3 compiler?

With normal GCC versions, you can use __GNUC__, __GNUC_MINOR__ and
__GNUC_PATCHLEVEL__ to identify the three digit version number.
