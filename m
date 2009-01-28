From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/9] ARM: Do early I/O mapping if spinlock debugging is enabled
Date: Wed, 28 Jan 2009 15:51:51 -0800
Message-ID: <200901281551.52060.david-b@pacbell.net>
References: <20090128181931.21007.73744.stgit@localhost> <20090128182305.21007.62781.stgit@localhost> <20090128185355.GC23301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:21139 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759801AbZA1Xvy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Jan 2009 18:51:54 -0500
In-Reply-To: <20090128185355.GC23301@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, Juha Yrjola <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org

On Wednesday 28 January 2009, Russell King - ARM Linux wrote:
> >=20
> > At least on OMAP, sched_clock() requires the I/O maps to be initial=
ized.
> > Spinlock debugging invokes sched_clock() very early.
>=20
> NAK. =A0This doesn't and can't work on every platform out there. =A0T=
he
> only viable fix is that sched_clock() must NOT be used early.
>=20
> If the kernel is using sched_clock() early, that's a bug.

So you're saying that spinlock debugging is buggy???

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
