From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Tue, 8 Jan 2013 16:12:59 +0000
Message-ID: <201301081612.59292.arnd@arndb.de>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com> <201301081212.29089.arnd@arndb.de> <51A6DFCC-BBC8-475D-88C4-1B22186339C1@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51A6DFCC-BBC8-475D-88C4-1B22186339C1@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Jon Loeliger <jdl@jdl.com>, Stephen Warren <swarren@wwwdotorg.org>, David Gibson <david@gibson.dropbear.id.au>, Benoit Cousson <b-cousson@ti.com>, Mitch Bradley <wmb@firmworks.com>, Alan Tull <atull@altera.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Joel A Fernandes <agnel.joel@gmail.com>, Rob Clark <robdclark@gmail.com>, Jason Kridner <jkridner@beagleboard.org>, Matt Ranostay <mranostay@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linus Walleij <linus>
List-Id: linux-omap@vger.kernel.org

On Tuesday 08 January 2013, Pantelis Antoniou wrote:
> On Jan 8, 2013, at 2:12 PM, Arnd Bergmann wrote:
> 
> > On Tuesday 08 January 2013, Lee Jones wrote:
> >>> If there is not, there is no way to automatically load the overlays; you can always
> >>> use the kernel command line, or have the a user space application to request the loading
> >>> of a specific board's overlay.
> >> 
> >> Unfortunately, there is no way to probe the UIBs. :(
> > 
> > I thought that some of the newer UIBs had it, just not the old ones.
> > As Pantelis says, we could at least detect the ones that have an EEPROM
> > on them, and use a command line option or device tree attribute for the others.
> > 
> >       Arnd
> 
> So I gather the new ones have an eeprom?

I don't remember the details unfortunately. Lee should be the one who can find out.
IIRC there was at least a single integeger number on them.

	Arnd
