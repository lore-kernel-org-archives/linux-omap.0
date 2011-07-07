From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] AM3505/3517 ZCN package support
Date: Thu, 7 Jul 2011 17:19:57 +0300
Message-ID: <20110707141957.GG15815@atomide.com>
References: <4E1492C0.8060900@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48415 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752807Ab1GGOUC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 10:20:02 -0400
Content-Disposition: inline
In-Reply-To: <4E1492C0.8060900@8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?UmFwaGHDq2wgQXNzw6luYXQ=?= <raph@8d.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Premi, Sanjeev" <premi@ti.com>

* Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com> [110706 19:47]:
> Fixes according to Sanjeev's comments in previous thread.
>=20
> ---
> This patch adds support for the AM35xx ZCN package specific muxmodes.

Thanks for doing this. Still it's quite a few lines of data.. So
I suggest that we just plan on doing the mux data for v3.2 merge
window in device tree format. I'm planning on working on that after
v3.1 merge window and should be able to generate it for am3505
using your patch.

Otherwise we'll be patching something that will be disappearing
quite soon anyways.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
