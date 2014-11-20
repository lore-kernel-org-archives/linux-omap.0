From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] Add support for ADC on am437x-gp and
 am43x-epos-evm
Date: Thu, 20 Nov 2014 18:23:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411201821300.9204@utopia.booyaka.com>
References: <1415099728-10959-1-git-send-email-vigneshr@ti.com> <54657FFA.1070200@ti.com> <20141114185049.GB7046@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141114185049.GB7046-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 14 Nov 2014, Tony Lindgren wrote:

> * Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> [141113 20:09]:
> > 
> > On Tuesday 04 November 2014 04:45 PM, Vignesh R wrote:
> > > This series of patches enable ADC on am437x-gp-evm and am43x-epos-evm.
> > > The ADC clock hwmod data of am33xx has been moved to commom place so that
> > > both am43xx and am33xx can reuse them.
> > > tscadc DT node has been adided to am437x-gp and am43x-epos dt files.
> > > With these patches, ADC functionalities are now available on am43xx.
> > > 
> > > Changelog:
> > > 
> > > v2:
> > > Removed phy addresses in hwmod. Using DT instead.
> > > Removed unused "ti,am4372" compatible string.
> > > Use macro to set clk domain name.
> > > Fixed subject format of all patches
> > > 
> > 
> > Please accept these patches.
> 
> Adding Paul to Cc, I don't think Paul has seen these, probably because
> get_maintainer.pl did not catch these hwmod files?

Yeah we didn't have top-level coverage for the data files and my 
attempts to find other in-depth reviewers has so far failed.  So just sent 
this:

http://marc.info/?l=linux-omap&m=141650684712440&w=2

Want to take it upstream?


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
