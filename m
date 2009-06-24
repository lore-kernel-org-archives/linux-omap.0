From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4] OMAP2/3/4: PM: reset USB OTG module on boot
Date: Wed, 24 Jun 2009 15:27:32 -0700
Message-ID: <878wjh1d4b.fsf@deeprootsystems.com>
References: <1245877725-28896-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:45922 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbZFXW1c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 18:27:32 -0400
Received: by pxi28 with SMTP id 28so620434pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 24 Jun 2009 15:27:35 -0700 (PDT)
In-Reply-To: <1245877725-28896-1-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 24 Jun 2009 14\:08\:45 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

[...]

> +	iclk = clk_get(NULL, "hsotgusb_ick");
> +	if (WARN_ON(!iclk))
> +		goto out;

doh, this error check is wrong and will never fail.
Need to use IS_ERR().  v5 spinning up...


Kevin
