From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Mon, 23 Jan 2012 04:02:50 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201230401170.29673@utopia.booyaka.com>
References: <1327055619.1921.57.camel@deskari>  <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>  <1327060886.1921.63.camel@deskari>  <CAORVsuVenz_fUPp3o_x+xrN3JJXDUyreMNvqjCPGzLrQf71EnQ@mail.gmail.com>  <1327063256.1921.68.camel@deskari>
  <CAORVsuVGT1AaMzo0r6T4vWe7zz7Uk=o-DydAcGdMzE+utDoUww@mail.gmail.com>  <1327071609.1921.82.camel@deskari> <20120122221132.32bd4d44@notabene.brown>  <1327308790.1916.30.camel@deskari>  <alpine.DEB.2.00.1201230154430.29673@utopia.booyaka.com>
 <1327310656.1916.31.camel@deskari>  <alpine.DEB.2.00.1201230229220.29673@utopia.booyaka.com> <1327315716.1916.34.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43783 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab2AWLCv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 06:02:51 -0500
In-Reply-To: <1327315716.1916.34.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: NeilBrown <neilb@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, Joe Woodward <jw@terrafix.co.uk>

On Mon, 23 Jan 2012, Tomi Valkeinen wrote:

> On Mon, 2012-01-23 at 02:31 -0700, Paul Walmsley wrote:
>
> > Want to spin a quick patch for v3.3-rc1 to add it?
> 
> I think there are other bits missing also. CLOCKACTIVITY is missing for
> DISPC. And DSI doesn't have any SYSC flags defined... I'll try to go
> through them all.

Might be best to do a minimal patch for the 3.3-rc series and stable trees 
that just sets the SYSC_HAS_ENAWAKEUP flag?  Then we can queue up a 
larger patch to fix the rest of the bits for the 3.4 merge window...


- Paul
