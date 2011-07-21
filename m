From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/2] omap4: board-omap4panda: prepare for join
Date: Thu, 21 Jul 2011 00:25:15 -0700
Message-ID: <20110721072515.GC5783@atomide.com>
References: <20110718084259.GY5783@atomide.com>
 <1311075927-5562-2-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:50927 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751183Ab1GUHZR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jul 2011 03:25:17 -0400
Content-Disposition: inline
In-Reply-To: <1311075927-5562-2-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org

* Jan Weitzel <j.weitzel@phytec.de> [110719 04:40]:
> Prepare board-omap4panda for joing other similar boards.
> Split common stuff into board-omap4panda-common.
> 
> MUX: board_mux and omap4_panda_mux
> omap4_common_preinit: for muxing
> omap4_common_init: all common devices
> struct panda_board_data: gpios, omap_board_data, i2c_board_info ...
> 
> some inititialisation check if omap4_panda_config entry is valid
> i2c_2_board_speed == 0 -> i2c_2 not used
> hup_power_gpio == -EINVAL -> gpio not used

This should probably be split into two patches:

- Prepare things for panda common code
- Move panda common code

That way we can see from the patches what actually
changes. Might also make sense to do it the other way
around for the two patches.

Regards,

Tony
