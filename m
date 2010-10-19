From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/5] 32k sync timer meets hwmod
Date: Tue, 19 Oct 2010 12:23:19 +0300
Message-ID: <20101019092319.GF31170@legolas.emea.dhcp.ti.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41831 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757820Ab0JSJXf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 05:23:35 -0400
Content-Disposition: inline
In-Reply-To: <1287480136-2046-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Oct 19, 2010 at 04:22:11AM -0500, Balbi, Felipe wrote:
>Hi all,
>
>Converted 32k-sync timer to platform_driver
>and now using pm_runtime and hwmod.
>
>Tested on 3430 by me and 4430 by Tarun
>
>If someone could test on 2430 and 2420, I would
>be really glad.

of course, after it's tested on 2430 and 2420 I will re-send Ccing
LAKML and clksource maintainer.

-- 
balbi
