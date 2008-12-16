From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Default MUX configuration added - GPIO140-143,
	GPIO0 and GPIO9
Date: Tue, 16 Dec 2008 08:27:52 -0800
Message-ID: <20081216162751.GO19551@atomide.com>
References: <1229405483-32438-1-git-send-email-mani.pillai@ti.com> <FCCFB4CDC6E5564B9182F639FC356087025127BA53@dbde02.ent.ti.com> <19F8576C6E063C45BE387C64729E739403ECE3AB83@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52193 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669AbYLPQ1y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 11:27:54 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECE3AB83@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pillai, Manikandan <mani.pillai@ti.com> [081216 02:24]:
> Hi Vikram,
> 
> Pls find my comments inlined.
> 
> 
> 
> -----Original Message-----
> From: Pandita, Vikram 
> Sent: Tuesday, December 16, 2008 11:08 AM
> To: Pillai, Manikandan; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 1/1] Default MUX configuration added - GPIO140-143, GPIO0 and GPIO9
> 
> 
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Pillai,
> >Manikandan
> >Sent: Monday, December 15, 2008 11:31 PM
> >To: linux-omap@vger.kernel.org
> >Cc: Pillai, Manikandan
> >Subject: [PATCH 1/1] Default MUX configuration added - GPIO140-143, GPIO0 and GPIO9
> >
> >Default MUX configurations for GPIO on OMAP3 EVM boards are added.
> >Fixed for "_UP" naming convention for GPIOs comment.
> 
> Patch is fine but looks like 
> [Pillai, Manikandan] OK
> Mux framework seems to be not efficient.
> [Pillai, Manikandan] It's not efficient but I have just added the requirments for the new power board in the existing framework. Revamping the whole MUX logic
> would be a good amount of work.
> 
> "There is one GLOBAL table for all omap devices." 
> How maintainable is that? 
> Also care has to be taken to match the enum position with mux.c array location. This is error prone.
> 
> Mux tables should be per device basis.
> Any thoughts.

Yeah, well once we have the custom struct device, we should configure
the pins there. Some of the pins have multiple options and should be
configured in board-*.c files, but some devices have just one working
combination of pins.

So hopefully for most pins,  by selecting the devices that the board has,
the devices would configure the pins for the board.

Regards,

Tony
