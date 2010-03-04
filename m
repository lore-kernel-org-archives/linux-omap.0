From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: OMAPFB: cannot parse default modes
Date: Thu, 4 Mar 2010 17:08:58 +0100
Message-ID: <70c9a9111003040808g59f787a8t89437888459c12bd@mail.gmail.com>
References: <70c9a9111003040725j63355a27j38e3f7b07e7ba43a@mail.gmail.com>
	 <1267718281.25148.41.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61798 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab0CDQI7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 11:08:59 -0500
Received: by pwj8 with SMTP id 8so1726567pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Mar 2010 08:08:59 -0800 (PST)
In-Reply-To: <1267718281.25148.41.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

=46or me also works, thanks

Best regards,

Enric

2010/3/4 Tomi Valkeinen <tomi.valkeinen@nokia.com>:
> On Thu, 2010-03-04 at 16:25 +0100, ext Enric Balletb=C3=B2 i Serra wr=
ote:
>> Hello,
>>
>> Testing the Linux Omap master branch on IGEP v2 board I get this fea=
ture
>>
>> [ =C2=A0 17.565155] omapfb omapfb: cannot parse default modes
>>
>> My kernel command line is something like =C2=A0'..
>> omapfb.mode=3Ddvi:1280x720MR-24@60' which works without problems wit=
h
>> latest 2.6.33-rc8. Any idea about this ? There is something differen=
t
>> between 2.6.33 and 2.633-rc8 ? I'm missing something ?
>
> There's no difference between the tagged 2.6.33-rc8 and 2.6.33. But i=
n
> the current merge window there went a big bunch of DSS patches in, an=
d
> you are right, setting modes doesn't work in git HEAD.
>
> There's some code missing related to mode setting, and it needs some
> thinking how to make it properly. But here's a quick hack patch I mad=
e,
> that makes mode setting work at least for me on 3430SDP.
>
> =C2=A0Tomi
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
