From: dmitry pervushin <dpervushin@embeddedalley.com>
Subject: Re: [PATCH 0/44] includecheck: fix multiple includes
Date: Thu, 09 Jul 2009 15:34:18 +0400
Message-ID: <1247139259.18729.21.camel@hp.diimka.lan>
References: <1247063308.4382.12.camel@ht.satnam>
	 <1247076059.4382.127.camel@ht.satnam>
	 <20090708211321.GA15928@flint.arm.linux.org.uk>
	 <1247113711.2453.27.camel@ht.satnam>
Reply-To: dpervushin@embeddedalley.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from easi.embeddedalley.com ([71.6.201.124]:58062 "HELO
	easi.embeddedalley.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756117AbZGILel (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 07:34:41 -0400
In-Reply-To: <1247113711.2453.27.camel@ht.satnam>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, davinci <davinci-linux-open-source@linux.davincidsp.com>, Hugo Villeneuve <hugo.villeneuve@lyrtech.com>, philip@opensdr.com, Sascha Hauer <s.hauer@pengutronix.de>, Eduardo Valentin <eduardo.valentin@indt.org.br>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Ben Dooks <ben@simtec.co.uk>, Vladislav Buzov <vbuzov@embeddedalley.com>, David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, arm <linux-arm@lists.arm.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>

On Thu, 2009-07-09 at 09:58 +0530, Jaswinder Singh Rajput wrote:
> On Wed, 2009-07-08 at 22:13 +0100, Russell King wrote:
> > On Wed, Jul 08, 2009 at 11:30:59PM +0530, Jaswinder Singh Rajput wrote:
> > > I am still waiting ACK/NAK for :
for this:
> > >       includecheck fix: arm, plat-stmp3xxx/pinmux.c
Acked-by: dmitry pervushin <dpervushin@embeddedalley.com>
> > 
> > You're still waiting because apparantly you never sent this set anywhere
> > near any ARM people before.
> > 
> > For the first two, I'll ack them:
> > 
> > Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > The remainder look sane to me, but you'll have to seek acks from the
> > individual platform maintainer(s).
> > 
> 
> OK, adding some more ARM people and ARM lists to get remaining ACK/NAK.
> 
> Patches are already posted to LKML and also available at :
> 
> http://git.kernel.org/?p=linux/kernel/git/jaswinder/headers-check-2.6.git;a=summary
> 
> In case if you are not able to find these patches let me know.
> 
> Thanks,
> --
> JSR
> 
> 

