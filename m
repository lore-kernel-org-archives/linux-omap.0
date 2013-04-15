From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH v2 0/6] ARM: OMAP3+: Introduce ABB driver
Date: Mon, 15 Apr 2013 14:53:44 -0700
Message-ID: <87sj2rbguv.fsf@linaro.org>
References: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:42486 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742Ab3DOVxs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 17:53:48 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so2756686pbc.30
        for <linux-omap@vger.kernel.org>; Mon, 15 Apr 2013 14:53:48 -0700 (PDT)
In-Reply-To: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
	(Andrii Tseglytskyi's message of "Mon, 15 Apr 2013 16:28:05 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Cc: linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>

Andrii Tseglytskyi <andrii.tseglytskyi@ti.com> writes:

> From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>
>
> Following patch series introduces the Adaptive Body-Bias
> LDO driver, which handles LDOs voltage during OPP change routine.
> Current implementation is based on patch series from
> Mike Turquette:
>
> http://marc.info/?l=linux-omap&m=134931341818379&w=2
>
> ABB transition is a part of OPP changing sequence.
> ABB can operate in the following modes:
> - Bypass mode: Activated when ABB is not required
> - FBB mode: Fast Body Bias mode, used on fast OPPs

Fast?  I thought the 'F' was for Forward?

> - RBB mode: Reverse Body Bias mode, used on slow OPPs
>
> In current implementation ABB is converted to regulator.
> Standalone OPP table is used to store ABB mode, it is defined
> in device tree for each ABB regulator. It has the following format:
>
> operating-points = <
> 	       /* uV   ABB (0 - Bypass, 1 - FBB, 2 - RBB) */
> 	       880000		0
> 	       1060000		1
> 	       1250000		1
> 	       1260000		1
>>;
>
> ABB regulator is linked to regulator chain

In addition to Mike's comments (which I completely agree with), it would
be very helfpul to see how this is actually used.  e.g, how the
regulators are chained together, how the proper ordering is managed,
etc. etc.

IOW, This series gives a bunch of low-level details without
demonstrating the actual use case and showing the regulator API usage
that would make this work.

Kevin



