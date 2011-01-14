From: TAO HU <tghk48@motorola.com>
Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
Date: Fri, 14 Jan 2011 15:58:37 +0800
Message-ID: <AANLkTik4eDy+QcMqp-0KcNTS0FdQYTfka__e8wB8KcpA@mail.gmail.com>
References: <AANLkTinXqSA0botGAGzEtk8_xOVt0W05k9+0w4v1gqF0@mail.gmail.com>
	<AANLkTin7YJ9GKdpFH1C_fwFXJp6yyO09s5ZJRos1Er1T@mail.gmail.com>
	<AANLkTi=iMXB6LvkNkj5JU17PPC3Kt+hnbDd1s=Dj8voq@mail.gmail.com>
	<aed955b665a0511402480c258615c2d8@mail.gmail.com>
	<AANLkTimYCzNO0skDLForDWM5v_A6aPmfQ2qoZMBJUC4s@mail.gmail.com>
	<e56efff1efde6669f06463a9af017967@mail.gmail.com>
	<AANLkTimA3Ypk6HH=Gn+wU-1-_mqF184tx-uvAtJ4Pac5@mail.gmail.com>
	<c77cce3143f47a793057b2a9a90a277b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:52437 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab1ANIkd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 03:40:33 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p0E7w6gV004712
	for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 02:58:06 -0500 (EST)
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com [209.85.215.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p0E7w5WA004705
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 02:58:06 -0500 (EST)
Received: by eyf5 with SMTP id 5so1736880eyf.15
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 23:58:37 -0800 (PST)
In-Reply-To: <c77cce3143f47a793057b2a9a90a277b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Bryan Wu <bryan.wu@canonical.com>, TAO HU <taohu@motorola.com>, linux-omap <linux-omap@vger.kernel.org>

Hi, Santosh

I think it depends on whether IRQ is enabled.
It is a limitation for current L3 error logging mechanism.

On Fri, Jan 14, 2011 at 3:17 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: cooloney@gmail.com [mailto:cooloney@gmail.com] On Behalf Of
>> Bryan Wu
>> Sent: Friday, January 14, 2011 3:08 AM
>> To: Santosh Shilimkar
>> Cc: TAO HU; TAO HU; linux-omap
>> Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external abort
>>
>> On Wed, Nov 24, 2010 at 2:23 PM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
>> >> -----Original Message-----
>> >> From: TAO HU [mailto:tghk48@motorola.com]
>> >> Sent: Wednesday, November 24, 2010 11:40 AM
>> >> To: Santosh Shilimkar
>> >> Cc: TAO HU; Bryan Wu; linux-omap
>> >> Subject: Re: OMAP4 ES2.0 Unhandled fault: imprecise external
>> abort
>> >>
>> >> Hi, Santosh
>> >>
>> >> Could you point out the specific kernel option for "L3 error
>> debugging"?
>> >>
>> > System Type =A0--->
>> > =A0 =A0 =A0 =A0[*] Enable L3 error logging
>> >
>>
>> I've enabled that for my Panda kernel. How to get the error log? I
>> still got the same "Unhandled fault: imprecise external abort"
>> message. Maybe L3 does not have any error at all.
>>
> Strange. It should have =A0triggered an L3 eror interrupt.
>



--=20
Best Regards
Hu Tao
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
