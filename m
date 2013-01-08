From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Tue, 8 Jan 2013 11:15:43 +0200
Message-ID: <89A7A8FD-935E-4225-8C7B-EA1DBA0C2780@antoniou-consulting.com>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com> <93BF5C62-ADE8-4EFC-9175-C2D7E43300E3@antoniou-consulting.com> <20130107210551.GL14149@atomide.com> <201301072135.05166.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:59054 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751429Ab3AHJP4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 04:15:56 -0500
In-Reply-To: <201301072135.05166.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Jon Loeliger <jdl@jdl.com>, Stephen Warren <swarren@wwwdotorg.org>, David Gibson <david@gibson.dropbear.id.au>, Benoit Cousson <b-cousson@ti.com>, Mitch Bradley <wmb@firmworks.com>, Alan Tull <atull@altera.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Joel A Fernandes <agnel.joel@gmail.com>, Rob Clark <robdclark@gmail.com>, Jason Kridner <jkridner@beagleboard.org>, Matt Ranostay <mranostay@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linus Walleij <linus.walleij@stericsson.com>, Lee

Hi Arnd,

On Jan 7, 2013, at 11:35 PM, Arnd Bergmann wrote:

> (Adding Sascha Hauer, Linus Walleij, Lee Jones to Cc)
> 
> On Monday 07 January 2013, Tony Lindgren wrote:
>>> 
>>> At the end of the line, some kind of hardware glue is going to be needed.
>>> 
>>> I just feel that drawing from a sample size of 1 (maybe 2 if I get to throw
>>> in the beagleboard), it is a bit premature to think about making it overly
>>> general, besides the part that are obviously part of the infrastructure 
>>> (like the DT overlay stuff).
>>> 
>>> What I'm getting at, is that we need some user experience about this, before
>>> going away and creating structure out of possible misconception about the uses. 
>> 
>> IMHO stuff like this will be needed by many SoCs. Some examples of similar
>> things for omaps that have eventually become generic frameworks have been
>> the clock framework, USB OTG support, runtime PM, pinmux framework and
>> so on.
>> 
>> So I suggest a minimal generic API from the start as that will make things
>> a lot easier in the long run.
> 
> I agree. The ux500 platform already has the concept of "user interface boards",
> which currently is not well integrated into devicetree. I believe Sascha
> mentioned that Pengutronix had been shipping some other systems with add-on
> boards and generating device tree binaries from source for each combination.
> 
> Ideally, both of the above should be able to use the same DT overlay logic
> as BeagleBone, and I'm sure there are more of those.
> 
> 	Arnd

Hmm, I see. 

I will need some more information about the interface of the 'user interface boards'.
I.e. how is the board identified, what is typically present on those boards, etc.

Can we get some input by the owner of other similar hardware? I know the FPGA
people have similar requirements for example. There are other people that are hitting
problems getting DT to work with their systems, like the V4L people with the order
of initialization; see http://lwn.net/Articles/531068/. I think the V4L problem is
cleanly solved by the overlay being contained in the V4L device node and applied just before
the device is probed.

In the meantime it would be better to wait until we have some ack from the maintainers
of the core subsystems about what they think.
 
Regards

-- Pantelis

