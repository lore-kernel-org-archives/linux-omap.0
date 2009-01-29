From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/9] ARM: OMAP: Fix McBSP spin_lock deadlock
Date: Wed, 28 Jan 2009 16:51:28 -0800
Message-ID: <20090129005127.GW32148@atomide.com>
References: <20090128181931.21007.73744.stgit@localhost> <20090128192705.GG23301@n2100.arm.linux.org.uk> <20090128212854.GV32148@atomide.com> <200901281553.07677.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51996 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZA2Avi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 19:51:38 -0500
Content-Disposition: inline
In-Reply-To: <200901281553.07677.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [090128 15:53]:
> On Wednesday 28 January 2009, Tony Lindgren wrote:
> > > On the other hand, we probably need this fix. =A0The question is,=
 are there
> > > real problems being caused by this, or is this patch just the res=
ult of
> > > code analysis? =A0And can these problems be produced with mainlin=
e (iow,
> > > do we have enough other code merged to expose this)?
> >=20
> > AFAIK it happens in the mainline with CONFIG_PREMEPT and ASoC.
>=20
> I thought it was just spinlock debugging, period.

Yeah right, that's all there is to it. Without ASoC there may not be
any McBSP users.. And to see the warnings spinlock debugging is needed.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
