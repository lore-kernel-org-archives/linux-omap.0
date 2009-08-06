From: Hunyue Yau <h-l-omap@rehut.com>
Subject: Re: Fwd: MMC3 Overo
Date: Wed, 5 Aug 2009 19:13:55 -0700
Message-ID: <200908051913.55235.h-l-omap@rehut.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com> <4A79D104.60607@deeprootsystems.com> <4A79D5A7.3000500@balister.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netblock-66-245-251-24.dslextreme.com ([66.245.251.24]:46618
	"EHLO dragonslair.panasol.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751142AbZHFCUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 22:20:20 -0400
Received: from asus-2023584919.panasol.com (eeepc [10.10.40.161])
	by dragonslair.panasol.com (8.13.6/8.9.3) with ESMTP id n762AIbv009901
	for <linux-omap@vger.kernel.org>; Wed, 5 Aug 2009 19:10:19 -0700
In-Reply-To: <4A79D5A7.3000500@balister.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 05 August 2009 11:55, Philip Balister wrote:
> Kevin Hilman wrote:
> > Steve Sakoman wrote:
> >> On Wed, Aug 5, 2009 at 10:58 AM, Kevin
> >>
> >> Hilman<khilman@deeprootsystems.com> wrote:
> >>> Steve Sakoman wrote:
> >>>> And up to now in each case I shrug and say "no time to do that now,
> >>>> I'll just leave kernel pinmuxing turned off and do it in u-boot"
> >>>
> >>> I agree there are lots of shortcomings in the current mux code and
> >>> we've been hitting them regularily lately.
> >>>
> >>> That being said, for mux settings that done one-time only at boot,
> >>> what are
> >>> the problems you're running into?
> >>
> >> It's been a few months since I last encountered this, so the exact
> >> details are a bit fuzzy.
> >>
> >> I seem to recall that there were some basic issues with enabling
> >> kernel pinmuxing in that some of the setup that was done for all
> >> machines was just wrong for my particular machine.  IIRC, it was due
> >> to assumptions about which pad was used for a particular function (for
> >> those functions which can be steered to multiple GPIO pads).
> >>
> >> So I faced having to undo that change in my board file as well as any
> >> issues that may have arisen from glitches on the GPIO pins during the
> >> process.  And since there were several of these I gave up and turned
> >> off kernel pinmuxing.
> >>
> >> I'd be happy if we cleaned up the "one size fits all" pinmuxing to
> >> just that subset that truly does fit all boards, and leave the rest to
> >> the board files.  I'd also be content to have it all done in the board
> >> file for each machine.
> >
> > Indeed, any assumptions about common muxing that are not indeed common
> > are bugs and should be fixed.
> >
> > The "right" solution is to have everything in the kernel, and split
> > across SoC "common" init and board specific init.  Of course u-boot
> > will still have to do some early muxing, but it should be redone in
> > the kernel so it's trivial to change bootloaders.
> >
> > So the real missing piece is someone to step up and rework the mux code.
> > The bigger problem is that the vast majority of folks don't care about
> > the common case and only care about getting thing working for a specific
> > platform.
>
> I posted some changes to add support for changing the Beagle expansion
> connector MCSPI muxing in the board file and some general muxing
> questions and received no comments (OK, a number of people were on
> vacation). If people would like I can repost it to aid in discussion.
>
> I agree we need to more muxing in the kernel and less in u-boot. I do
> not want a different u-boot for the Beagle based on what I have
> connected to the expansion connector. (Same applies to the Overo)

It is worse then that. Doing it in U-boot implies a static mux config. I can 
see cases where there is a need to change the mux config during run time. For 
example on the OMAP3 Beagle board platform, there is an LCD connector with a 
signals that is shared with the onboard DVI framer and potentially an 
external LCD. Due to the limited number of signals, some of the shared lines 
might be used for a different function when the LCD is active but have to 
revert to the DSS control if the DVI framer is used. This would require the 
mux be dynamically programmable. 


>
> The current mux requires you make an entry in an enum, then a
> corresponding entry in an array to configure the pin. SO the enum length
> is basically number of pins * the number of possible pin configurations.
>
> There is no way to account for the different packages the OMAP3 is
> available in.
>
> Is the code omap specific, or is it shared with other chips?

My understanding iis the code is OMAP specific. OMAP2 and OMAP3 are very 
similar. 

One idea that was thrown around on the Beagle IRC channel is to replace this 
code with an API that would solve the scaling problem. Something like this:

omap_pinmux_config( PACKAGE_PIN_ID, MODE_N, INPUT_EN | PULL_UP ); 

Where PACKAGE_PIN_ID would be a #define or an enum used to map to a register. 
The name should encode the packagename and the pin/ball. This avoids the 
current confusion as the current enums do not indicate what package. 

The MODE_N is an ID to indicate which mode the pin should be put into.

INPUT_EN|PULL_UP are the options for the ball. 

For ease of integrating with existing code, #defines matching the current enum 
name can be created to map them the options. Such a define would also add 
back self documenting feature of the enum names.  

This is a very crude proposal but does this sound like something better? The 
other unknown is I am not familiar enough with the OMAP1 pinmux to know if 
this would work. 

>
> Philip
>
> > Kevin
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Hunyue Yau
