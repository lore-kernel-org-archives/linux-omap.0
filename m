From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 00/22] twl4030 patches
Date: Mon, 29 Sep 2008 11:39:39 -0700
Message-ID: <200809291139.39844.david-b@pacbell.net>
References: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:27639 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752182AbYI2Sjm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2008 14:39:42 -0400
In-Reply-To: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

I seem to have gotten four copies of these patches ... I'll assume
that one of the "v3" sets is the way to go!  :)


On Monday 29 September 2008, Felipe Balbi wrote:
> I think now things are in pretty good shape and should be applied
> to linux-omap mailing list.

I'll verify that on my test setup, including some testing
for the new gpio irq_chip.set_type() methods.  (It's mostly
used for SD card insert/removal IRQs.  Awkward to test that
when your root FS is on an SD card!)


Granted that works OK I'll say it's time to merge the "v3"
patches so a few remaining things can be done in preparation
for submitting *parts* of the twl4030 for mainline.  Starting
with the core; then the other pieces as they become ready.

If anyone has issues to raise with that plan, do so quickly!


> With this patchset, we're moving twl4030 forward to a new registration
> method and several children were already moved to this new style.
> 
> There are plenty of bug fixes as well, mainly to gpio and core modules
> and still a lot of stuff to go.

Well, I'm not sure how much of it is actually "bug fixes" as
opposed to making it ready for upstream ... which involves

 * code cleanup, not limited to small checkpatch.pl stuff
 * some restructuring, to be more drivers/mfd-ish
 * moving things out of the drivers/i2c/chips directory
 * using standard interfaces not TWL-specific ones
 * ...etc...

Although it's true some bugs are getting found and fixed as part
of this.  Like at least two instances of freeing the primary
"power IRQ" instead of the relevant secondary IRQ, which is a
child of that primary one.  Looks like some folk were copying
code that was a bit goofy ... good thing that code rarely runs! :)


> We have a list of TODO so if people wanna help, go for it:

Let us know if you're going to help push part of the twl
code upstream though ... and if you're not going to need to
touch the core, then I suggest you wait for the the dust to
settle after all this "merge the core!" work.

And of course, Felipe's list isn't meant to be exhaustive...

Briefly, after the core moves to mainline, it'll be time to
move remaining TWL bits (a) out of drivers/i2c, and (b) to
mainline.


> This list will probably grow as we continue doing stuff. Dave
> has another queue waiting some other patches to get merged
> upstream. After that, I'd say twl4030-core.c could go
> upstream as well.

My queue is mostly for GPIO stuff, getting rid of twl-private
calls used by the hsmmc init code.  The "core" seems mostly
ready, except as I noted above.

 
> As these patches are quite important, give it a good review
> and test so we avoid surprises later.

>From what I can tell so far, these patches are ready for
merge now.  But review and test is always valuable.


> All-in-all, I'd say we can apply these patches and fix hsmmc.c
> in the road. What say you Dave ?

I'm sure I've said the same thing before.  :)

The hsmmc init logic is *currently* the only real user of
twl4030-gpio private interfaces.  Those interfaces can't
yet be removed ... but I'm working on it.


> I put a few printk to hsmmc.c 
> and could see that the request_irq for card_detect is the one
> which is failing. Maybe that TWL4030_GPIO_IRQ_NO() crap should
> be changed. Better, removed.

That's one of a bunch of global #defines that should vanish, yes.

- Dave
