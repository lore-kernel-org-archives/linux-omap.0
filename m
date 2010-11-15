From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/5] OMAP4: mux: Initialise OMAP4 mux pins.
Date: Mon, 15 Nov 2010 23:33:48 +0100
Message-ID: <4CE1B54C.40306@ti.com>
References: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44103 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758211Ab0KOWdU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Nov 2010 17:33:20 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAFMXJBL025181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 16:33:19 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id oAFMXJfK025070
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 16:33:19 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAFMXJPr029064
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 16:33:19 -0600 (CST)
In-Reply-To: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Sricharan" <r.sricharan@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Sricharan,

On 11/15/2010 8:38 AM, R, Sricharan wrote:
> This series updates the core device drivers to use mux framework
> for OMAP4 SDP and PANDA board. It's generated against the
> linux-omap master branch. It has a dependency on the Benoit's
> omap4 mux data series.
> 	
> 	http://www.spinics.net/lists/linux-omap/msg38995.html

I've just realized that this is not the latest one, here it is:
http://www.spinics.net/lists/linux-omap/msg40039.html

Regards,
Benoit

>
> sricharan (5):
>    OMAP4: hsmmc: Initialise the mmc mux pins
>    OMAP4: usb-musb: Initialise the usb mux pins.
>    OMAP4: mcbsp: Initialise the mcbsp mux pins
>    OMAP4: board-4430sdp: Initialise the mcspi mux pins
>    OMAP4: serial: Initialise the uart mux pins
>
>   arch/arm/mach-omap2/board-4430sdp.c |   20 ++++++++
>   arch/arm/mach-omap2/devices.c       |   83 +++++++++++++++++++++++++++++++++++
>   arch/arm/mach-omap2/mcbsp.c         |   33 +++++++++++++-
>   arch/arm/mach-omap2/serial.c        |   38 ++++++++++++++++
>   arch/arm/mach-omap2/usb-musb.c      |   41 +++++++++++++++++
>   5 files changed, 214 insertions(+), 1 deletions(-)
>
> While doing some internal reviews, there were few debates about existing
> mux framework usage. I am summarising that discussion here and would
> like to hear more on this from the community.
>
> 1. PAD configuration for all pins should be done in a central place(board file)
> Pros:
> 	a. All pins configured in a central place. Easy to ensure coverage
> 	   and maintenance. Single place to look for all mux related settings
> 	b. Drivers, unless they have run time pad configuration requirements
> 	   need not worry about muxing.
> Cons:
> 	a. Adds a lot of duplicate data in different board files assuming
> 	   most of the pins will be connected the same way across different
> 	   boards.
>
> 2. Do PAD configuration independently for each module
> Pros:
> 	a. Avoids repetition of similar data for different boards.
> 	b. Gives a knowledge of how pins are configured for a module
> 	   to the respective owners.
> 	c. Pads are not initialised unless they are really needed.
> Cons:
> 	a. Can become difficult to maintain if lot of data tend to be
> 	   different across boards.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

