From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Fri, 21 Dec 2012 09:30:04 +0100
Message-ID: <8865776.jqeL1Eqbut@avalon>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com> <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:43820 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab2LUI2s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 03:28:48 -0500
In-Reply-To: <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>

Hi Steve,

On Wednesday 21 November 2012 16:08:06 Steve Sakoman wrote:
> On Thu, Oct 11, 2012 at 8:58 AM, Enric Balletbo Serra
> 
> <eballetbo@gmail.com> wrote:
> > I see that commit dac8eb5f (OMAPDSS: TFP410: rename dvi files to
> > tfp410) and commit 2e6f2ee7 (OMAPDSS: TFP410: rename dvi -> tfp410)
> > changes the panel driver used on some boards. I tested current
> > linux-next-20101011 kernel with my IGEPv2 board and DSS fails with
> > 
> > following error (see http://pastebin.com/VjPGCQDt for full log) :
> >    [   21.222808] omapdss OVERLAY error: check_overlay: paddr cannot be 0
> >    [   21.229583] omapdss OVERLAY error: check_overlay: paddr cannot be 0
> >    [   21.236236] omapfb omapfb: setup_plane failed
> 
> Was there ever any resolution to this issue?

Does mainline commit 950e2fb420d54bf0ee0de2fb0f146827a98330bf help ?

> I am seeing the same errors on Overo.  The video output actually
> works, but it appears that this error causes X to close and then
> restart repeatedly.
> 
> I'll add the printk's to omapfb_setup_plane() that were requested by
> Tomi and report back.

-- 
Regards,

Laurent Pinchart

