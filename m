From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: hwmod and insertable modules
Date: Fri, 22 Oct 2010 09:59:49 -0700
Message-ID: <87tyke6u4a.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593023458C204@dbde02.ent.ti.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF8D@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023458C250@dbde02.ent.ti.com>
	<4CC15CC3.7060406@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023458C2BE@dbde02.ent.ti.com>
	<4CC166C6.7060403@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023461A7AC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48606 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab0JVQ7w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 12:59:52 -0400
Received: by pwj8 with SMTP id 8so16064pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 09:59:52 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593023461A7AC@dbde02.ent.ti.com>
	(Sanjeev Premi's message of "Fri, 22 Oct 2010 17:47:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

> I was trying other way - understand if there is an existing norm/
> convention that I can follow - rather than (re)invent it!

The existing norm is that omap_devices are never destroyed.  The same is
true for the way we handle platform_devices that are not omap_devices.
That being said, it doesn't answer the question of how we would destroy
them if we wanted to, and that does indeed deserve some discussion.

However, I think your confusion is more about the separation between
device code and driver code.

It is the responsibility of device init code (arch/arm/*omap*) to create
and register devices with the system.  This is where platform_devices
and omap_devices are handled currently.

The drivers then register themselves (as platform_drivers) with the
driver core, and the driver core hooks them together.

The goal we're working towards is that the drivers be generic, and
should not know anything about device-specific registration.

Kevin








