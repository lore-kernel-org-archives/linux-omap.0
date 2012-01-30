From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: PM: clean up omap_set_pwrdm_state()
Date: Mon, 30 Jan 2012 17:47:40 +0530
Message-ID: <CAMQu2gwsj6h0FqfY74jrA9ZVbjV650SLEUticQRiB+dSOWgNsQ@mail.gmail.com>
References: <20120130093931.11027.31048.stgit@dusk> <20120130094317.11027.82072.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:51846 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752609Ab2A3MSB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 07:18:01 -0500
Received: by mail-qw0-f42.google.com with SMTP id y23so1466873qad.15
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 04:18:00 -0800 (PST)
In-Reply-To: <20120130094317.11027.82072.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Mon, Jan 30, 2012 at 3:13 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Clean up a few different parts of omap_set_pwrdm_state():
>
> - Remove a superfluous call to pwrdm_state_switch(). =A0Not needed
> =A0unless LOWPOWERSTATECHANGE is used, because the state switch code =
is
> =A0called by either clkdm_sleep() or clkdm_allow_idle().
>
Indeed

> - Add code to wait for the power state transition in the OMAP4+ low
> =A0power state change. =A0This is speculative, so I would particularl=
y
> =A0appreciate feedback on this part.
>
> - Remove a superfluous call to pwrdm_read_pwrst().
>
> - Update variable names to be more meaningful (hopefully) and precise=
=2E
>
> - Fix an error path bug that would not place the clockdomain back int=
o
> =A0hardware-supervised idle or sleep mode if the power state could no=
t
> =A0be programmed.
>
> The documentation for this function still needs major improvements;
> that's left for a later patch.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> ---

All the changes look fine to me from OMAP4
perspective. Would be good if Tero can try out this
patch and test CORE RET on OMAP4.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
