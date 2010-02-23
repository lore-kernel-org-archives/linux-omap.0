From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] musb: fix power field to hold all possible values
Date: Tue, 23 Feb 2010 11:51:55 +0200
Message-ID: <20100223095154.GA12815@gandalf>
References: <1266918404-17715-1-git-send-email-ajay.gupta@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51998 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab0BWJxI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 04:53:08 -0500
Content-Disposition: inline
In-Reply-To: <1266918404-17715-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, Feb 23, 2010 at 03:16:44PM +0530, Ajay Kumar Gupta wrote:
> MUSB can supply upto 500mA such as, AM3517 and OMAP3EVM Rev >=E and thus
> the 'power' field has to hold values above 255.

power on the arch code is same as bMaxPower it will be multiplied by two
on musb_core.c. See line 150 of that file.

Meaning 500mA is set to 250 on the board-file.

-- 
balbi
