Return-Path: <SRS0=mtBc=EB=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E94AC2D0A3
	for <linux-omap@archiver.kernel.org>; Mon, 26 Oct 2020 12:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9D42242A
	for <linux-omap@archiver.kernel.org>; Mon, 26 Oct 2020 12:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="St/QH5Dz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3MMHazYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775424AbgJZMr5 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 26 Oct 2020 08:47:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39740 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775420AbgJZMr5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2020 08:47:57 -0400
Date:   Mon, 26 Oct 2020 13:47:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603716475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ledzMrALzrU/tZDU6tXmPvSq99Gfn9oi9npD1C9N7Fc=;
        b=St/QH5DzyWhWvhjmBWNHvcbECoE4GLaWZUK+/Co4vO3wtZ/47iDdWIm/ELt9g2EnwOIj2V
        qpp/7+eRu0mZR0xYlLzfkG41Pn3F5YtOR+vtuWo8tvTz/5XRAPBBMqYtpQPFjcE1FTLSMX
        KPnbHWnH5/aPRT9az/fIir1xZvme/oYdwdli2+62/fvCUhdh91P0W7VXgP2N8vc+5/1lu4
        TyGkDJAClo5nJYZxtlrbpb/qe9aiUKSNfIi0GpdJblUWgu2kl1vN4Iw5A03Ley5rp3unHF
        iR9JjlSdjAumCyxHG8ddwk66Q6ZjTlGkEA7z/TFpasbrAbb5PL9ZTLIglNe1QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603716475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ledzMrALzrU/tZDU6tXmPvSq99Gfn9oi9npD1C9N7Fc=;
        b=3MMHazYDyT4OGKc5DsTSvyKX8/E47CLzEwIKWCPFKIt+B1VDy97ihOE78f8GwHl5Q+I1IS
        0lFvGhj/pHwKbrDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-omap@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Duncan Sands <duncan.sands@free.fr>
Subject: Re: [patch V2 02/13] USB: serial: keyspan_pda: Replace
 in_interrupt() usage
Message-ID: <20201026124753.btmdh3iwbwnff5dg@linutronix.de>
References: <20201019100629.419020859@linutronix.de>
 <20201019101109.753597069@linutronix.de>
 <20201025165647.GR26280@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025165647.GR26280@localhost>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On 2020-10-25 17:56:47 [+0100], Johan Hovold wrote:
> There's a ton of issues with this driver, but this is arguably making
> things worse. A line discipline may call write() from just about any
> context so we cannot rely on tty being non-NULL here (e.g. PPP).

I wasn't aware of that. I've been looking at the callers each time a
`tty' was passed it looked like a preemptible context (due to mutex /
GFP_KERNEL) and so on.

> 
> Johan

Sebastian
