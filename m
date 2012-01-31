From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: PM: clean up omap_set_pwrdm_state()
Date: Tue, 31 Jan 2012 09:16:56 +0530
Message-ID: <4F276430.2020406@ti.com>
References: <20120130093931.11027.31048.stgit@dusk> <20120130094317.11027.82072.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:47086 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752892Ab2AaDrF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 22:47:05 -0500
Received: by yhfs35 with SMTP id s35so2619314yhf.41
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 19:47:03 -0800 (PST)
In-Reply-To: <20120130094317.11027.82072.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Paul,

On Monday 30 January 2012 03:13 PM, Paul Walmsley wrote:
> Clean up a few different parts of omap_set_pwrdm_state():
>
> - Remove a superfluous call to pwrdm_state_switch().  Not needed
>    unless LOWPOWERSTATECHANGE is used, because the state switch code is
>    called by either clkdm_sleep() or clkdm_allow_idle().
>
> - Add code to wait for the power state transition in the OMAP4+ low
>    power state change.  This is speculative, so I would particularly
>    appreciate feedback on this part.
>
> - Remove a superfluous call to pwrdm_read_pwrst().
>
> - Update variable names to be more meaningful (hopefully) and precise.
>
> - Fix an error path bug that would not place the clockdomain back into
>    hardware-supervised idle or sleep mode if the power state could not
>    be programmed.

All the changes look good. Thanks.
Acked-by: Rajendra Nayak <rnayak@ti.com>

regards,
Rajendra

>

