From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/6] omap: Board specific muxing using hwmod
Date: Tue, 21 Dec 2010 10:04:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012210739570.1446@utopia.booyaka.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41714 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0LUREJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 12:04:09 -0500
In-Reply-To: <20101203004040.31687.9476.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

On Thu, 2 Dec 2010, Tony Lindgren wrote:

> Here are some patches to allow us to pass the board specific mux data
> to the platform level device init code, and then allow hwmod state
> changes to do the pin muxing.
> 
> Dynamic remuxing is also supported as needed, the last patch in this
> series sets up the board-*.c data for n8x0 to do uart3 rx pin remuxing
> for the idle modes.

Tony and I have been discussing these patches recently.  Here are some of 
the topics from that conversation, to share with the lists.  Tony, I hope 
I've summarized our discussions accurately; please correct anything you 
feel I've misstated below.  For those new to OMAP mux/padconf discussions, 
there is a short glossary at the bottom of this message that might be 
useful.

- Tony mentioned that the patch set had several purposes.  One purpose is 
to provide a mechanism for dynamic padconf reprogramming based on the 
state of a hwmod, such as in patch 6.  But another important purpose is to 
try to figure out a way to move common padconf programming out of the 
board files wherever it's possible and into the subarch-to-driver 
integration code in arch/arm/*omap*.

- In the past, I had suggested that the hwmod data should contain a list 
of signals for each hwmod.  (For example, uart2_hwmod would have 
"uart2_tx", "uart2_rts", "uart2_cts", and "uart2_rx" associated with it in 
the hwmod data.)  The hwmod code would indicate to the mux code when the 
signals associated with a hwmod became "enabled," "idle," or "shutdown," 
as the hwmod's state changed.  But looking at the code, and trying a 
sample implementation of this, I suspect this approach, while conceptually 
clean, may be too heavyweight for dynamic padconf reprogramming between 
the enable and idle states, as in patch 6.  In that patch, there's only 
one pad that needs to be reprogrammed when the hwmod goes idle, or is 
re-enabled.  No current need to iterate over all of the hwmod's signals.  
So, for the current use-case, we agreed that enable/idle dynamic padconf 
reprogramming could be done only for the specific pads that needed to 
change; and could be triggered by the hwmod's state, rather than the state 
of the hwmod's individual signals.  If at some point in the future it 
makes sense to add the signals to the hwmod data, we can always do it 
then.

- We also discussed where to store the dynamically-created padconf 
reprogramming data.  We agreed that we should probably defer storing the 
data in the omap_device layer.  The struct omap_device_board_data and 
struct omap_device_pad don't have any pointers or other references to or 
from struct omap_device.  We discussed that it might make more sense to 
store that data in the mux layer or in the hwmod data.  For the current 
scope of these patches, we agreed that it probably makes sense to 
associate that dynamically-created data to the struct hwmod.

- We also discussed that it might make sense to defer adding a bdata the 
omap_device_build() interface for this merge window, until we had a better 
sense of the use cases and how the board data relates to the 
platform_data.  We agreed that, in general, we should try to move as much 
of the common padconf details as possible out of the individual board 
files.

...

Based on the discussion and review, I had a few specific comments on the 
patches:

- It looks like patch 6 can use static mux directives for all but one of 
its dynamic padconf reprogramming entries (uart3_rx_irrx).  In terms of 
enable/idle padconf reprogramming, it might be worth trying to minimize 
the number of these, since many IP blocks can switch frequently between 
idled and enabled states.

- It seems like it might be problematic to program CONTROL_PADCONF 
registers based on the enabled/idled/shutdown state of a single hwmod.  
This is because the CONTROL_PADCONF settings affect multiple hwmods.  For 
example, the correct setting of ETK_D1 pad on OMAP3 can depend on the 
state of several different hwmods: ETK, McSPI3, HSUSB, GPIO1.  If dynamic 
padconf reprogramming directives for the same pad(s) (e.g., ETK_D1) are 
associated with more than one of these hwmods, then the final padconf 
setting could be unpredictable: basically, the last hwmod to change state 
will be the one that determines the setting of the padconf register.  
Ultimately, it may be necessary to make dynamic padconf reprogramming 
directives conditional on the states of all of the hwmods that are 
associated with a pad.  For example, something like this:

omap_mux_add_dynamic_remux(etk_hwmod,    HWMOD_STATE_NOT_ENABLED,
	                   mcspi3_hwmod, HWMOD_STATE_ENABLED,
                           hsusb1_hwmod, HWMOD_STATE_NOT_ENABLED,
                           gpio1_hwmod,  HWMOD_STATE_DONT_CARE,
                           "etk_d1", OMAP_MUX_MODE1)

meaning that pad "etk_d1" would only be programmed to mode 1 (mcspi3_somi)
when:

(etk_hwmod_state != HWMOD_STATE_ENABLED) &&
(mcspi3_hwmod_state == HWMOD_STATE_ENABLED) &&
(hsusb1_hwmod == HWMOD_STATE_NOT_ENABLED)

This may not be necessary to implement right away, since the use cases are 
not clear; and code to implement this will need some careful engineering 
to keep it from becoming too heavyweight.  If it does become necessary, it 
seems that this type of data would then be best stored in some higher 
layer than the struct hwmod.

...

We also discussed one other general comment about the mux layer - not 
related to these patches.  Since some signals can appear on multiple pads, 
at some point in the future, maybe in the future it might be useful to 
allow board files to specify their pad configurations in terms of (package 
ID, ball ID) -> (signal ID) -- so, for example, (CUS, AC11) -> (gpio_81).  
The idea being that the board designer, using a PCB design tool, might 
someday be able to export a list of padconf settings out of their EDA 
tools that we could use in the board files.  Looking at the OMAP3530 IBIS 
model at 

   http://focus.ti.com/lit/mo/symlink/omap3530-25_cus__ibis_model.ibs

it includes both the ball ID (which it calls the "pin") and the pad/mode 0 
name (which it calls the "signal name").

It still makes sense to me for padconf constraints associated with 
subarch-to-driver integration code -- such as usb-musb.c or usb-ehci.c - 
to refer to signals (since that's what is meaningful for those IP blocks) 
and let the mux code figure out what pads those signals appear on for that 
board's configuration.  That way, that code can stay board 
file-independent...


Just some thoughts, more comments welcome.


- Paul


An informal glossary for the usage of padconf-related terms in this 
E-mail:


signal: an on-chip input or output signal, exported by an on-chip IP block 
        such as UART2 or I2C1.  These signals can be routed to the
        OMAP IO multiplexing device controlled by the CONTROL_PADCONF
        registers.  Some examples of signals: "uart3_rx_irrx", "cam_d6".
        Some signals can appear on multiple pads, e.g., on 
        OMAP3, "uart1_rx" be muxed to the dss_data7 pad or the uart1_rx 
        pad.

pad: the area on the OMAP silicon die that may be connected to a ball or a 
     pin on the exterior OMAP package.  Each pad is controlled by a
     16-bit wide CONTROL_PADCONF register.  These 16-bit registers can be 
     named by their "mode 0 name", which is unique for a silicon
     design.

ball: an electrical connection point on the plastic OMAP package, 
      connecting to the printed circuit board or to a POPped chip, on 
      OMAPs in ball-grid array (BGA) packages.  Balls are identified
      with codes such as "AC23" or "Y22", documented in the chip data 
      manual.  Also called "pin"

mode 0 name: used in the context of pads and CONTROL_PADCONF registers, 
             the mode 0 name is the name of the signal that is connected 
             to that pad when the CONTROL_PADCONF register associated with 
             that pad is set to mux mode 0.

package: an enclosure for OMAP silicon, that contains small wires that 
         connect pads on the silicon to balls or other connection points
         on the exterior of the package.  One type of OMAP, e.g. 
         OMAP3430 ES3.1, might be available in several different packages 
         with different ball spacing, POP vs. non-POP, etc.  TI identifies 
         their OMAP packages with three letter codes, e.g., "CBC", "CUS", 
         "ZAC".

driver code: code in drivers/*

subarch-to-driver code: code in arch/arm/*omap* that creates an 
                        omap_device

padconf: pad configuration details that are programmed into the 
         CONTROL_PADCONF registers - these details include
         the mux mode, pull settings, off-mode pad configuration, etc.
