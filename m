From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/27] cbus: tahvo: convert spinlock into mutex
Date: Mon, 17 Oct 2011 10:20:35 -0700
Message-ID: <20111017172035.GB27515@atomide.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34652 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab1JQRUi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Oct 2011 13:20:38 -0400
Content-Disposition: inline
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [111013 01:01]:
> GPIO operations can sleep, so move to a
> mutex.

Great, seems to boot on n800 so pushing all into
cbus branch.

Tony
