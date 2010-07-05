From: Tony Lindgren <tony@atomide.com>
Subject: Re: multipath mux question
Date: Mon, 5 Jul 2010 16:10:22 +0300
Message-ID: <20100705131020.GX15951@atomide.com>
References: <AANLkTikb2w3is46Gw-r22F9n2Ockx5rzOWHGo49cnQ8G@mail.gmail.com>
 <20100705073642.GB15951@atomide.com>
 <AANLkTinuFnpTyMJaMLLulio2hmGHKfL_6VkJogsV_nDa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55052 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab0GENKd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 09:10:33 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinuFnpTyMJaMLLulio2hmGHKfL_6VkJogsV_nDa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [100705 14:43]:
> On Mon, Jul 5, 2010 at 10:36 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > We should just print a warning and return an error. Then we should
> > also start checking the return values for omap_mux_init_gpio
> > now that the code is converted over to use the new mux code.
> 
> Hm, not sure about return checking, what omap2_mmc_mux() can do when
> it sees omap_mux_init_gpio failing because of that inevitable gpio126
> multipath error?

Heh, right :) I guess in that case omap2_mmc_mux should not do anything
and assume the board-*.c file has set up the muxing.
 
Regards,

Tony
