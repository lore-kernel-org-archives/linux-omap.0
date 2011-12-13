From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v5 0/6] PM QoS: implement the OMAP low level constraints management code
Date: Tue, 13 Dec 2011 15:53:20 -0800
Message-ID: <87zkewrpu7.fsf@ti.com>
References: <1323706701-6627-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:47442 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750938Ab1LMXxZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 18:53:25 -0500
Received: by mail-qw0-f49.google.com with SMTP id c14so240495qad.1
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 15:53:24 -0800 (PST)
In-Reply-To: <1323706701-6627-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Mon, 12 Dec 2011 17:18:15 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <j-pihet@ti.com>

Hi Jean,

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> . Implement the devices wake-up latency constraints using the global
>   device PM QoS notification handler which applies the constraints to the
>   underlying layer
> . Implement the low level code which controls the power domains next power
>   states, through the hwmod and pwrdm layers
> . Add cpuidle and power domains wake-up latency figures for OMAP3, cf. 
>   comments in the code and [1] for the details on where the numbers
>   are magically coming from
> . Implement the relation between the cpuidle and per-device PM QoS frameworks
>   in the OMAP3 specific idle callbacks.
>   The chosen C-state shall satisfy the following conditions:
>    . the 'valid' field is enabled,
>    . it satisfies the enable_off_mode flag,
>    . the next state for MPU and CORE power domains is not lower than the
>      state programmed by the per-device PM QoS.

I had a couple minor comments on this version, but after that, feel free
to add:

Reviewed-by: Kevin Hilman <khilman@ti.com>

after that, this series will go upstream through Paul.

Kevin
