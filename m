From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/1] ASoC patch on top of linux-omap 2.6.29-rc1
	(TWL4030 related)
Date: Fri, 16 Jan 2009 09:27:12 +0200
Message-ID: <20090116072712.GL4128@atomide.com>
References: <1232086493-2811-1-git-send-email-peter.ujfalusi@nokia.com> <200901160821.07772.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64278 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756789AbZAPH1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 02:27:12 -0500
Content-Disposition: inline
In-Reply-To: <200901160821.07772.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@nokia.com> [090116 08:21]:
> Hmm, should I take the patch from Takashi's tree (with his sign-off) =
and
> resend it?
> This patch is the one that I have sent to alsa-devel...

In general that would be best, as then I know it's been acked and on
it's way to the mainline kernel via alsa already. Meaning it's safe
for me to apply to linux-omap without increasing the diff to mainline
kernel.

Tony

>=20
> --=20
> P=E9ter
>=20
> On Friday 16 January 2009 08:14:52 Peter Ujfalusi wrote:
> > Hello,
> >
> > This patch has been sent after 29-rc1 to ALSA devel, it is already =
in
> > Takashi's tree and will go upstream as soon as possible.
> >
> > Somehow I have left out this from the soc_value_enum type merge to =
the
> > soc_enum series, which kind of renders the twl4030 codec driver to =
not to
> > update the value_enum types. In other words: without this patch the=
 twl4030
> > codec is not working.
> >
> > The patch applies cleanly to the head of linux-omap tree.
> >
> > ---
> > Peter Ujfalusi (1):
> >   ASoC: Fix the power update function for snd_soc_dapm_value_mux
> >
> >  sound/soc/soc-dapm.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
