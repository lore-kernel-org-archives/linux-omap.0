From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv5 06/15] hwspinlock/omap: enable module before reading
 SYSSTATUS register
Date: Tue, 1 Jul 2014 15:51:27 +0300
Message-ID: <CAK=WgbaKPgLLw-4wCSToE86QrREDB0sK95TLx2y17d71eBPFbg@mail.gmail.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com> <1398904476-26200-7-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:59146 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbaGAMvt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 08:51:49 -0400
Received: by mail-la0-f51.google.com with SMTP id mc6so5759904lab.24
        for <linux-omap@vger.kernel.org>; Tue, 01 Jul 2014 05:51:48 -0700 (PDT)
In-Reply-To: <1398904476-26200-7-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Suman,

On Thu, May 1, 2014 at 3:34 AM, Suman Anna <s-anna@ti.com> wrote:
> The number of hwspinlocks are determined based on the value read
> from the IP block's SYSSTATUS register. However, the module may
> not be enabled and clocked, and the read may result in a bus error.
>
> This particular issue is seen rather easily on AM33XX, since the
> module wakeup is software controlled, and it is disabled out of
> reset. Make sure the module is enabled and clocked before reading
> the SYSSTATUS register.

This seems like a valid fix that is independent of this patch series.

Feel free to submit it separately if you want, so we can get it merged.

Thanks,
Ohad.
