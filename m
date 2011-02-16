From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap3beagle: init musb default role by Kconfig
Date: Wed, 16 Feb 2011 11:02:01 +0200
Message-ID: <20110216090201.GM2497@legolas.emea.dhcp.ti.com>
References: <1297760100-7200-1-git-send-email-lliubbo@gmail.com>
 <20110215112350.GM2570@legolas.emea.dhcp.ti.com>
 <AANLkTik-tZKZ-0G1RBXD0rz1O4=wLXtHd2wTD-61dLm0@mail.gmail.com>
 <20110216080506.GC2497@legolas.emea.dhcp.ti.com>
 <AANLkTikjhkhQzDDVazEr8wP7JHnnonGs8GFytA=QaE6c@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:43157 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754055Ab1BPJCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 04:02:07 -0500
Received: by bwz4 with SMTP id 4so1239593bwz.11
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 01:02:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikjhkhQzDDVazEr8wP7JHnnonGs8GFytA=QaE6c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, archit@ti.com, tony@atomide.com, adrian.hunter@nokia.com

Hi,

On Wed, Feb 16, 2011 at 04:49:34PM +0800, Bob Liu wrote:
> > I can be related. Try this:
> 
> Yeah, it works. Thanks, sorry for the noise
> .
> BTW: Is the below patch which about musb_core.c will be merged into mainline ?

I thinking on doing that, yes.

-- 
balbi
