From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: clock/hwmod data: remove MODULEMODE entries in mux +
 gate combos
Date: Fri, 11 Jan 2013 18:53:19 -0800
Message-ID: <20130112025319.4361.29079@quantum>
References: <alpine.DEB.2.00.1212172240101.29833@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:56228 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab3ALCxZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 21:53:25 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so1323537pad.22
        for <linux-omap@vger.kernel.org>; Fri, 11 Jan 2013 18:53:25 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212172240101.29833@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b-cousson@ti.com

Quoting Paul Walmsley (2012-12-17 14:41:13)
> Convert all DEFINE_OMAP_MUX_GATE() combinations that list MODULEMODE
> registers in their gate arguments to DEFINE_OMAP_MUX(), dropping the
> MODULEMODE data.  This is possible because the MODULEMODE bits contro=
l
> IP blocks, not clocks; and the hwmod code takes care of IP block
> control.  Rename these clocks to reflect the original multiplexer nam=
e
> as specified in the comments.  And convert the hwmod data to use the
> multiplexer clock name.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> ---
>=20
> Seems to boot with omap2plus_defconfig, anyway.
>=20

It looks good to me, and I am happy to see fewer clocks in favor of
using the hwmods.  However I did not test it.

Regards,
Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
