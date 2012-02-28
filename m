From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 01/14] ARM: OMAP3+: SmartReflex: Layer Cleanup [V4]
Date: Tue, 28 Feb 2012 14:37:04 -0800
Message-ID: <87ipiqk2jz.fsf@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
	<1328723039-15952-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:58201 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756205Ab2B1WhJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 17:37:09 -0500
Received: by mail-pw0-f53.google.com with SMTP id jt11so1386458pbb.40
        for <linux-omap@vger.kernel.org>; Tue, 28 Feb 2012 14:37:08 -0800 (PST)
In-Reply-To: <1328723039-15952-2-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Wed, 8 Feb 2012 18:43:46 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Shweta Gulati <shweta.gulati@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> From: Shweta Gulati <shweta.gulati@ti.com>
>
> To set sr ntarget values for all volt_domain,
> volt_table is retrieved by doing a look_up of 'vdd_name'
> field from omap_hwmod but voltage domain pointer does not
> belong to omap_hwmod and is not used anywhere else.
> As a part of voltage layer and SR Layer clean up volt
> pointer is removed from omap_hwmod and added in dev
> attributes of SR.
>
> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>
> [nm@ti.com: minor modifications in sequence and GPU support]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Acked by: Nishanth Menon <nm@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Patch contents look fine, but his one needs a better subject.

Kevin
