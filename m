From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
Date: Fri, 14 Jan 2011 05:38:28 +0800
Message-ID: <AANLkTimA3Ypk6HH=Gn+wU-1-_mqF184tx-uvAtJ4Pac5@mail.gmail.com>
References: <AANLkTinXqSA0botGAGzEtk8_xOVt0W05k9+0w4v1gqF0@mail.gmail.com>
 <AANLkTin7YJ9GKdpFH1C_fwFXJp6yyO09s5ZJRos1Er1T@mail.gmail.com>
 <AANLkTi=iMXB6LvkNkj5JU17PPC3Kt+hnbDd1s=Dj8voq@mail.gmail.com>
 <aed955b665a0511402480c258615c2d8@mail.gmail.com> <AANLkTimYCzNO0skDLForDWM5v_A6aPmfQ2qoZMBJUC4s@mail.gmail.com>
 <e56efff1efde6669f06463a9af017967@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43084 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699Ab1AMVit convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 16:38:49 -0500
Received: by qwa26 with SMTP id 26so2266137qwa.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 13:38:49 -0800 (PST)
In-Reply-To: <e56efff1efde6669f06463a9af017967@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: TAO HU <tghk48@motorola.com>, TAO HU <taohu@motorola.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Nov 24, 2010 at 2:23 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: TAO HU [mailto:tghk48@motorola.com]
>> Sent: Wednesday, November 24, 2010 11:40 AM
>> To: Santosh Shilimkar
>> Cc: TAO HU; Bryan Wu; linux-omap
>> Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
>>
>> Hi, Santosh
>>
>> Could you point out the specific kernel option for "L3 error debuggi=
ng"?
>>
> System Type =A0--->
> =A0 =A0 =A0 =A0[*] Enable L3 error logging
>

I've enabled that for my Panda kernel. How to get the error log? I
still got the same "Unhandled fault: imprecise external abort"
message. Maybe L3 does not have any error at all.

Thanks a lot,
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
