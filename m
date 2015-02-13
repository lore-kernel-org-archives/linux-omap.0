From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 2/2] remoteproc: add support to handle internal memories
Date: Fri, 13 Feb 2015 07:20:16 +0200
Message-ID: <CAK=WgbaK+TNJR1UHm7orcFk7kaGTWMQsW0XhX_t7qvWwe+YJEg@mail.gmail.com>
References: <1420838519-15669-1-git-send-email-s-anna@ti.com>
 <1420838519-15669-3-git-send-email-s-anna@ti.com> <CAK=WgbaFoUpV315Tg1q=PGc-FkCvKBz2BmO8Fkj_FHa5UuWviw@mail.gmail.com>
 <20150211205757.GI2531@atomide.com> <CAK=WgbbFxNfn5tUeJn-8NehFXAD+=7UW-WtBf3ZFm1xyomFAfA@mail.gmail.com>
 <54DD131F.8040704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:41386 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbbBMFUi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2015 00:20:38 -0500
Received: by labpv20 with SMTP id pv20so14095641lab.8
        for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2015 21:20:37 -0800 (PST)
In-Reply-To: <54DD131F.8040704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Robert Tivy <rtivy@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, Feb 12, 2015 at 10:54 PM, Suman Anna <s-anna@ti.com> wrote:
> My original motivation was that it would only need to be added on
> firmwares requiring support for loading into internal memories,
> otherwise, these are something left to be managed by the software
> running on the remote processor completely, and MPU will not even touch
> them.

Sure. But even if you guys will use this interface correctly, this
patch essentially exposes ioremap to user space, which is something we
generally want to avoid.

> So, let me know if this is a NAK. If so, we have two options - one to go
> the sram node model where each of them have to be defined separately,
> and have a specific property in the rproc nodes to be able to get the
> gen_pool handles. The other one is simply to define these as <reg> and
> use devm_ioremap_resource() (so use DT for defining the regions instead
> of a resource table entry).

Any approach where these regions are defined explicitly really sounds
better. If you could look into these two alternatives that would be
great.

Thanks,
Ohad.
