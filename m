From: <aaro.koskinen@nokia.com>
Subject: RE: [PATCH 8/8] OMAP: DSS2: OMAPFB: Reduce stack usage
Date: Tue, 10 May 2011 19:08:05 +0000
Message-ID: <CA1B555B4D79E3448D96A7C9847C7D9805EFB4C7@008-AM1MPN1-031.mgdnok.nokia.com>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>,<1305044656-31512-9-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:57231 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518Ab1EJTIR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 May 2011 15:08:17 -0400
In-Reply-To: <1305044656-31512-9-git-send-email-tomi.valkeinen@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

Tomi Valkeinen [tomi.valkeinen@ti.com]:
> omapfb_mode_to_timings() had struct fb_info, struct fb_var and struct
> fb_ops allocated from stack. This caused the stack usage grow quite
> high.
>
> Use kzalloc to allocate the structs instead.

[...]

> +       fbi = kzalloc(sizeof(*fbi), GFP_KERNEL);
> +       var = kzalloc(sizeof(*var), GFP_KERNEL);
> +       fbops = kzalloc(sizeof(*fbops), GFP_KERNEL);
> +       fbi->fbops = fbops;

You should check and prepare for allocation failures.

A.
