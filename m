From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
Date: Sat, 15 Jan 2011 01:54:27 +0800
Message-ID: <AANLkTinwK9GtVUiUFeE=75cjyOLb5dzVhdGQHzPKCzQw@mail.gmail.com>
References: <AANLkTinXqSA0botGAGzEtk8_xOVt0W05k9+0w4v1gqF0@mail.gmail.com>
 <AANLkTin7YJ9GKdpFH1C_fwFXJp6yyO09s5ZJRos1Er1T@mail.gmail.com>
 <AANLkTi=iMXB6LvkNkj5JU17PPC3Kt+hnbDd1s=Dj8voq@mail.gmail.com>
 <aed955b665a0511402480c258615c2d8@mail.gmail.com> <AANLkTimYCzNO0skDLForDWM5v_A6aPmfQ2qoZMBJUC4s@mail.gmail.com>
 <e56efff1efde6669f06463a9af017967@mail.gmail.com> <AANLkTimA3Ypk6HH=Gn+wU-1-_mqF184tx-uvAtJ4Pac5@mail.gmail.com>
 <c77cce3143f47a793057b2a9a90a277b@mail.gmail.com> <AANLkTik4eDy+QcMqp-0KcNTS0FdQYTfka__e8wB8KcpA@mail.gmail.com>
 <7c601ad1e2d45e00240055319cfec2f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61329 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab1ANRys convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 12:54:48 -0500
Received: by qyk12 with SMTP id 12so3624049qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 09:54:48 -0800 (PST)
In-Reply-To: <7c601ad1e2d45e00240055319cfec2f9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: TAO HU <tghk48@motorola.com>, TAO HU <taohu@motorola.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Jan 14, 2011 at 4:06 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: TAO HU [mailto:tghk48@motorola.com]
>> Sent: Friday, January 14, 2011 1:29 PM
>> To: Santosh Shilimkar
>> Cc: Bryan Wu; TAO HU; linux-omap
>> Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
>>
>> Hi, Santosh
>>
>> I think it depends on whether IRQ is enabled.
>> It is a limitation for current L3 error logging mechanism.
>>
> L3 IRQ is always enabled except low power states. I guess
> we patched this part as well so that error is not lost and
> its logged.
>
> It's not a limitation L3 interrupt but behavior of CPU.
> Because scenario's where the I bit is cleared at CPU level
> (Interrupt disable), it's immune to interrupts.
>
> Note the interrupt is not lost but just got delayed a bit
>

Is there any testcase I can try to make sure the L3 error interrupt is =
working?

Thanks,
--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
