From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] AM/DM37x: DSS mux configuration for >Rev-B processor
 cards
Date: Mon, 24 Jan 2011 21:06:53 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD65F513@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	<1295879651-13570-1-git-send-email-hvaibhav@ti.com>
 <AANLkTikRn4dz_u0CGL5jrsoAoQrF03wp_DBs7XbYAWXa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47629 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035Ab1AXPhF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 10:37:05 -0500
In-Reply-To: <AANLkTikRn4dz_u0CGL5jrsoAoQrF03wp_DBs7XbYAWXa@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: satish kumar <gsatish10@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "tony@atomide.com" <tony@atomide.com>


> From: satish kumar [mailto:gsatish10@gmail.com]=20
> Sent: Monday, January 24, 2011 8:56 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tomi.valkeinen@nokia.com; tony@atomid=
e.com
> Subject: Re: [PATCH] AM/DM37x: DSS mux configuration for >Rev-B proce=
ssor > cards

> Hi This is satish

Satish,

Very first thing is, no html posting here.=20

> With omap4 processor in =A0samsung board =A0while booting,=A0I am get=
ting=20
> following error.

Unfortunately I have not started with OMAP4 yet, so atleast at this poi=
nt of time will not be able to help you on OMAP4 specific queries.

But yes, DSS point of you I should be able to.


> "omapdss MANAGER error: mainclk disabled while tryingmgr_apply,=20
> returning "

> can you please provide me the solution for the above error.

Which kernel version (OR TI release) are you using? I could not able to=
 find this error message in mainline code, so it could be custom implem=
entation.

> I am getting one patch with commit Id: =A0 =A0commit
> d57f72dd11b63eb514d9ea14f8bf79458eccdd37
> but it wont removes my error.

This won't help, since I could not able to trace it. Provide complete p=
atch so that we can help.

Thanks,
Vaibhav

> thanks in advance
> Satish.G
=A0



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
