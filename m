From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: OMAP4: Add support for McPDM
Date: Fri, 18 Dec 2009 10:51:30 +0000
Message-ID: <20091218105129.GB19544@sirena.org.uk>
References: <2256F256009DAA4CBE661E9F41EAC84B8BA0A6D2@dlee01.ent.ti.com> <20091217202821.GA30379@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:39900 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbZLRKvg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 05:51:36 -0500
Content-Disposition: inline
In-Reply-To: <20091217202821.GA30379@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "ext Candelaria Villareal, Jorge" <x0107209@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Dec 17, 2009 at 10:28:21PM +0200, Felipe Balbi wrote:
> On Thu, Dec 17, 2009 at 08:40:32PM +0100, ext Candelaria Villareal, Jorge wrote:

> >+config SND_OMAP_SOC_MCPDM
> >+       tristate

> look at how SND_OMAP_SOC_N810 is done, can't you follow that ? put some 
> description ad help ?

This is fine - DAI drivers should be selected by machine drivers rather
than by users since they are useless without the machine drivers.  This
means that they shouldn't have a description.

> >+EXPORT_SYMBOL(omap_mcpdm_start);
> >+EXPORT_SYMBOL(omap_mcpdm_stop);
> >+EXPORT_SYMBOL(omap_mcpdm_set_uplink);
> >+EXPORT_SYMBOL(omap_mcpdm_set_downlink);
> >+EXPORT_SYMBOL(omap_mcpdm_clr_uplink);
> >+EXPORT_SYMBOL(omap_mcpdm_clr_downlink);
> >+EXPORT_SYMBOL(omap_mcpdm_request);
> >+EXPORT_SYMBOL(omap_mcpdm_free);

> way too many exported symbols, no ? Doesn't ALSA API have proper place 
> for this kind of stuff ? I'd need ALSA experts to reply to that but it 
> does smell funny...

With the McBSP these things are all exported because the McBSP isn't
just used by ALSA, I beleive, but a PDM interface is probably only ever
going to be used by audio.
