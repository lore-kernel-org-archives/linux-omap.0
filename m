From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: Re: [PATCH v3 2/3] OMAP: SDP: Introducing 'board-sdp-flash.c' for
	flash init
Date: Mon, 8 Feb 2010 16:32:10 +0100
Message-ID: <20100208153210.GA12307@localhost.localdomain>
References: <ce9ab5791002080508t33283d20k7f08f1dbf42d2718@mail.gmail.com>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.76.43]:43106 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab0BHOcR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Feb 2010 09:32:17 -0500
Content-Disposition: inline
In-Reply-To: <ce9ab5791002080508t33283d20k7f08f1dbf42d2718@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Mon, Feb 08, 2010 at 06:38:57PM +0530, Vimal Singh wrote:
> In this version: (as per comments recieved for 2nd version)
> - remove 'omap_set_vpp' function
> - set 'set_vpp' to null

Ah, I'm sorry for not being quite exact. "leave set_vpp set to NULL" means
there is no need to asign anything to that structure member, because BSS is
zeroed (set to NULL) anyway. Something like this:

static struct physmap_flash_data sdp_nor_data = {
	.width          = 2,
};

Yes, this is a nitpick only...
