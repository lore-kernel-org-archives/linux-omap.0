From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Mon, 7 Jan 2013 21:35:04 +0000
Message-ID: <201301072135.05166.arnd@arndb.de>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com> <93BF5C62-ADE8-4EFC-9175-C2D7E43300E3@antoniou-consulting.com> <20130107210551.GL14149@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130107210551.GL14149@atomide.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Jon Loeliger <jdl@jdl.com>, Stephen Warren <swarren@wwwdotorg.org>, David Gibson <david@gibson.dropbear.id.au>, Benoit Cousson <b-cousson@ti.com>, Mitch Bradley <wmb@firmworks.com>, Alan Tull <atull@altera.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Joel A Fernandes <agnel.joel@gmail.com>, Rob Clark <robdclark@gmail.com>, Jason Kridner <jkridner@beagleboard.org>, Matt Ranostay <mranostay@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linus Walleij <linus.walleij@stericss>
List-Id: linux-omap@vger.kernel.org

(Adding Sascha Hauer, Linus Walleij, Lee Jones to Cc)

On Monday 07 January 2013, Tony Lindgren wrote:
> > 
> > At the end of the line, some kind of hardware glue is going to be needed.
> > 
> > I just feel that drawing from a sample size of 1 (maybe 2 if I get to throw
> > in the beagleboard), it is a bit premature to think about making it overly
> > general, besides the part that are obviously part of the infrastructure 
> > (like the DT overlay stuff).
> > 
> > What I'm getting at, is that we need some user experience about this, before
> > going away and creating structure out of possible misconception about the uses. 
> 
> IMHO stuff like this will be needed by many SoCs. Some examples of similar
> things for omaps that have eventually become generic frameworks have been
> the clock framework, USB OTG support, runtime PM, pinmux framework and
> so on.
> 
> So I suggest a minimal generic API from the start as that will make things
> a lot easier in the long run.

I agree. The ux500 platform already has the concept of "user interface boards",
which currently is not well integrated into devicetree. I believe Sascha
mentioned that Pengutronix had been shipping some other systems with add-on
boards and generating device tree binaries from source for each combination.

Ideally, both of the above should be able to use the same DT overlay logic
as BeagleBone, and I'm sure there are more of those.

	Arnd
