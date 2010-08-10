From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] omap: n8x0: Audio update to N810
Date: Tue, 10 Aug 2010 15:07:34 +0300
Message-ID: <20100810120733.GI32480@atomide.com>
References: <1281340740-10823-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61166 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923Ab0HJMHi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 08:07:38 -0400
Content-Disposition: inline
In-Reply-To: <1281340740-10823-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jhnikula@gmail.com> [100809 10:50]:
> Hi
> 
> With this set and a fix [1] it is possible to get ALSA SoC on N810 working.
> 
> This set is generated against mainline commit e320cea but applies also to
> linux-omap (board-n8x0.c has cbus patches in linux-omap).

I've added these into omap for-next for 2.6.37. Let me know if these should
go in along with other ASoC patches.

Regards,

Tony
 
> 1. http://marc.info/?l=linux-omap&m=128109830113485&w=2
