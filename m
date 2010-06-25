From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Fri, 25 Jun 2010 21:20:02 +0100
Message-ID: <20100625202002.GC22090@n2100.arm.linux.org.uk>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com> <1277422991-25350-2-git-send-email-khilman@deeprootsystems.com> <AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com> <20100625200659.GB22090@n2100.arm.linux.org.uk> <AANLkTikYE6Kg8C_ZClx9aKLvOa9CQRUT587hQnB91sua@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51302 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab0FYUUQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 16:20:16 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikYE6Kg8C_ZClx9aKLvOa9CQRUT587hQnB91sua@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Eric Miao <eric.miao@canonical.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

On Fri, Jun 25, 2010 at 02:13:15PM -0600, Grant Likely wrote:
> On Fri, Jun 25, 2010 at 2:06 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Jun 25, 2010 at 09:26:43AM -0600, Grant Likely wrote:
> >> This approach is also not multiplatform friendly (cc'ing Eric and
> >> Nicolas who are working on ARM multiplatform). =A0It won't work fo=
r
> >> building a kernel that supports, say, both versatile and OMAP.
> >
> > And I should also point out that multiplatform is not the answer to
> > Linus' concerns. =A0There's no way such work is going to be anywher=
e
> > near complete come the next merge window.
>=20
> Yes, but solving the defconfig problem isn't the reason for multiplat=
form.

Does anyone know where we are on the defconfig problem?  From what I
can see, it's mostly stalled for the time being, which is not good
news for us.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
