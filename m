From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2: Delete unnecessary checks before three
 function calls
Date: Thu, 16 Jul 2015 14:06:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507161406190.12339@utopia.booyaka.com>
References: <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net> <54705EC3.90708@users.sourceforge.net> <55928739.5040809@users.sourceforge.net> <alpine.DEB.2.02.1507160548040.32764@utopia.booyaka.com>
 <20150716062305.GF17550@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150716062305.GF17550@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

On Wed, 15 Jul 2015, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [150715 22:58]:
> > Hello Markus
> > 
> > On Tue, 30 Jun 2015, SF Markus Elfring wrote:
> > 
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Tue, 30 Jun 2015 14:00:16 +0200
> > > 
> > > The functions clk_disable(), of_node_put() and omap_device_delete() test
> > > whether their argument is NULL and then return immediately.
> > > Thus the test around the call is not needed.
> > > 
> > > This issue was detected by using the Coccinelle software.
> > > 
> > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > 
> > Thanks for the patch.  I have to say, I am a bit leery about applying the 
> > omap_device.c and omap_hwmod.c changes, since the called functions -- 
> > omap_device_delete() and clk_disable() -- don't explicitly document that 
> > NULLs are allowed to be passed in.  So there's no explicit contract that 
> > callers can rely upon, to (at least in theory) prevent those internal NULL 
> > pointer checks from being removed.
> > 
> > So I would suggest that those two functions' kerneldoc be patched first to 
> > explicitly state that passing in a NULL pointer is allowed.  Then I would 
> > feel a bit more comfortable applying the omap_device.c and omap_hwmod.c 
> > changes.
> > 
> > The kerneldoc for of_node_put() does explicitly allow NULLs to be passed 
> > in.  So I'll apply that change now for v4.3, touching up the commit 
> > message accordingly.
> 
> I have them applied from a later thread already, but will drop both in
> my branch as I have not pushed them out yet.

Oops sorry about stepping on your toes - I obviously missed that followup.

- Paul
