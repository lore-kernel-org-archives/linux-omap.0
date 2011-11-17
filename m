From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 4/6] OMAP3: cpuidle: next C-state decision depends on the PM QoS MPU and CORE constraints
Date: Thu, 17 Nov 2011 13:29:54 -0800
Message-ID: <877h2y30a5.fsf@ti.com>
References: <1319032263-22699-1-git-send-email-j-pihet@ti.com>
	<1319032263-22699-5-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56017 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752144Ab1KQVaA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Nov 2011 16:30:00 -0500
Received: by mail-gx0-f179.google.com with SMTP id q2so2032507ggn.24
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 13:29:58 -0800 (PST)
In-Reply-To: <1319032263-22699-5-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Wed, 19 Oct 2011 15:51:01 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> The MPU latency figures for cpuidle include the MPU itself and also
> the peripherals needed for the MPU to execute instructions (e.g.
> main memory, caches, IRQ controller, MMU etc). On OMAP3 those
> peripherals belong to the MPU and CORE power domains and so the
> cpuidle C-states are a combination of MPU and CORE states.
>
> This patch implements the relation between the cpuidle and per-
> device PM QoS frameworks in the OMAP3 specific idle callbacks.
>
> The chosen C-state shall satisfy the following conditions:
>  . the 'valid' field is enabled,
>  . it satisfies the enable_off_mode flag,

Not directly related to this patch, but is there any reason to keep the
'enable_off_mode' flag after this series?

Kevin
