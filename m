From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/9] ARM: OMAP: Fix McBSP spin_lock deadlock
Date: Wed, 28 Jan 2009 15:53:07 -0800
Message-ID: <200901281553.07677.david-b@pacbell.net>
References: <20090128181931.21007.73744.stgit@localhost> <20090128192705.GG23301@n2100.arm.linux.org.uk> <20090128212854.GV32148@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:22809 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759586AbZA1XxK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Jan 2009 18:53:10 -0500
In-Reply-To: <20090128212854.GV32148@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

On Wednesday 28 January 2009, Tony Lindgren wrote:
> > On the other hand, we probably need this fix. =A0The question is, a=
re there
> > real problems being caused by this, or is this patch just the resul=
t of
> > code analysis? =A0And can these problems be produced with mainline =
(iow,
> > do we have enough other code merged to expose this)?
>=20
> AFAIK it happens in the mainline with CONFIG_PREMEPT and ASoC.

I thought it was just spinlock debugging, period.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
