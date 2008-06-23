From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] OMAP3 EVM: Add twl4030 keypad driver support
Date: Tue, 24 Jun 2008 01:44:21 +0300
Message-ID: <20080623224421.GC5257@kedavra.cpe.vivax.com.br>
References: <48601ACD.6040804@ridgerun.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40895 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYFWWoO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2008 18:44:14 -0400
Content-Disposition: inline
In-Reply-To: <48601ACD.6040804@ridgerun.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miguel Angel Aguilar Ulloa <miguel.aguilar@ridgerun.com>
Cc: linux-omap@vger.kernel.org

On Mon, Jun 23, 2008 at 03:51:09PM -0600, Miguel Angel Aguilar Ulloa wrote:
> Add twl4030 keypad driver support to OMAP3 EVM

Generally all your patches look really good but the subject should be
something more self-explanatory.

For this first is ok, but second and third should be something like:

OMAP3: EVM: KEYPAD: Fix Kconfig dependency
OMAP3: EVM: KEYPAD: Add twl4030 keypad to defconfig

or something similar ;-)

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
