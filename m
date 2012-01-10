From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHV2 REPOST 6/7] ARM: OMAP3 PM: Remove IO Daisychain control from cpuidle
Date: Tue, 10 Jan 2012 09:56:21 -0800
Message-ID: <87lipfqw56.fsf@ti.com>
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
	<1323878477-21122-7-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:55982 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751849Ab2AJR4Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 12:56:24 -0500
Received: by mail-yw0-f43.google.com with SMTP id j56so5994398yhj.30
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 09:56:23 -0800 (PST)
In-Reply-To: <1323878477-21122-7-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Wed, 14 Dec 2011 21:31:16 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> As IO Daisy chain sequence is triggered via hwmod mux, there is no need to
> control it from cpuidle path for OMAP3.
>
> Also as omap3_disable_io_chain is no longer being used, just remove the function.
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>

In the TRM (4460 public TRM vM) it says:

  "The software must enable the I/O wakeup prior entering a low-power
   mode and disable it following a wake-up event."

but after this series, once it's enabled, it is never disabled.   What
am I missing?

Kevin
