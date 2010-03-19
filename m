From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PM-WIP-OPP][PATCH 3/4] omap: pm: opp: add ability to store
 data per opp
Date: Fri, 19 Mar 2010 19:47:28 +0200
Message-ID: <20100319174727.GB3836@gandalf>
References: <1268937891-19445-1-git-send-email-nm@ti.com>
 <1268937891-19445-2-git-send-email-nm@ti.com>
 <1268937891-19445-3-git-send-email-nm@ti.com>
 <1268937891-19445-4-git-send-email-nm@ti.com>
 <20100319144333.GU18995@nokia.com>
 <4BA3975E.70206@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51365 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab0CSRrM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 13:47:12 -0400
Content-Disposition: inline
In-Reply-To: <4BA3975E.70206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Hi,

On Fri, Mar 19, 2010 at 10:25:18AM -0500, Nishanth Menon wrote:
> Now, based on your proposal as I understand,
> struct omap2_data {
> blah_o21
> blah_o22
> };
> 
> struct omap3_data {
> blah_o31
> blah_o32
> blah_o33
> }
> 
> struct omap4_data {
> blah_o41
> blah_o42
> blah_o31
> blah_o32
> }
> 
> and so on (remember we may have shared or similar data between various 
> SOCs at times)
> 
> redundancy, maintenance are the problems i see other than ability to 
> have a module which uses blah_o31 to be generic and not know the 
> difference between struct omap3_data and omap4_data
> the resultant module code will look like:
> if (cpu_is_omap3430()) {
> 	my_blaho31 = ((struct omap3_data *) get_opp_data(opp))->blah_o31;
> } else if cpu_is...() {
> ..
> }

ok, I get your point.

> now in the approach I took,
> you could have:
> struct sr_ntarget_type{
> 	unsigned long nTarget;
> 	something else if needed
> }
> 
> And in SR driver, the module doesnot need to care which silicon it is 
> running on.. it just does opp_get_data(opp,"sr_ntarget") and gets the 
> correct data for that silicon on that OPP. It is much simpler and 
> similar to the manner implemented in many other frameworks such as clock 
> etc..

the thing is that ideally it would simply:

opp_get_data(opp);

and that should be done so that it fits all possibilities, but if it's
that different per-SoC, then I guess there's nothing to do.

-- 
balbi
