From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v4 10/11] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Wed, 17 Sep 2014 16:37:53 +0300
Message-ID: <CAK=WgbYqv=Fu3fm7SK9_u_gu2Ac13Rgi+3Kyo6Bhu-+1WGFwow@mail.gmail.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
 <1405047349-15101-11-git-send-email-d-gerlach@ti.com> <7h7g1dlp8b.fsf@linaro.org>
 <CAK=WgbYwGcSCxHfa880up1qKTroS=mi8UAf_Qh6Wz9n5x4D9rw@mail.gmail.com>
 <540F5C39.7040201@ti.com> <540F62E3.6080804@ti.com> <7hr3zk7b5z.fsf@deeprootsystems.com>
 <CAK=Wgbas+CqgYJ35Sao8eCkMPujpVNbWW-aikUQExScaqYfETw@mail.gmail.com> <541861DB.5000706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:48067 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854AbaIQNiO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2014 09:38:14 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn15so143255igb.3
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2014 06:38:13 -0700 (PDT)
In-Reply-To: <541861DB.5000706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Benoit Cousson <bcousson@baylibre.com>

Hi Suman,

On Tue, Sep 16, 2014 at 7:14 PM, Suman Anna <s-anna@ti.com> wrote:
> The current remoteproc infrastructure automatically calls rproc_boot
> only as part of the rpmsg/virtio stack (in remoteproc_virtio.c), but
> since the WkupM3 does not use rpmsg, there is no automatic booting of
> the WkupM3 processor.  This is the reason why rproc_boot is called as
> part of the WkupM3 driver probe sequence. What are your concerns here,
> and if you think this is not the right place do invoke rproc_boot, where
> do you expect it to be called?

The remoteproc layer is meant to hide hardware-specific details, and
allow high-level hardware-agnostic code to boot a remote processor, in
order to achieve some task, without even caring what kind of hardware
it is booting.

So generally we have some consumer driver asking remoteproc to boot a
remote processor, and in turn, remoteproc asking a hardware-specific
vendor driver to take care of the hardware details like actually
taking the remote processor out of reset.

The consumer driver is some code that deals with some hardware
agnostic task. Today the only consumer we have is rpmsg, so it's
perfectly reasonable if remoteproc needs to be adapted a bit to
accommodate other consumers as they show up.

Can you think of any component in your code that is not necessarily
hardware specific, and that one day might be useful for other vendors?
Can you describe the task you're trying to achieve, the entities
involved and the flow between them?

> Also do note that, there is no way
> at present to retrieve the struct rproc for a given remote processor, to
> be able to invoke the rproc_boot from a different layer.

It's perfectly ok to make struct rproc public if we have a consumer
that requires it.

> Splitting this would still require some kind of notifier from remoteproc
> for the other layers for them to know that the WkupM3 remote processor
> has been loaded and booted successfully. This is also done as part of
> the WkupM3 driver at the moment.

Are there entities, other than the one that calls rproc_boot, that
needs to know that the WkupM3 is up? if so, let's discuss who should
notify them - remoteproc or the actual invoker of rproc_boot. It
probably depends on who those entities are and what's their relation,
if any, to the WkupM3 driver.

Thanks,
Ohad.
