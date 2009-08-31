From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 00/18] OMAP: DSS2: Intro
Date: Mon, 31 Aug 2009 15:54:20 +0200
Message-ID: <33395592-242E-475A-9642-2AFD5B478B81@student.utwente.nl>
References: <1251462337-12531-1-git-send-email-tomi.valkeinen@nokia.com> <4A9B96A7.5040005@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:48301 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbZHaNzk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 09:55:40 -0400
In-Reply-To: <4A9B96A7.5040005@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>


Op 31 aug 2009, om 11:23 heeft Artem Bityutskiy het volgende geschreven=
:

> On 08/28/2009 03:25 PM, Tomi Valkeinen wrote:
>> This patch set implement new display subsystem driver (DSS2) and =20
>> omapfb driver
>> for OMAP2/3. The patches have been reviewed on linux-omap and linux-=
=20
>> fbdev-devel
>> mailing lists. The patches can also be found from
>> http://gitorious.org/linux-omap-dss2/linux
>>
>> The patches include DSS documentation patch that includes more =20
>> instructions for
>> module parameters, sysfs files etc.
>>
>> The patches enable DSS2 for OMAP3430 SDP board. DSS2 is used in =20
>> various boards,
>> for example Nokia N900, Beagle Board and Overo.
>>
>> I don't currently have any OMAP2 board to test DSS2, but it has =20
>> worked on OMAP2
>> and the possible fixes needed should be minimal.
>>
>> OMAP1 is not supported, and so the old DSS needs to be used on =20
>> OMAP1 boards.
>>
>> DSS2 is partly based on the old omapfb driver by Imre Deak, and =20
>> Imre has also
>> contributed to DSS2 quite a bit. Ville Syrj=E4l=E4 has been =20
>> contributing to scaling
>> and tv-out work. Also some contributions have been made by Hardik =20
>> Shah, Vaibhav
>> Hiremath, and perhaps some others that I have forgotten =3D).
>
> Tony, Andrew,
>
> how could we merge this code (unless there are requests to change =20
> something, which
> does not seem to be the case.). It seems like there is no maintainer =
=20
> who could
> merge this. Or there is? Would Tomi need to send a direct pull =20
> request to Linus,
> or this could got via Tony?
>
> We are using DSS2 in Nokia for about a year already. N900 is using =20
> this
> code, for example. Other (non-Nokia) projects are using DSS2 as well.
> The code was public for long time and was sent several times for =20
> review.

With my beagleboard hat on: I agree with Artem, let's get this merged. =
=20
I hope other TI folk can put their TI hat on and say something nice =20
about dss2 as well :)

regards,

Koen

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
