From: "Azbell, Brandon" <b-azbell@ti.com>
Subject: RE: pad configuration register doubt
Date: Sun, 15 Jun 2008 19:52:46 -0500
Message-ID: <9E8AB4F8CD83E542A3EF3F7DD3E7C55F054E2D0B@dlee11.ent.ti.com>
References: <8a5399150806150646v4a194084laec0f3a78fad1413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44179 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbYFPAwy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Jun 2008 20:52:54 -0400
Content-class: urn:content-classes:message
In-Reply-To: <8a5399150806150646v4a194084laec0f3a78fad1413@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: chandru vijayashankar <chandru.vijayshankar@gmail.com>, linux-omap@vger.kernel.org

Chandru,

>> What is the difference between pullup/pulldown selection and pullup
>> enable bits in the pad  configuration register of omap 3430
processor?
[Brandon] : There are 2 bits to control pullup/pulldown scenario.  The
PULLTYPESELECT determines whether a pullup resistor is connected to the
pad, or a pulldown resistor is connected to the pad.
The PULLUDENABLE is used to then enable this functionality.  You could
use this to place input pins into a known state when logic outside the
device is releasing that pin into a high-z state.

>> what is the meaning of input enable or offmode bits and why it is
needed.
[Brandon] : The MUXMODE field should be straightforward.  This is
determining what functionality is actually connected to the pin, as many
pins have several peripherals potentially brought out to it.  The safe
mode avoids any risk of electrical contention by configuring the pin as
an input with no functional interface mapped to it.

[Brandon] : The Off Mode configuration fields support the CORE power
domain off state management.  The OMAP3 device supports placing the CORE
logic (peripherals, interconnect, etc) into a power off state, or
retention state to minimize leakage currents.  However, reactivity to
wake-up events must still be ensured.  The device supports an off-mode
management scheme that allows deactivation of all modules, isolation of
their outputs and configuration of a dedicated off mode on the I/O pads
of the device.

For each pin, the following bits are used during this OFF mode scenario.
OFFENABLE : Off mode pin state override control
		Combined with output of PRCM OFF_MODE to switch I/O pad
control
		From functional path to the rest of the bits below.
OFFOUTENABLE : Off mode output enable.
		When enabled by PRCM.OFF_MODE AND OFFENABLE, this
controls the
		Output buffer to be in high-Z (=1) or OFFOUTVALUE (=0).
OFFOUTVALUE  : Off mode output value
OFFPULLUDENABLE : Off mode pullup/pulldown enable.
		Enabled when if OFF mode
OFFPULLTYPESELECT : Off mode pullup/pulldown selection.
		Enabled when if OFF mode


Brandon Azbell 

-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of chandru
vijayashankar
Sent: Sunday, June 15, 2008 8:47 AM
To: linux-omap@vger.kernel.org
Subject: pad configuration register doubt

Hi all,
  In the arch/arm/mach-omap2/mux.c file. i have some doubts of the
structure omap34xx_pins. What is the difference between pullup/pulldown
selection and pullup enable bits in the pad  configuration register
of omap 3430 processor. any help on the different bits in the control
pad configuration register.  why and where they are used. what is the
meaning of input enable or offmode bits and why it is needed.

With Warm Regards,
 chandru
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
