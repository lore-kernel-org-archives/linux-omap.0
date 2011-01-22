From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/13] OMAP: Basic DVFS Framework
Date: Sat, 22 Jan 2011 19:18:05 +0200
Message-ID: <20110122171805.GA14774@legolas.emea.dhcp.ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:45307 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751515Ab1AVRSL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 Jan 2011 12:18:11 -0500
Received: by mail-iy0-f169.google.com with SMTP id 17so2823248iyj.14
        for <linux-omap@vger.kernel.org>; Sat, 22 Jan 2011 09:18:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org

Hi,

On Fri, Jan 21, 2011 at 07:30:52PM +0530, Vishwanath BS wrote:
> This patch series introduces support for Dynamic Voltage and Frequency Scaling
> (DVFS) for OMAP devices. 
> 
> For detailed design details, refer to DVFS Documentation.

If this is supposed to be used by drivers I would rather not as it's yet
another OMAP-specific API to use.

Before you reply with "you can pass function pointers via platform_data"
let me say that even that is a burden, specially on devices which are
used by several archs.

Why don't you make it more generic like the OPP layer was created ?
Isn't it better to just build on top of the OPP layer and make this one
also generic ?

-- 
balbi
