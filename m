From: "R, Sricharan" <r.sricharan@ti.com>
Subject: RE: [PATCH 0/5] OMAP4: mux: Initialise OMAP4 mux pins.
Date: Fri, 19 Nov 2010 14:18:37 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247388A41@dbde02.ent.ti.com>
References: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
 <20101118190650.GK9264@atomide.com> <4CE59573.80408@ti.com>
 <20101118212626.GN9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39429 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab0KSIso convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 03:48:44 -0500
In-Reply-To: <20101118212626.GN9264@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Friday, November 19, 2010 2:56 AM
>To: Cousson, Benoit
>Cc: R, Sricharan; linux-omap@vger.kernel.org
>Subject: Re: [PATCH 0/5] OMAP4: mux: Initialise OMAP4 mux pins.
>
>* Cousson, Benoit <b-cousson@ti.com> [101118 12:56]:
>> On 11/18/2010 8:06 PM, Tony Lindgren wrote:
>> >* sricharan<r.sricharan@ti.com>  [101114 23:26]:
>> >>This series updates the core device drivers to use mux framework
>> >>for OMAP4 SDP and PANDA board. It's generated against the
>> >>linux-omap master branch. It has a dependency on the Benoit's
>> >>omap4 mux data series.
>> >
>> ><snip>
>> >
>> >>2. Do PAD configuration independently for each module
>> >>Pros:
>> >>	a. Avoids repetition of similar data for different boards.
>> >>	b. Gives a knowledge of how pins are configured for a module
>> >>	   to the respective owners.
>> >>	c. Pads are not initialised unless they are really needed.
>> >>Cons:
>> >>	a. Can become difficult to maintain if lot of data tend to be
>> >>	   different across boards.
>> >
>> >For the common modules, we should have generic platform init code
>> >using hwmod. And that init code is the logical place to do the muxing.
>> >
>> >We also need to consider that the pin muxing is board specific.
>> >So in cases where the are alternative signal paths, we need to pass
>> >the signal names from board-*.c file to the platform driver init code.
>>
>> What about the omap_board_mux array in board file? Do you want to
>> get rid of it, or is the plan is to use that for pads that does not
>> belong to any driver or pads that are purely board specific?
>
>Well we might as well keep it around for now as that's the way
>some people prefer to do the muxing. But yeah, eventually that
>could be for only board specific unused pads.
>
>I'll post some sample patches related to the uart (re)muxing
>within next few days, then let's see how that will work for
>other devices.
>
>Here's the rough plan in case you have some ideas on it:
>
>1. board-*.c code calls omap_serial_init_port with struct omap_device_mux
>   array that contains the pin names
>
>2. serial.c init code muxes the pins the right way and sets
>   wake-up events for omap3 & 4. It also populates the runtime
>   remux values needed for omap2 uart
>
>3. serial.c init code saves the struct omap_device_mux pointer
>   to the related hwmod entry
>
>4. omap_device_idle/shutdown can then call omap_remux if the
>   omap_device_mux entry exists
>   ...
>
>This should solve how devices need to initialize the pads.
>It should also work for all devices that may require runtime
>remuxing, like some USB transceivers and eMMC.


Ok . This means that the pin muxing introduced
 would be applicable for omap 2 ,3 and 4 also, with the
board file passing the respective data if they are different ?


>Regards,
>
>Tony
