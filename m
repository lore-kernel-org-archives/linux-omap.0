From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/3] omap: zoom3: add zoom3 board support
Date: Sat, 24 Oct 2009 02:06:29 +0300
Message-ID: <20091023230629.GD13020@gandalf>
References: <1256325806-14400-1-git-send-email-vikram.pandita@ti.com>
 <1256325806-14400-2-git-send-email-vikram.pandita@ti.com>
 <1256325806-14400-3-git-send-email-vikram.pandita@ti.com>
 <1256325806-14400-4-git-send-email-vikram.pandita@ti.com>
 <A24693684029E5489D1D202277BE89444B781BAA@dlee02.ent.ti.com>
 <4AE2081E.7070501@ti.com>
 <A24693684029E5489D1D202277BE89444B781BAB@dlee02.ent.ti.com>
 <4AE21D54.2030109@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46580 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbZJWXG3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 19:06:29 -0400
Content-Disposition: inline
In-Reply-To: <4AE21D54.2030109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Oct 23, 2009 at 04:17:08PM -0500, Nishanth Menon wrote:
> Aguirre Rodriguez, Sergio Alberto had written, on 10/23/2009 03:07
> PM, the following:
> [...]
> >>Linux-OMAP build allows for both boards to be defined at the same time..
> >>so in theory you could have a single uImage. the strategy followed here
> >>will fail it.. since the board file is the same one.. it could be made
> >>to work though..
> >>
> >
> >Not with this approach :)
> >
> >How about making board-zoom3.c separate from board-zoom2.c, and do a
> >smarter way to share as much as possible?
> >
> >To modularize, I'll suggest taking a look at RX51 board files. That way you can have
> >board-zoom2.c, board-zoom3.c, with the modules shared accordingly in Makefile.
> >
> >Camera is already doing that ;)
> >
> >What do you think?
> Ack.

I guess this would only add a file with a MACHINE_START() for zoom3,
right ?

I'd rather go, for this case, board-n8x0.c-ish.

-- 
balbi
