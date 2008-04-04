From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Fix function declaration.
Date: Fri, 4 Apr 2008 14:34:56 +0300
Message-ID: <20080404113455.GO3505@atomide.com>
References: <1207306776-19509-1-git-send-email-ext-tapio.laxstroem@nokia.com> <1207306776-19509-2-git-send-email-ext-tapio.laxstroem@nokia.com> <20080404143315.2ed2e601.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57134 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbYDDLfA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 07:35:00 -0400
Content-Disposition: inline
In-Reply-To: <20080404143315.2ed2e601.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext tapio =?iso-8859-1?Q?laxstr=F6m?= <ext-tapio.laxstroem@nokia.com>, linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080404 14:33]:
> On Fri,  4 Apr 2008 13:59:36 +0300
> ext tapio laxstr=F6m <ext-tapio.laxstroem@nokia.com> wrote:
>=20
> > Signed-off-by: tapio laxstr=F6m <ext-tapio.laxstroem@nokia.com>
> > ---
> >  arch/arm/mach-omap2/board-n800-audio.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > -void __init n800_audio_init(void)
> > +void __init n800_audio_init(struct tsc2301_platform_data *tc)
> >  {
> >  }
> Acked. Had exactly same fix in my own tree but forgot to send it :-)

Pushed.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
