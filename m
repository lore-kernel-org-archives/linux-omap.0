From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/5] OMAP4: mux: Initialise OMAP4 mux pins.
Date: Thu, 18 Nov 2010 22:06:59 +0100
Message-ID: <4CE59573.80408@ti.com>
References: <1289806685-20688-1-git-send-email-r.sricharan@ti.com> <20101118190650.GK9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50710 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759523Ab0KRVFy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 16:05:54 -0500
In-Reply-To: <20101118190650.GK9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "R, Sricharan" <r.sricharan@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 11/18/2010 8:06 PM, Tony Lindgren wrote:
> * sricharan<r.sricharan@ti.com>  [101114 23:26]:
>> This series updates the core device drivers to use mux framework
>> for OMAP4 SDP and PANDA board. It's generated against the
>> linux-omap master branch. It has a dependency on the Benoit's
>> omap4 mux data series.
>
> <snip>
>
>> 2. Do PAD configuration independently for each module
>> Pros:
>> 	a. Avoids repetition of similar data for different boards.
>> 	b. Gives a knowledge of how pins are configured for a module
>> 	   to the respective owners.
>> 	c. Pads are not initialised unless they are really needed.
>> Cons:
>> 	a. Can become difficult to maintain if lot of data tend to be
>> 	   different across boards.
>
> For the common modules, we should have generic platform init code
> using hwmod. And that init code is the logical place to do the muxing.
>
> We also need to consider that the pin muxing is board specific.
> So in cases where the are alternative signal paths, we need to pass
> the signal names from board-*.c file to the platform driver init code.

What about the omap_board_mux array in board file? Do you want to get 
rid of it, or is the plan is to use that for pads that does not belong 
to any driver or pads that are purely board specific?

Regards,
Benoit
