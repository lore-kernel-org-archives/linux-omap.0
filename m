From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V4] OMAP3+: SR Layer Cleanup
Date: Thu, 19 May 2011 10:59:25 +0200
Message-ID: <87wrhn9ic2.fsf@ti.com>
References: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:34920 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932424Ab1ESI7b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 04:59:31 -0400
Received: by mail-wy0-f170.google.com with SMTP id 34so1998806wyb.29
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 01:59:29 -0700 (PDT)
In-Reply-To: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com> (Shweta
	Gulati's message of "Fri, 13 May 2011 11:57:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Shweta Gulati <shweta.gulati@ti.com> writes:

> To set sr ntarget values  for all volt_domain,
> volt_table is retrieved by doing a look_up of 'vdd_name'
> field from omap_hwmod but voltage domain pointer does not
> belong to omap_hwmod and is not used anywhere else.
> As a part of voltage layer and SR Layer clean up volt
> pointer is removed from omap_hwmod and added in dev
> attributes of SR.
>
> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Acked by: Nishanth Menon <nm@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

As this isn't a consolidation/cleanup, I'm not going to push for 2.6.40,
but with an ack from Benoit, I'll queue for 2.6.40+.

Also it has some minor conflicts with some other SR cleanups I have
queued for 2.6.40+.  Please rebase on to my for_2.6.40/pm-misc branch.

Thanks,

Kevin
