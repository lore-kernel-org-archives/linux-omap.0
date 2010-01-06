From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v7 2/5] OMAP: McBSP: Modify macros/functions API for easy cache access
Date: Wed, 6 Jan 2010 13:03:02 +0100
Message-ID: <201001061303.03620.jkrzyszt@tis.icnet.pl>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BFFDF8D5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:47022 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754819Ab0AFMDV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 07:03:21 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BFFDF8D5@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charu Latha" <charu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>

Tuesday 22 December 2009 09:58:37 Varadarajan, Charu Latha napisa=C5=82=
(a):
> >-----Original Message-----
> >From: Tony Lindgren [mailto:tony@atomide.com]
> >Sent: Tuesday, December 15, 2009 1:06 AM
> >To: Jarkko Nikula
> >Cc: Janusz Krzysztofik; Varadarajan, Charu Latha; Peter
> >Ujfalusi; linux-omap@vger.kernel.org
> >Subject: Re: [PATCH v7 2/5] OMAP: McBSP: Modify
> >macros/functions API for easy cache access
> >
> >* Jarkko Nikula <jhnikula@gmail.com> [091214 03:12]:
> >> On Mon, 14 Dec 2009 11:11:27 +0100
> >> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> >> > If these functions are obsolete and going to be removed, I
> >
> >don't think it
> >
> >> > could be of any importance whether they are modified
> >
> >before removal or not.
> >
> >> > Otherwise, a solution seems simple to me: you submit a
> >
> >patch that addresses
> >
> >> > all concearns, yours, Tony's (BTW, have you already
> >
> >reviewed the drivers as
> >
> >> > Tony suggested?), maybe others. Then, after your patch is
> >
> >accepted for
> >
> >> > inclusion and it appears in conflict with this series
> >
> >still not applied for
> >
> >> > any reason (possibly waiting for your changes if that
> >
> >decided), Jarkko, or
> >
> >> > Tony, or anyone else pointed out by Tony, decides which
> >
> >one goes first and
> >
> >> > which is going to be refreshed on top of the other. Does
> >
> >it sound like a good
> >
> >> > plan for you?
> >>
> >> I would favor the Janusz's set going in first since it will solve =
and
> >> help the in-tree problems without making out-of-tree use any
> >
> >worse than
> >
> >> currently.
> >>
> >> - Fixes register access in polled I/O functions (out-of-tree use)
> >> - Fixes McBSP register corruption noted on Amstrad Delta
> >> - McBSP register caching could help the PM development
> >>
> >> Fixing any other issues in polled I/O API belongs to another conte=
xt
> >> than this patch set and IMO is easier to handle after this
> >
> >set since the
> >
> >> patch 1/5 already fixes the register access width.
> >
> >Sounds good to me.
>
> Tony,
> As pointed by you, the McBSP driver is having broken APIs. Please sha=
re
> your plans wrt McBSP driver.
> 1) If there are plans to review and clean up the code,
> we will focus on the same.
> 2) Else if the above is planned sometime in the future,
> can you consider the patch for fixing McBSP poll mode
> (http://patchwork.kernel.org/patch/54896/) as it is important to have=
 a
> working code in place? If okay, I shall post a new version
> of the mentioned patch.
>
> >Tony

Charu,

Now I can see the source of your frustration: my v3 patch 1/4=20
(http://patchwork.kernel.org/patch/63839/), followed by v7 1/5, is almo=
st=20
identical to v1 of yours mentioned above=20
(http://patchwork.kernel.org/patch/53631/), that is earlier. I'm sorry,=
 but I=20
was not aware of that, neither when submitting my patch nor later refer=
ring=20
your comments that you happened to place against my patch v7 2/5, not 1=
/5.

The difference is that my patch only modifies =20
omap_mcbsp_pollread()/_pollwrite() function bodies by replacing=20
readw()/writew() with OMAP_MCBSP_READ()/_WRITE(), while yours changes t=
he=20
functions API as well. Even if my rationale was different from fixing 3=
2-bit=20
register access inside these functions, it just happend to fix it since=
=20
OMAP_MCBSP_READ()/_WRITE() handle 32-bit register access correctly unli=
ke=20
readw()/writew() that are 16-bit.

As we can see from what Jarkko says, our changes inside function bodies=
 are=20
perfectly acceptable, while your API changes are not.

That said, if you could remove API changes from your v1 patch, keeping =
those=20
function to macro replacements only, you should be able to get it accep=
ted by=20
Jarkko, Peter and Tony. I think you could even get it accepted as a fix=
 for=20
the current rc cycle if you submit it promptly.

If you get this way, I'll drop my patch 1/5 in favour of yours.=20
Please let me know your decision as soon as possible since now, as my f=
ix on=20
omap_mcbsp_request() has been applied (Tony, thanks), I'm going to resu=
bmit a=20
refreshed version of my register caching set in a few days.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
