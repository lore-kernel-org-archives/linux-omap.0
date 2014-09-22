From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 3/3] mtd: nand: Force omap_elm to be built as a module if
 omap2_nand is a module
Date: Mon, 22 Sep 2014 12:04:07 -0700
Message-ID: <20140922190407.GU1193@ld-irv-0074>
References: <1410443224-18477-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1410443224-18477-4-git-send-email-ezequiel@vanguardiasur.com.ar>
 <5412B66F.8050505@ti.com>
 <20140912165636.GA7276@arch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:47446 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaIVTEL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2014 15:04:11 -0400
Received: by mail-pd0-f174.google.com with SMTP id g10so4493114pdj.33
        for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2014 12:04:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140912165636.GA7276@arch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, pekon <pekon@pek-sem.com>

On Fri, Sep 12, 2014 at 05:56:36PM +0100, Ezequiel Garcia wrote:
> Ultimately, I don't care much as I don't think anyone will build it as a module,
> except maybe for testing the driver under probe/remove cycles.

I see that you sort of answered one of my questions here. On what do you
base this claim? I see maintstream distros are gaining support for some
common ARM platforms, and I bet they ship loadable modules. Or are you
seeing otherwise?

Brian
