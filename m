From: "R, Sricharan" <r.sricharan@ti.com>
Subject: RE: [PATCH 0/5] OMAP4: mux: Initialise OMAP4 mux pins.
Date: Tue, 16 Nov 2010 11:45:08 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930234A2AFD9@dbde02.ent.ti.com>
References: <1289886357-22821-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51351 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472Ab0KPGPT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 01:15:19 -0500
In-Reply-To: <1289886357-22821-1-git-send-email-r.sricharan@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "V, Aneesh" <aneesh@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>

Adding people in CC.

>This series updates the core device drivers to use mux framework
>for OMAP4 SDP and PANDA board. It's generated against the
>linux-omap master branch. It has a dependency on the Benoit's
>omap4 mux data series.
>
>	http://www.spinics.net/lists/linux-omap/msg40039.html
>
>sricharan (5):
>  OMAP4: hsmmc: Initialise the mmc mux pins
>  OMAP4: usb-musb: Initialise the usb mux pins.
>  OMAP4: mcbsp: Initialise the mcbsp mux pins
>  OMAP4: board-4430sdp: Initialise the mcspi mux pins
>  OMAP4: serial: Initialise the uart mux pins
>
> arch/arm/mach-omap2/board-4430sdp.c |   20 ++++++++
> arch/arm/mach-omap2/devices.c       |   83
>+++++++++++++++++++++++++++++++++++
> arch/arm/mach-omap2/mcbsp.c         |   33 +++++++++++++-
> arch/arm/mach-omap2/serial.c        |   38 ++++++++++++++++
> arch/arm/mach-omap2/usb-musb.c      |   41 +++++++++++++++++
> 5 files changed, 214 insertions(+), 1 deletions(-)
>
>While doing some internal reviews, there were few debates about existing
>mux framework usage. I am summarising that discussion here and would
>like to hear more on this from the community.
>
>1. PAD configuration for all pins should be done in a central place(board
>file)
>Pros:
>	a. All pins configured in a central place. Easy to ensure coverage
>	   and maintenance. Single place to look for all mux related settings
>	b. Drivers, unless they have run time pad configuration requirements
>	   need not worry about muxing.
>Cons:
>	a. Adds a lot of duplicate data in different board files assuming
>	   most of the pins will be connected the same way across different
>	   boards.
>
>2. Do PAD configuration independently for each module
>Pros:
>	a. Avoids repetition of similar data for different boards.
>	b. Gives a knowledge of how pins are configured for a module
>	   to the respective owners.
>	c. Pads are not initialised unless they are really needed.
>Cons:
>	a. Can become difficult to maintain if lot of data tend to be
>	   different across boards.
