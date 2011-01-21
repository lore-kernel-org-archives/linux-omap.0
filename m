From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4] omap3: Add basic support for 720MHz part
Date: Fri, 21 Jan 2011 13:54:49 -0800
Message-ID: <878vydgbx2.fsf@ti.com>
References: <1295522814-30351-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57296 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752946Ab1AUVyz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 16:54:55 -0500
Received: by pwj4 with SMTP id 4so491794pwj.38
        for <linux-omap@vger.kernel.org>; Fri, 21 Jan 2011 13:54:54 -0800 (PST)
In-Reply-To: <1295522814-30351-1-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Thu, 20 Jan 2011 16:56:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> This patch adds support for new speed enhanced parts with ARM
> and IVA running at 720MHz and 520MHz respectively. These parts
> can be probed at run-time by reading PRODID.SKUID[3:0] at
> 0x4830A20C [1].

>From my earlier review[1] of this patch:

Please expand this a little to describe exactly which parts have this
feature.  All OMAP3?  34xx? 35xx? what about 36xx/37xx?  ISTR the
runtime probing for this feature is available on 35xx but not on 34xx,
but a summary of this should be here.

In addition, if I'm recalling correctly about the inability to do
runtime detection on non-35xx parts, maybe documenting how board code
would enable this OPP would be helpful too.

Thanks,

Kevin

[1] http://marc.info/?l=linux-omap&m=129441890030307&w=2

