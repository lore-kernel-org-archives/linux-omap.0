From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: fix power field to hold all possible values
Date: Tue, 23 Feb 2010 20:01:50 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DA995E5@dbde02.ent.ti.com>
References: <1266918404-17715-1-git-send-email-ajay.gupta@ti.com>
 <20100223095154.GA12815@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981Ab0BWOcD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 09:32:03 -0500
In-Reply-To: <20100223095154.GA12815@gandalf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com]
> Sent: Tuesday, February 23, 2010 3:22 PM
> To: Gupta, Ajay Kumar
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] musb: fix power field to hold all possible values
> 
> Hi,
> 
> On Tue, Feb 23, 2010 at 03:16:44PM +0530, Ajay Kumar Gupta wrote:
> > MUSB can supply upto 500mA such as, AM3517 and OMAP3EVM Rev >=E and thus
> > the 'power' field has to hold values above 255.
> 
> power on the arch code is same as bMaxPower it will be multiplied by two
> on musb_core.c. See line 150 of that file.

Agreed but see comment below.

> 
> Meaning 500mA is set to 250 on the board-file.

Board files are providing the actual mA and it is getting divided in 
Arch/arm/mach-omap2/usb-musb.c. See the code snippet below,

        musb_plat.clock = "ick";
        musb_plat.board_data = board_data;
-->     musb_plat.power = board_data->power >> 1;
        musb_plat.mode = board_data->mode;

So we need to either take this patch or fix this logic of dividing the mA
supplied from all omap board files.

-Ajay
> 
> --
> balbi
