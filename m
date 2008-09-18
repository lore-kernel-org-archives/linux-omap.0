From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] OMAP: USB EHCI: Support final revision of USB board
Date: Thu, 18 Sep 2008 21:00:38 +0100
Message-ID: <yw1x1vzhusux.fsf@thrashbarg.mansr.com>
References: <FCCFB4CDC6E5564B9182F639FC35608701982C85CE@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB02C3E314F6@dbde02.ent.ti.com> <20080823232238.GL4713@atomide.com> <200809181222.54393.david-b@pacbell.net> <5A47E75E594F054BAF48C5E4FC4B92AB02C4007ED9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:56992 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754236AbYIRUAu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Sep 2008 16:00:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KgPgE-00087e-EG
	for linux-omap@vger.kernel.org; Thu, 18 Sep 2008 20:00:46 +0000
Received: from thrashbarg.mansr.com ([78.86.181.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 18 Sep 2008 20:00:46 +0000
Received: from mans by thrashbarg.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 18 Sep 2008 20:00:46 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

"Gadiyar, Anand" <gadiyar@ti.com> writes:

>>=20
>> On Saturday 23 August 2008, Tony Lindgren wrote:
>> >
>> > > I'll get the ehci-omap code in better shape and submit separatel=
y to the
>> > > linux-usb list.
>>=20
>> Given that we've not yet seen patches splitting out the board-specif=
ic
>> bits into arch/arm/mach-omap2, I can't imagine those fixes being rea=
dy
>> for the 2.6.28 merge window.  (Hint for TI folk:  why not write the
>> code that way in the first place, avoiding all the delays inherent i=
n
>> writing code you *know* is unsuitable for merging to mainline?)
>
> Well, there are only a limited number of hours in a day. :)

In my experience, writing code properly to begin with takes less time
than writing it badly first, and cleaning it up later.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
