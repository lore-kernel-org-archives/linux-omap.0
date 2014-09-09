From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v4 10/11] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Tue, 9 Sep 2014 13:31:36 +0300
Message-ID: <CAK=WgbYwGcSCxHfa880up1qKTroS=mi8UAf_Qh6Wz9n5x4D9rw@mail.gmail.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
 <1405047349-15101-11-git-send-email-d-gerlach@ti.com> <7h7g1dlp8b.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:43608 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527AbaIIKb5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2014 06:31:57 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so18889236iec.26
        for <linux-omap@vger.kernel.org>; Tue, 09 Sep 2014 03:31:57 -0700 (PDT)
In-Reply-To: <7h7g1dlp8b.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>

On Tue, Sep 9, 2014 at 1:30 AM, Kevin Hilman <khilman@linaro.org> wrote:
> To me, it's not terribly clear how you made the split between this PM
> core code an the remoteproc code.  In the changelog for the remoteproc
> patch, it states it's to "load the firmware for and boot the wkup_m3".
> But, while parts of the IPC are here in pm33xx.c, parts of the IPC are
> also inside the remoteproc driver, so I'm quite curious if that's OK
> with the remoteproc maintainers.  Either way, please make it clearer how
> and why you made the split, and please isolate the wkup_m3 IPC/protocol
> from this code.  Think of people wanting to rework/extend the wkup_m3
> firmware.  They shouldn't be messing around in here, but rather inside a
> driver specificaly for the wkup_m3.

I haven't looked at the code very thoroughly yet, but generally a
remoteproc driver should only implement the three start/stop/kick
rproc_ops, and then register them via the remoteproc framework.
Exposing additional API directly from that driver isn't something we
immediately want to accept.

If relevant, we would generally prefer to extend remoteproc instead,
so other platform-specific drivers could utilize that functionality as
well. Or rpmsg - if we're missing some IPC functionality.

Thanks,
Ohad.
