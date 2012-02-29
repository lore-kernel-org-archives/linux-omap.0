From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 04/13] ARM: OMAP3+: SmartReflex: Add a shutdown hook
Date: Wed, 29 Feb 2012 16:53:12 -0600
Message-ID: <20120229225310.GA7400@kobold>
References: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
 <1330554829-11347-5-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:32976 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754248Ab2B2WxM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 17:53:12 -0500
Received: by mail-yw0-f50.google.com with SMTP id j63so2867259yhj.37
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 14:53:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1330554829-11347-5-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, balbi@ti.com, Jean Pihet <j-pihet@ti.com>

On 23:33-20120229, Jean Pihet wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> SmartReflex fix for erratum ID i724.
> 
> Since OMAP's VP and PRM modules do not get reset by warm reset,
> we should ensure that proper shutdown procedure is followed prior
> to allowing the kernel to reboot back up.
> 
Considering [1], can we rephrase the following?
> Without this patch, Smartreflex module might be left active or
IMHO, the word "patch" is redundant :)
> system might be caught in an indeterminate sequence when reboot
when software controlled reboot is triggered
> is triggered, leaving the next reboot behavior to be unpredictable.

In the case of hardware controlled warm reset such as that by watchdog
timer, prevention of this scenario is not possible.


[..]
-- 
Regards,
Nishanth Menon
[1] http://marc.info/?l=linux-omap&m=133053887101828&w=2
