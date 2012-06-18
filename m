From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: HDMI: Discard phy_tx_enabled member
Date: Mon, 18 Jun 2012 15:42:45 +0530
Message-ID: <CAJe_ZhdhBre8DUVNpawF6X5P+QSiMarkt3WUvbJ=RPcmpX3TPA@mail.gmail.com>
References: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
	<1340007094.1859.3.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52623 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751972Ab2FRKMr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 06:12:47 -0400
Received: by lahd3 with SMTP id d3so3378429lah.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 03:12:46 -0700 (PDT)
In-Reply-To: <1340007094.1859.3.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On 18 June 2012 13:41, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>
>> Explicitly maintaining HDMI phy power state using a flag is prone to
>> race and un-necessary when we have a zero-cost alternative of checking
>> the state before trying to set it.
>
> Why would reading the value from the register be any less racy than
> keeping it in memory?
>
Racy in the sense that h/w doesn't always hop states according to what
a "state" variable would expect it to.
Also in this case, phy_tx_enabled modification is unprotected in
ti_hdmi_4xxx_phy_disable().

BTW, coming to think about it, I am not sure what we need the
spin_lock_irqsave() protection for in hdmi_check_hpd_state() ?  It
can't control HPD gpio state change and hdmi_set_phy_pwr() seems too
expensive and is already unprotected elsewhere.

> And reading from memory is probably much faster
> than reading from an HDMI register, so I'm not sure what you mean with
> zero-cost.
>
Zero-cost in terms of space and bother :)

> But I guess it is simpler, so in that sense the patch is ok. But please
> revise the description.
>
OK, will do.

Thanks.
