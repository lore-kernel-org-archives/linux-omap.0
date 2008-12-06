From: Tony Lindgren <tony@atomide.com>
Subject: Branch for fbdriver (Re: [PATCH 1/2] OMAP: Make dpll4_m4_ck
	programmable with clk_set_rate())
Date: Fri, 5 Dec 2008 18:12:57 -0800
Message-ID: <20081206021256.GY9714@atomide.com>
References: <yw1xhc76hmvi.fsf@thrashbarg.mansr.com> <1224545064-25551-1-git-send-email-mans@mansr.com> <alpine.DEB.2.00.0812051650380.21247@utopia.booyaka.com> <20081206001153.GO9714@atomide.com> <yw1xtz9iytcd.fsf@thrashbarg.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55565 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbYLFCNB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 21:13:01 -0500
Content-Disposition: inline
In-Reply-To: <yw1xtz9iytcd.fsf@thrashbarg.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com

* M=E5ns Rullg=E5rd <mans@mansr.com> [081205 17:40]:
> Tony Lindgren <tony@atomide.com> writes:
>=20
> > * Paul Walmsley <paul@pwsan.com> [081205 15:52]:
> >> On Tue, 21 Oct 2008, Mans Rullgard wrote:
> >>=20
> >> > Filling the set_rate and round_rate fields of dpll4_m4_ck makes
> >> > this clock programmable through clk_set_rate().  This is needed
> >> > to give omapfb control over the dss1_alwon_fck rate.
> >> >=20
> >> > Signed-off-by: Mans Rullgard <mans@mansr.com>
> >>=20
> >> Acked-by: Paul Walmsley <paul@pwsan.com>
> >>=20
> >> M=E5ns, sorry this took so long, these two patches slipped through=
 the=20
> >> cracks here.
> >
> > Pushing both to l-o tree today. Paul, I take it you will queue thes=
e
> > up for mainline via your clock series?
> >
> > M=E5ns, I heard you have some display patches? How about queuing up
> > those on the fbdev list?
>=20
> It looks like Tomi's driver is shaping up nicely, so it's probably no=
t
> worthwhile spending any significant time on the current driver.  If
> anyone is interested, everything I have is in my git tree.

OK, good to know. Tomi, do you have a git branch against the
mainline kernel for your driver?

We could start mirroring it on linux-omap and then start automerging
it on daily basis to linux-omap for testing (Assuming it does not cause
problems with other stuff :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
