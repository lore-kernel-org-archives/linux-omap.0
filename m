From: Tony Lindgren <tony@atomide.com>
Subject: Re: How to add suport for new ARM board IGEP0020
Date: Fri, 9 Oct 2009 10:57:10 -0700
Message-ID: <20091009175710.GJ25892@atomide.com>
References: <70c9a9110910090756i17a116b1l2c62a67fc49cab1e@mail.gmail.com> <4ACF53B6.4040008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61789 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbZJIR54 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 13:57:56 -0400
Content-Disposition: inline
In-Reply-To: <4ACF53B6.4040008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Enric =?iso-8859-1?Q?Balletb=F2?= i Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Nishanth Menon <nm@ti.com> [091009 08:36]:
> Enric Balletb=F2 i Serra had written, on 10/09/2009 09:56 AM, the fol=
lowing:
>> Hi all,
>>
>>       I'm a newbie and I have some questions. What is the procedure =
to
>> publish our patches to add support for a new OMAP3 based board ? Can=
 I
>> send the patches to this list ?
> yes, rebased to latest linux-omap please..

Currently pretty much all the core omap code is in mainline Linux, exce=
pt
for the PM code.

So please base all the patches against latest mainline tag unless
there are some dependencies to code that's not merged into mainline
kernel yet.

If there are dependencies to other patches, please mention them in the
patch too! And if possible separate out the patches with dependencies
so we can merge them early to keep cross dependencies to minimum.

Regards,

Tony=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
