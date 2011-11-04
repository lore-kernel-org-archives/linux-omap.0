From: Tony Lindgren <tony@atomide.com>
Subject: Re: Re: [PATCH 1/2] OMAP2+: DMA: Workaround for invalid source
 position
Date: Fri, 4 Nov 2011 13:08:26 -0700
Message-ID: <20111104200826.GE31337@atomide.com>
References: <1320070817-9638-1-git-send-email-peter.ujfalusi@ti.com>
 <1320070817-9638-2-git-send-email-peter.ujfalusi@ti.com>
 <20111103212756.GZ31337@atomide.com>
 <2603119.amz7RjSE3J@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51534 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750779Ab1KDUIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 16:08:38 -0400
Content-Disposition: inline
In-Reply-To: <2603119.amz7RjSE3J@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org

* P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com> [111104 02:00]:
> On Thursday 03 November 2011 14:27:56 Tony Lindgren wrote:
> >=20
> > Should these tests be done only after the errata re-read for both
> > src and dst patches? Otherwise the errata will not be handled?
>=20
> Yes that might be a good idea.
> I was trying to locate the original errata description for DMA_ERRATA=
_3_3, but=20
> it does not exist, or at least I can not find it. This only been ment=
ioned in=20
> the kernel's comment.

Seems it got added with commit d3c9be2f.

> I'm not sure when this DMA_ERRATA_3_3 would have been in force. My gu=
ess would=20
> be that if someone wants to read the src/dst position right after the=
 channel=20
> is disabled, but what would we expect it to return when the channel h=
as been=20
> disabled?

No idea.. Or read it after stopping it?

> I mean what is the reasonable src/dst for a disabled channel? 0 is as=
 good as=20
> any other number, probably the programmed start of the DMA transfer w=
ould be=20
> my best bet.
> I think the errata description for DMA_ERRATA_3_3 is not correct, and=
 it is in=20
> fact to handle the case I'm also handling: Before the first DMA reque=
st the=20
> CDAC is 0 (since we configured it to be), the CSAC contains _somethin=
g_ (most=20
> of the time 0, but can be random number).
> In some situation re-reading the src/dst position will give enough ti=
me to=20
> receive the first DMA request, which will update CDAC/CSAC registers.

Yeah could be since the handling is just an immediate re-read of the re=
gister..
=20
> What do you think?

Probably the safest thing to do is move your check after the re-read te=
st
in case there's more to the ERRATA_3_3.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
