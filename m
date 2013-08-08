From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 4/9] ARM: OMAP2+: AM33XX: Reserve memory to comply with EMIF spec
Date: Thu, 08 Aug 2013 11:16:44 -0700
Message-ID: <87fvukhwtv.fsf@kernel.org>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-5-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:53100 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758083Ab3HHSQs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Aug 2013 14:16:48 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so3653056pbb.28
        for <linux-omap@vger.kernel.org>; Thu, 08 Aug 2013 11:16:48 -0700 (PDT)
In-Reply-To: <1375811376-49985-5-git-send-email-d-gerlach@ti.com> (Dave
	Gerlach's message of "Tue, 6 Aug 2013 12:49:31 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>

Dave Gerlach <d-gerlach@ti.com> writes:

> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>
> SDRAM controller on AM33XX requires that a modification of certain
> bit-fields in PWR_MGMT_CTRL register (ref. section 7.3.5.13 in
> AM335x-Rev H) is followed by a dummy read access to SDRAM. This
> scenario arises when entering a low power state like DeepSleep.
> To ensure that the read is not from a cached region we reserve
> some memory during bootup using the arm_memblock_steal() API.

Hmm, sounds to me an awful lot like the existing omap_bus_sync() ?

However, you remove that feature when you remove omap_reserve() here
becasue omap_reserve() ss not called from your new reserve function.
Are you *really* sure you don't need the functions called there?  This
is a pretty big change that's not mentioned anywhere in the changelog.

Kevin
