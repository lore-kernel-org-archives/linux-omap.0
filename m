From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/10] omap init_early changes for irq and timer init
Date: Tue, 29 Mar 2011 11:16:23 -0700
Message-ID: <87fwq5x05k.fsf@ti.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49471 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754119Ab1C2SQ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 14:16:28 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so392658iyb.19
        for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 11:16:27 -0700 (PDT)
In-Reply-To: <20110328221501.4046.41079.stgit@baageli.muru.com> (Tony
	Lindgren's message of "Mon, 28 Mar 2011 15:21:23 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> This series continues the work to only initialize minimal omap code
> in init_early and to cut down dependencies to code that should be
> initialized later. It also cleans up the omap2+ timer init code to prepare
> things for the later patches.
>
> After this series further patches can make the dmtimer code a regular
> device driver. Later on we can also move the clockource init happen 
> earlier to make sched_clock work properly with CONFIG_PRINTK_TIME.

This series looks OK to me.

My primary concerns were around the duplication of code between
early/system timers and the "real" device driver.  But it now looks like
those early timers will also be doing individual init using hwmod and
clock framework, so any duplication can be avoided.

Reviewed-by: Kevin Hilman <khilman@ti.com>

Kevin



