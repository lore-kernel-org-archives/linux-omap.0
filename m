From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2] staging: tidspbridge: request dmtimer clocks on init
Date: Fri, 9 Dec 2011 14:38:44 -0800
Message-ID: <20111209223844.GB25063@kroah.com>
References: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
 <CAMP44s16cSBw23Py7qUW4Oj60gXKuvmtx-c=urisxecMQEE6Dw@mail.gmail.com>
 <CAB-zwWiH020HfovGF8CA-v9t8Pjc3kLbsXezN6ToLdyC4muHqA@mail.gmail.com>
 <20111209000733.GA9504@kroah.com>
 <CAB-zwWg0FkNEHHVS=Hy-US9=xkueg_skUX7VCLS=QVN3ubTsTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51550 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751079Ab1LIWj6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 17:39:58 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0B95D21418
	for <linux-omap@vger.kernel.org>; Fri,  9 Dec 2011 17:39:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAB-zwWg0FkNEHHVS=Hy-US9=xkueg_skUX7VCLS=QVN3ubTsTw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

On Thu, Dec 08, 2011 at 07:44:28PM -0600, Ramirez Luna, Omar wrote:
> On Thu, Dec 8, 2011 at 6:07 PM, Greg KH <greg@kroah.com> wrote:
> >> > Definitely 3.2-fix material IMO :)
> >>
> >> I believe it was pushed to staging-next... I'm rooting so it can b=
e
> >> pushed to staging-linus :)
> >
> > As it wasn't originally stated that this was a problem that needed =
to be
> > fixed for 3.2, can it wait for 3.3-rc1? =A0Especially given that th=
ere is
> > still discussion about this?
>=20
> No discussion from me either.
>=20
> The original intention was to include this patch for 3.2 because of
> the recent changes in dm timer framework, I apologize if "This was
> first seen on 3.2-rc1." is too ambiguous. I hope this can make it for
> 3.2 though.

How about for 3.2.1?  I'll try to get this into 3.2, but I can't
guarantee anything so late in the release cycle, sorry.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
