From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: drop unused function
Date: Mon, 16 Jun 2014 05:07:13 -0700
Message-ID: <20140616120712.GJ17845@atomide.com>
References: <1402435596-5486-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58133 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751445AbaFPMHP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2014 08:07:15 -0400
Content-Disposition: inline
In-Reply-To: <1402435596-5486-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Brian Norris <computersforpeace@gmail.com> [140610 14:31]:
> gic_init_irq() is no longer used as of:
> 
>     commit b42b918194c4791510ac049e3d507169a7de8544
>     Author: Tony Lindgren <tony@atomide.com>
>     Date:   Thu May 30 12:53:05 2013 -0700
> 
>         ARM: OMAP2+: Remove board-omap4panda.c
> 
> Drop it.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Applying into omap-for-v3.16/fixes thanks.

Tony
