From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] 34XX: Fix to use correct shift values for gpio2-6 fclks
Date: Fri, 28 Mar 2008 12:39:57 +0200
Message-ID: <20080328103957.GW24896@atomide.com>
References: <1206532658-11875-1-git-send-email-jouni.hogander@nokia.com> <alpine.DEB.1.00.0803261425030.19060@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:59389 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbYC1KkA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 06:40:00 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0803261425030.19060@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080326 22:33]:
> On Wed, 26 Mar 2008, Jouni H=F6gander wrote:
>=20
> > Wrong shift values were used for gpio2-6  fclks (gpt2-6 shift).
> > ---
> >  arch/arm/mach-omap2/clock34xx.h |   10 +++++-----
> >  1 files changed, 5 insertions(+), 5 deletions(-)
>=20
> Acked-by: Paul Walmsley <paul@pwsan.com>=20
>=20
> thanks Jouni,

Jouni, can you please repost with proper Signed-off-by?

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
