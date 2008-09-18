From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP: USB EHCI: Support final revision of USB board
Date: Fri, 19 Sep 2008 01:36:25 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EDA@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608701982C85CE@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB02C3E314F6@dbde02.ent.ti.com>
 <20080823232238.GL4713@atomide.com> <200809181222.54393.david-b@pacbell.net>
 <5A47E75E594F054BAF48C5E4FC4B92AB02C4007ED9@dbde02.ent.ti.com>,<yw1x1vzhusux.fsf@thrashbarg.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40867 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755767AbYIRULe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 16:11:34 -0400
In-Reply-To: <yw1x1vzhusux.fsf@thrashbarg.mansr.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>> "Gadiyar, Anand" <gadiyar@ti.com> writes:
>>>
>>> On Saturday 23 August 2008, Tony Lindgren wrote:
>>> >
>>> > > I'll get the ehci-omap code in better shape and submit separate=
ly to the
>>> > > linux-usb list.
>>>
>>> Given that we've not yet seen patches splitting out the board-speci=
fic
>>> bits into arch/arm/mach-omap2, I can't imagine those fixes being re=
ady
>>> for the 2.6.28 merge window.  (Hint for TI folk:  why not write the
>>> code that way in the first place, avoiding all the delays inherent =
in
>>> writing code you *know* is unsuitable for merging to mainline?)
>>
>> Well, there are only a limited number of hours in a day. :)
>=20
> In my experience, writing code properly to begin with takes less time
> than writing it badly first, and cleaning it up later.
>=20
> --
> M=E5ns Rullg=E5rd
> mans@mansr.com

I totally agree. But I didn't write that in the first place - it's just=
 that I
happen to use this controller more often than others do :)--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
