Return-Path: <SRS0=u7e7=4P=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F136AC11D3D
	for <linux-omap@archiver.kernel.org>; Thu, 27 Feb 2020 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE812246A1
	for <linux-omap@archiver.kernel.org>; Thu, 27 Feb 2020 16:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgB0QIY (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:08:24 -0500
Received: from muru.com ([72.249.23.125]:58058 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbgB0QIY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 27 Feb 2020 11:08:24 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4F0E980C0;
        Thu, 27 Feb 2020 16:09:08 +0000 (UTC)
Date:   Thu, 27 Feb 2020 08:08:20 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] Input: omap4-keypad - check state again for lost
 key-up interrupts
Message-ID: <20200227160820.GF37466@atomide.com>
References: <20200227020407.17276-1-tony@atomide.com>
 <20200227020407.17276-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227020407.17276-2-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [200227 02:05]:
> +		/* Check once after debounce time when no more keys down */
> +		if (!new_keys_pressed) {
> +			usleep_range(OMAP4_DEBOUNCE_MS * 1000 * 2,
> +				     OMAP4_DEBOUNCE_MS * 1000 * 3);
> +			new_keys_pressed = omap4_keypad_scan_keys(keypad_data);
> +		}

So this can be outside the loop. And we actually need to clear
the state looks like.

I'll send out v2 series of these after some more debugging.

Regards,

Tony
