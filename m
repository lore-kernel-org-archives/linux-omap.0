From: Luca Coelho <luca@coelho.fi>
Subject: Re: [PATCH 1/2] ARM: dts: Fix muxing and regulator for wl12xx on
 the SDIO bus for pandaboard
Date: Thu, 19 Sep 2013 20:21:32 +0300
Message-ID: <1379611292.4223.160.camel@porter.coelho.fi>
References: <20130913190811.24617.97699.stgit@localhost>
	 <20130913190953.24617.46506.stgit@localhost>
	 <1379399214.4223.123.camel@porter.coelho.fi>
	 <1379399290.4223.124.camel@porter.coelho.fi>
	 <20130918000203.GS9994@atomide.com> <52396CA0.6030100@baylibre.com>
	 <20130918175158.GW9994@atomide.com> <20130918234726.GL9994@atomide.com>
	 <1379569391.4223.148.camel@porter.coelho.fi>
	 <20130919145344.GM9994@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:34684 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab3ISRU4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Sep 2013 13:20:56 -0400
In-Reply-To: <20130919145344.GM9994@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, Paolo Pisati <p.pisati@gmail.com>, linux-omap@vger.kernel.org

On Thu, 2013-09-19 at 07:53 -0700, Tony Lindgren wrote:
> * Luca Coelho <luca@coelho.fi> [130918 22:50]:
> > On Wed, 2013-09-18 at 16:47 -0700, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [130918 11:00]:
> > > > * Benoit Cousson <bcousson@baylibre.com> [130918 02:12]:
> > > > > Hi Tony,
> > > > > 
> > > > > On 18/09/2013 02:02, Tony Lindgren wrote:
> > > > > >* Luca Coelho <luca@coelho.fi> [130916 23:35]:
> > > > > >>On Tue, 2013-09-17 at 09:26 +0300, Luca Coelho wrote:
> > > > > >>>Both patches look good to me, though I didn't have the time to retest
> > > > > >>>them.
> > > > > >>
> > > > > >>Actually I don't even have a Blaze device anymore, so I can't really
> > > > > >>test the second patch. :(
> > > > > >
> > > > > >OK no problem, I've tested it on panda es.
> > > > > 
> > > > > Do we have someone out-there that still own a Blaze?
> > > > > 
> > > > > Anyway, I'm about to send a DTS fix branch for -rc2, so I'll include
> > > > > these two patches.
> > > > 
> > > > OK yes good please do pick them up, I'll drop them from my
> > > > not-yet-pushed-out omap-for-v3.12/fixes.
> > > 
> > > Hmm looks like there's also some new regression in the
> > > wl12xx driver:
> > > 
> > > # iwconfig wlan0
> > > wlan0     no wireless extensions.
> > > 
> > > My test script was just doing:
> > > 
> > > # iw dev wlan0 scan
> > > 
> > > And that works fine. Luca, any ideas?
> > 
> > Have you compiled WEXT support in your kernel? iwconfig uses the
> > (deprecated) Wireless Extensions API.  iw uses the current nl80211 API.
> > 
> > If you want to use iwconfig and friends you need to enable
> > CONFIG_CFG80211_WEXT.
> 
> OK thanks, I don't need to use iwconfig. Looks like the default
> changed in commit 10bab00af (cfg80211: deprecate CFG80211_WEXT).

Yeah, it's not enabled by default anymore.  And it was more than about
time! ;)

--
Luca.

