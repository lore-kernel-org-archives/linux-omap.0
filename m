From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Registering sgx device and it's platform data
Date: Fri, 30 Apr 2010 11:12:13 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F78A9F2@dbde02.ent.ti.com>
References: <1272523585-26759-1-git-send-email-manjugk@ti.com>
 <87d3xi73se.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58962 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624Ab0D3REL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 13:04:11 -0400
In-Reply-To: <87d3xi73se.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Agarwal, Preshit" <preshit.agarwal@ti.com>, Tony Lindgren <tony@atomide.com>, "Turquette, Mike" <mturquette@ti.com>, "V, Hemanth" <hemanthv@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Thursday, April 29, 2010 7:35 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Agarwal, Preshit; Tony 
> Lindgren; Turquette, Mike; V, Hemanth
> Subject: Re: [PATCH] OMAP3: PM: Registering sgx device and 
> it's platform data
> 
> Manjunatha GK <manjugk@ti.com> writes:
> 
> > The SGX powervr_device is registered with it's platform specific
> > data to provide information about setting constraint through
> > omap_pm_set_min_bus_tput.
> >
> > Signed-off-by: Preshit Agarwal <preshit.agarwal@ti.com>
> > Signed-off-by: Manjunatha GK <manjugk@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Mike Turquette <mturquette@ti.com>
> > Cc: Hemanth V <hemanthv@ti.com>
> 
> Re: $SUBJECT, why the PM: prefix?

Since omap_sgx_data is under CONFIG_PM flag, hence title was 
prefixed with "PM". I will remove the same in next version of the patch.

-Manjunath

