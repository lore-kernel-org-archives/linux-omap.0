From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: omap24xx is broken in current head
Date: Sun, 10 Aug 2008 15:16:56 +0300
Message-ID: <20080810121655.GH7574@frodo>
References: <20080810115818.GG7574@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43488 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbYHJMRE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Aug 2008 08:17:04 -0400
Content-Disposition: inline
In-Reply-To: <20080810115818.GG7574@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Sun, Aug 10, 2008 at 02:58:19PM +0300, Felipe Balbi wrote:
> <5>Kernel command line: root=1f03 rootfstype=jffs2
> <6>Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
> <1>Unhandled fault: alignment exception (0x001) at 0xc02c1b4e

Reverting commit 718fc6cd4db902aa2242a736cc3feb8744a4c71a, looks like
gcc is not being able to align that union ??

I'm using codesourcery 2008q1-126 (gcc 4.2.3)

Did you guys have any problems with this version of CS ??

-- 
balbi
