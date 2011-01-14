From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: OMAP4 ES2.0 Unhandled fault: imprecise external abort
Date: Fri, 14 Jan 2011 13:36:43 +0530
Message-ID: <7c601ad1e2d45e00240055319cfec2f9@mail.gmail.com>
References: <AANLkTinXqSA0botGAGzEtk8_xOVt0W05k9+0w4v1gqF0@mail.gmail.com><AANLkTin7YJ9GKdpFH1C_fwFXJp6yyO09s5ZJRos1Er1T@mail.gmail.com><AANLkTi=iMXB6LvkNkj5JU17PPC3Kt+hnbDd1s=Dj8voq@mail.gmail.com><aed955b665a0511402480c258615c2d8@mail.gmail.com><AANLkTimYCzNO0skDLForDWM5v_A6aPmfQ2qoZMBJUC4s@mail.gmail.com><e56efff1efde6669f06463a9af017967@mail.gmail.com><AANLkTimA3Ypk6HH=Gn+wU-1-_mqF184tx-uvAtJ4Pac5@mail.gmail.com><c77cce3143f47a793057b2a9a90a277b@mail.gmail.com>
 <AANLkTik4eDy+QcMqp-0KcNTS0FdQYTfka__e8wB8KcpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:47533 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757243Ab1ANIGq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Jan 2011 03:06:46 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so2561220fxm.16
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 00:06:45 -0800 (PST)
In-Reply-To: <AANLkTik4eDy+QcMqp-0KcNTS0FdQYTfka__e8wB8KcpA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: TAO HU <tghk48@motorola.com>
Cc: Bryan Wu <bryan.wu@canonical.com>, TAO HU <taohu@motorola.com>, linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: TAO HU [mailto:tghk48@motorola.com]
> Sent: Friday, January 14, 2011 1:29 PM
> To: Santosh Shilimkar
> Cc: Bryan Wu; TAO HU; linux-omap
> Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
>
> Hi, Santosh
>
> I think it depends on whether IRQ is enabled.
> It is a limitation for current L3 error logging mechanism.
>
L3 IRQ is always enabled except low power states. I guess
we patched this part as well so that error is not lost and
its logged.

It's not a limitation L3 interrupt but behavior of CPU.
Because scenario's where the I bit is cleared at CPU level
(Interrupt disable), it's immune to interrupts.

Note the interrupt is not lost but just got delayed a bit
