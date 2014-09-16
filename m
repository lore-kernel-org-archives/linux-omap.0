From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v4 10/11] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Tue, 16 Sep 2014 11:14:19 -0500
Message-ID: <541861DB.5000706@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com> <1405047349-15101-11-git-send-email-d-gerlach@ti.com> <7h7g1dlp8b.fsf@linaro.org> <CAK=WgbYwGcSCxHfa880up1qKTroS=mi8UAf_Qh6Wz9n5x4D9rw@mail.gmail.com> <540F5C39.7040201@ti.com> <540F62E3.6080804@ti.com> <7hr3zk7b5z.fsf@deeprootsystems.com> <CAK=Wgbas+CqgYJ35Sao8eCkMPujpVNbWW-aikUQExScaqYfETw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51348 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbaIPQPc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2014 12:15:32 -0400
In-Reply-To: <CAK=Wgbas+CqgYJ35Sao8eCkMPujpVNbWW-aikUQExScaqYfETw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Kevin Hilman <khilman@kernel.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Benoit Cousson <bcousson@baylibre.com>

Hi Ohad,

On 09/16/2014 10:08 AM, Ohad Ben-Cohen wrote:
> On Wed, Sep 10, 2014 at 12:10 AM, Kevin Hilman <khilman@kernel.org> wrote:
>> What I think you need to do (and what I've recommended at least once in
>> earlier reviews) put all the (non-rproc) wkup_m3 IPC into into one
>> driver and create a well-described, well-documented API that the
>> platform PM code will use.
>>
>> IMO, the current "split" is very difficult to read/understand, which
>> means it will even more difficult to maintain.
> 
> I strongly agree.
> 
> A remoteproc driver should generally only register its
> hardware-specific implementation of the rproc_ops via the remoteproc
> framework. It is not expected to expose public API of its own - that's
> why we have the generic remoteproc layer for. It makes perfect sense
> not to use rpmsg for communications if it's not lightweight enough,
> but exposing a new set of IPC API should take place in a separate
> well-documented driver.
> 
> In addition, the suggested remoteproc driver seems to act both as a
> low-level hardware-specific driver that plugs into remoteproc (by
> registering rproc_ops via the remoteproc framework), and also as a
> high-level driver that utilizes the remoteproc public API (by calling
> rproc_boot). This alone calls for scrutinizing the design as this is
> not very intuitive.

The current remoteproc infrastructure automatically calls rproc_boot
only as part of the rpmsg/virtio stack (in remoteproc_virtio.c), but
since the WkupM3 does not use rpmsg, there is no automatic booting of
the WkupM3 processor. This is the reason why rproc_boot is called as
part of the WkupM3 driver probe sequence. What are your concerns here,
and if you think this is not the right place do invoke rproc_boot, where
do you expect it to be called? Also do note that, there is no way
at present to retrieve the struct rproc for a given remote processor, to
be able to invoke the rproc_boot from a different layer.

> At least for the remoteproc part: if you could provide a simple and
> straight-forward remoteproc driver that just implements the rproc_ops,
> this could be merged very quickly. The rest of the code most probably
> belongs in a different entity, just like Kevin suggested.
> 

Splitting this would still require some kind of notifier from remoteproc
for the other layers for them to know that the WkupM3 remote processor
has been loaded and booted successfully. This is also done as part of
the WkupM3 driver at the moment.

regards
Suman

