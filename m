From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 0/4] Omap-related warnings compiling current mainline
 3.1-rc tree
Date: Sun, 21 Aug 2011 00:43:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108210041050.20233@utopia.booyaka.com>
References: <CAFULf_yR-Z8p4CWaM6i1A9GedvRGG2omBG2TVtmma09n1jyHWw@mail.gmail.com> <CAFULf_yYdu1jMSxou-GPr7voXArTnm5=s0U1ZcP=FQ3VUzhs0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33505 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab1HUGnj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Aug 2011 02:43:39 -0400
In-Reply-To: <CAFULf_yYdu1jMSxou-GPr7voXArTnm5=s0U1ZcP=FQ3VUzhs0g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bjarne Steinsbo <bsteinsbo@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

On Fri, 12 Aug 2011, Bjarne Steinsbo wrote:

> The warning from omap_display has not been fixed.  I could do
> something similar to what hsmmc.c is using, but I think this is
> unnessarily complex.  I think the real fix for this warning is to make
> the type of the returned value from
> omap_pm_get_dev_context_loss_count() be the same as the prototype in
> struct omap_dss_board_info.  I can't see why one should be u32, and
> the other int.  However, I don't know which to fix..

This one should be fixed in the 3.2 time frame by this patch:

"[PATCHv2 01/28] OMAP: change get_context_loss_count ret value to int"

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg50692.html


- Paul
