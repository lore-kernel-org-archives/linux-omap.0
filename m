From: Tony Lindgren <tony@atomide.com>
Subject: Re: [pm-wip/uart][PATCH 2/4] OMAP3: serial: Fix uart4 handling for
 3630
Date: Thu, 10 Jun 2010 14:12:17 +0300
Message-ID: <20100610111217.GA32208@atomide.com>
References: <53199.192.168.10.88.1275659023.squirrel@dbdmail.itg.ti.com>
 <871vcmq08s.fsf@deeprootsystems.com>
 <20100607100656.GE15515@atomide.com>
 <AANLkTikpHFyvk28hTm-jTk4wdJ0oldqyncaGH2slq6w4@mail.gmail.com>
 <AANLkTikS_f5UWDr8WYrHga_W8kIeTwUienx6K37LWF80@mail.gmail.com>
 <20100609142801.GK32208@atomide.com>
 <AANLkTimSZaqZbP84C35dKh5XVZxezo-54ihxkpNx_Dni@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61471 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758906Ab0FJLMT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jun 2010 07:12:19 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimSZaqZbP84C35dKh5XVZxezo-54ihxkpNx_Dni@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

* Govindraj <govindraj.ti@gmail.com> [100610 11:49]:
> 
> -> Shouldn't we just retrieve the offset and then use
>     omap_ctrl_writew\ omap_ctrl_readw calls?

Sure that works too. And that actually has the advantage
that it's more likely to keep the mux read/write access
in the platform init code.
 
> -> I hope muxmode configuration can be done in the
>     existing code itself by manually populating the mode
>    and use offset retrieved from omap_mux_request_signal
>    and use omap_ctrl_writew.
>    Any comment?

I'm not sure I follow you, but you should keep any mux
functions in the platform init code and keep the driver
as generic as possible.

Regards,

Tony
