From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: Fix muxing and regulator for wl12xx on
 the SDIO bus for pandaboard
Date: Wed, 18 Sep 2013 16:47:27 -0700
Message-ID: <20130918234726.GL9994@atomide.com>
References: <20130913190811.24617.97699.stgit@localhost>
 <20130913190953.24617.46506.stgit@localhost>
 <1379399214.4223.123.camel@porter.coelho.fi>
 <1379399290.4223.124.camel@porter.coelho.fi>
 <20130918000203.GS9994@atomide.com>
 <52396CA0.6030100@baylibre.com>
 <20130918175158.GW9994@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60881 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751607Ab3IRXrl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Sep 2013 19:47:41 -0400
Content-Disposition: inline
In-Reply-To: <20130918175158.GW9994@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Luca Coelho <luca@coelho.fi>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, Paolo Pisati <p.pisati@gmail.com>, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [130918 11:00]:
> * Benoit Cousson <bcousson@baylibre.com> [130918 02:12]:
> > Hi Tony,
> > 
> > On 18/09/2013 02:02, Tony Lindgren wrote:
> > >* Luca Coelho <luca@coelho.fi> [130916 23:35]:
> > >>On Tue, 2013-09-17 at 09:26 +0300, Luca Coelho wrote:
> > >>>Both patches look good to me, though I didn't have the time to retest
> > >>>them.
> > >>
> > >>Actually I don't even have a Blaze device anymore, so I can't really
> > >>test the second patch. :(
> > >
> > >OK no problem, I've tested it on panda es.
> > 
> > Do we have someone out-there that still own a Blaze?
> > 
> > Anyway, I'm about to send a DTS fix branch for -rc2, so I'll include
> > these two patches.
> 
> OK yes good please do pick them up, I'll drop them from my
> not-yet-pushed-out omap-for-v3.12/fixes.

Hmm looks like there's also some new regression in the
wl12xx driver:

# iwconfig wlan0
wlan0     no wireless extensions.

My test script was just doing:

# iw dev wlan0 scan

And that works fine. Luca, any ideas?

Regards,

Tony
