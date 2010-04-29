From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Registering sgx device and it's platform data
Date: Thu, 29 Apr 2010 07:05:05 -0700
Message-ID: <87d3xi73se.fsf@deeprootsystems.com>
References: <1272523585-26759-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f183.google.com ([209.85.221.183]:38332 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933825Ab0D3S25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 14:28:57 -0400
Received: by qyk13 with SMTP id 13so617757qyk.1
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 11:28:56 -0700 (PDT)
In-Reply-To: <1272523585-26759-1-git-send-email-manjugk@ti.com> (Manjunatha GK's message of "Thu\, 29 Apr 2010 12\:16\:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Preshit Agarwal <preshit.agarwal@ti.com>, Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@ti.com>, Hemanth V <hemanthv@ti.com>

Manjunatha GK <manjugk@ti.com> writes:

> The SGX powervr_device is registered with it's platform specific
> data to provide information about setting constraint through
> omap_pm_set_min_bus_tput.
>
> Signed-off-by: Preshit Agarwal <preshit.agarwal@ti.com>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Mike Turquette <mturquette@ti.com>
> Cc: Hemanth V <hemanthv@ti.com>

Re: $SUBJECT, why the PM: prefix?

Kevin

