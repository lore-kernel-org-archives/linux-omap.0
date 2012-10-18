From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/NOT FOR MERGING 3/5] arm: omap: introduce other PM methods
Date: Thu, 18 Oct 2012 10:07:31 -0700
Message-ID: <878vb3g14c.fsf@deeprootsystems.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
	<1350488043-5053-4-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33159 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120Ab2JRRHQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 13:07:16 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so8479349pad.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Oct 2012 10:07:16 -0700 (PDT)
In-Reply-To: <1350488043-5053-4-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Wed, 17 Oct 2012 18:34:01 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Felipe Balbi <balbi@ti.com> writes:

> current omap_device PM implementation defines
> omap-specific *_noirq methods but uses the
> generic versions for all other PM methods.
>
> As it turns out, if a device decides to implement
> non-runtime PM callbacks, we might fall into a
> situation where the hwmod is still idled which
> will generate an abort exception when we try
> to access device's address space while clocks
> are still gated.

Please explain in more detail how this could happen.

Kevin

> In order to solve that, we implement all other
> methods taking into account that devices might
> not implement those, in which case we return
> early.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
