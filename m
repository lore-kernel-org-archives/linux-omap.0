From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus: tahvo: Remove dead code from tahvo-usb.c
Date: Tue, 19 Apr 2011 13:05:12 +0300
Message-ID: <20110419100511.GB28899@legolas.emea.dhcp.ti.com>
References: <1303201193-11516-1-git-send-email-jhnikula@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:41745 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754571Ab1DSKFT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 06:05:19 -0400
Received: by fxm1 with SMTP id 1so4000561fxm.29
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 03:05:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1303201193-11516-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On Tue, Apr 19, 2011 at 11:19:53AM +0300, Jarkko Nikula wrote:
> Looks like this code was ever used. It was added by commit
> fe3702054f6412aea04373ceb9d27a4a417ff3f0 "OMAP: Fix USB on Nokia 770"
> that can be found from linux-omap history if needed.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

FWIW:

Reviewied-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
