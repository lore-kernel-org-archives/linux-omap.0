From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Branch for fbdriver (Re: [PATCH 1/2] OMAP: Make dpll4_m4_ck
 programmable with clk_set_rate())
Date: Mon, 08 Dec 2008 16:54:35 +0200
Message-ID: <1228748075.8668.90.camel@tubuntu>
References: <yw1xhc76hmvi.fsf@thrashbarg.mansr.com>
	 <1224545064-25551-1-git-send-email-mans@mansr.com>
	 <alpine.DEB.2.00.0812051650380.21247@utopia.booyaka.com>
	 <20081206001153.GO9714@atomide.com> <yw1xtz9iytcd.fsf@thrashbarg.mansr.com>
	 <20081206021256.GY9714@atomide.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45969 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbYLHOyx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 09:54:53 -0500
In-Reply-To: <20081206021256.GY9714@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, 2008-12-05 at 18:12 -0800, ext Tony Lindgren wrote:
> * M=E5ns Rullg=E5rd <mans@mansr.com> [081205 17:40]:
> > Tony Lindgren <tony@atomide.com> writes:
> >=20
> > > M=E5ns, I heard you have some display patches? How about queuing =
up
> > > those on the fbdev list?
> >=20
> > It looks like Tomi's driver is shaping up nicely, so it's probably =
not
> > worthwhile spending any significant time on the current driver.  If
> > anyone is interested, everything I have is in my git tree.
>=20
> OK, good to know. Tomi, do you have a git branch against the
> mainline kernel for your driver?
>=20
> We could start mirroring it on linux-omap and then start automerging
> it on daily basis to linux-omap for testing (Assuming it does not cau=
se
> problems with other stuff :)

I have a git tree against current linux-omap tree at
http://www.bat.org/~tomba/git/linux-omap-dss.git

It is possible to have a branch based on Linus' tree also, but it's mor=
e
maintenance work as I need a bunch of omap patches that are not in
Linus' tree. (Actually, I have never tested DSS2 with Linus' tree, so
I'm not sure how much stuff there's missing).

I'd like to get the DSS2 working on OMAP2 also, but I'm (still) waiting
for my N810. Half a year ago the DSS2 did work on OMAP2, but I'm sure
it's since been broken, and needs some healing.

But after that I'm all for it.=20

However, there is a small breakage because of the VRAM manager and
OMAP_TAG removal. That code is common for the old and new DSS. I have a
patch to fix the old DSS to use the VRAM manager, but I don't think it'=
s
a good idea to break the old working code with new experimental code =3D=
).
So I think I'll see if I can easily separate the old and new boot time
memory allocation.

But what does it mean in practice?=20

Mirroring means you (script?) will fetch a branch from my tree to dss2
branch on linux-omap tree?

What does automerging mean?

Does it mean I can still continue rebasing my tree to keep it clean?

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
