From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC/PATCH] arm: omap3: pm: do not clear power states twice
Date: Fri, 3 Feb 2012 13:34:55 +0530
Message-ID: <CAMQu2gwtXyLzPNk2_4O+EAWyZaQs+wY_cK4pm_=yJj6ARXnhAw@mail.gmail.com>
References: <1328254094-13978-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:51860 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752407Ab2BCIFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Feb 2012 03:05:17 -0500
Received: by mail-qw0-f47.google.com with SMTP id z30so580212qad.6
        for <linux-omap@vger.kernel.org>; Fri, 03 Feb 2012 00:05:16 -0800 (PST)
In-Reply-To: <1328254094-13978-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>

On Fri, Feb 3, 2012 at 12:58 PM, Felipe Balbi <balbi@ti.com> wrote:
> The way the code is written, pwrdm_pre_transion()
> calls _pwrdm_pre_transition_cb() (for each powerdomain)
> which, in turn, calls pwrdm_clear_all_prev_pwrst().
>
> It looks unnecessary to clear all previous power
> states twice, so drop the initial set.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>
> Hasn't been tested yet. Compile tested only. It looks
> like we can safely remove those calls, but I would
> like to hear from the PM folks first :-)
>
Bit late :)

Paul already cleaned this up.
http://www.spinics.net/lists/linux-omap/msg63602.html

Regards
santosh
