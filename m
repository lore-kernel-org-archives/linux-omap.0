From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Mon, 23 Jan 2012 02:04:36 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201230154430.29673@utopia.booyaka.com>
References: <1327055619.1921.57.camel@deskari>  <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>  <1327060886.1921.63.camel@deskari>  <CAORVsuVenz_fUPp3o_x+xrN3JJXDUyreMNvqjCPGzLrQf71EnQ@mail.gmail.com>  <1327063256.1921.68.camel@deskari>
  <CAORVsuVGT1AaMzo0r6T4vWe7zz7Uk=o-DydAcGdMzE+utDoUww@mail.gmail.com>  <1327071609.1921.82.camel@deskari> <20120122221132.32bd4d44@notabene.brown> <1327308790.1916.30.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45472 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab2AWJEh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 04:04:37 -0500
In-Reply-To: <1327308790.1916.30.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: NeilBrown <neilb@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, Joe Woodward <jw@terrafix.co.uk>

On Mon, 23 Jan 2012, Tomi Valkeinen wrote:

> Then I noticed that the DISPC's ENWAKEUP is not set. Setting ENWAKEUP
> (with SIDLEMODE/IDLEMODE in smart mode) also removes the problem.

Sounds like you've nailed it.

What is perplexing is that the hwmod code should be setting this by 
default in omap_hwmod.c:_enable_sysc().  I wonder why that is not 
happening.


- Paul
