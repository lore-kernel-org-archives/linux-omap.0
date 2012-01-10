From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHV2 REPOST 5/7] ARM: OMAP3PLUS PM: Add IO Daisychain support via hwmod mux
Date: Tue, 10 Jan 2012 09:46:07 -0800
Message-ID: <8739bnsb6o.fsf@ti.com>
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
	<1323878477-21122-6-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39274 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756496Ab2AJRqK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 12:46:10 -0500
Received: by mail-yw0-f44.google.com with SMTP id p56so1292915yhp.31
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 09:46:09 -0800 (PST)
In-Reply-To: <1323878477-21122-6-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Wed, 14 Dec 2011 21:31:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> IO Daisychain feature has to be triggered whenever there is a change in
> device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).

...in addition to the triggering still happening in the idle path,
right?   IIUC, after this series, there's still a call in omap_sram_idle().

> Now devices can idle independent of the powerdomain, there can be a window where device
> is idled and corresponding powerdomain can be ON/INACTIVE state. In such situations,
> since both module wake up is enabled at padlevel as well as io daisychain sequence is
> triggered, there will be 2 PRCM interrupts (Module async wake up via swakeup and IO Pad
> interrupt). But as PRCM Interrupt handler clears the Module Padlevel WKST bit in the
> first interrupt, module specific interrupt handler will not triggered for the second time
>
> Also look at detailed explanation given by Rajendra at
> http://www.spinics.net/lists/linux-serial/msg04480.html
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>

[...]

> +void omap_trigger_wuclk_ctrl(void)
> +{
> +	if (cpu_is_omap34xx())
> +		omap3_trigger_wuclk_ctrl();
> +
> +	if (cpu_is_omap44xx())
> +		omap4_trigger_wuclk_ctrl();
> +}

cpu_is_* usage is only acceptable at init time.  Please use a function
pointer initialized at init time for this.

Kevin
