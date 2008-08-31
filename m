From: David Brownell <david-b@pacbell.net>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Sun, 31 Aug 2008 14:47:20 -0700
Message-ID: <200808311447.20312.david-b@pacbell.net>
References: <20080827220821.GE7227@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:25295 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753506AbYHaVrW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Aug 2008 17:47:22 -0400
In-Reply-To: <20080827220821.GE7227@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

On Wednesday 27 August 2008, Russell King wrote:
> I sent a similar patch to the one below against mainline to Tony toda=
y.

And I'm glad to see those updates.  I used to constantly trip over
code doing strange stuff in those areas, and it would be nice to
see "sparse" approve a lot more driver code...


> I've marked some changes with certain tags:
>=20
> - FIXME: where I think the code is just plain wrong -
> =A0 - such as putting a physical address through a macro which conver=
ts
> =A0 =A0 virtual to physical addresses (1510 and 1610 mcbsp).
> =A0 - or passing virtual addresses to DMA functions (mcbsp).
> =A0 - or passing physical addresses when what's required is a virtual=
 address
> =A0 =A0 (omap_udc).

Yeah, the omap_udc one looks like the __REG() conversion patch
just did the wrong thing.  Fix looks trivial, and once I verify
it then I'll send it through mainline.


> - CHECKME: where I've changed something to make it build but I don't
> =A0 know if this is right.
>=20
> - WBNI: more a preference to see something changed than a bug.
>=20
> Comments on the FIXMEs are what I'm really interested in, and prefera=
bly
> having them actually fixed would be a good idea.

I verified that the OMAP tree boots on my OMAP5912 OSK, at least
once things like cpufreq, PM, and MTD are disabled.  The MTD thing
is a known/solved issue in mainline.  (Block queue changes broke
MTD...)  The oopses in cpufreq and pm_idle are more cryptic.

So I can try my patch for the omap_udc thing ... even though for
OSK the mainline kernel ** DOES NOT BOOT ** and dies even before
the kernel "hello, I'm RC5!" banner prints.  Someone with a JTAG
to throw at this might be able to fix that regression quickly.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
