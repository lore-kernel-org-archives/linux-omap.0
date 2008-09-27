From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 5/8] i2c: move twl4030-usb to platform_device
Date: Fri, 26 Sep 2008 20:13:27 -0700
Message-ID: <5e088bd90809262013w1e300ce3g257a3ad8fa7b065d@mail.gmail.com>
References: <1222422061-3940-1-git-send-email-felipe.balbi@nokia.com>
	 <1222422061-3940-2-git-send-email-felipe.balbi@nokia.com>
	 <1222422061-3940-3-git-send-email-felipe.balbi@nokia.com>
	 <1222422061-3940-4-git-send-email-felipe.balbi@nokia.com>
	 <1222422061-3940-5-git-send-email-felipe.balbi@nokia.com>
	 <1222422061-3940-6-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:58136 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbYI0DN3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 23:13:29 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1410995wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2008 20:13:28 -0700 (PDT)
In-Reply-To: <1222422061-3940-6-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Fri, Sep 26, 2008 at 2:40 AM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> use new style twl4030-core to register a platform_device
> for twl4030-usb.
>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c     |    6 +
>  arch/arm/mach-omap2/board-3430sdp.c     |    5 +
>  arch/arm/mach-omap2/board-ldp.c         |    7 +
>  arch/arm/mach-omap2/board-omap2evm.c    |    5 +
>  arch/arm/mach-omap2/board-omap3beagle.c |    7 +
>  arch/arm/mach-omap2/board-omap3evm.c    |    6 +-

board-overo.c should have the same changes made.

Should I submit a separate patch or can you incorporate in the the
next revision?

Steve
