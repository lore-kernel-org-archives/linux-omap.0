From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/6] ARM: pm: allow generic sleep code to be used with
	SMP CPU idle
Date: Mon, 14 Feb 2011 16:01:33 +0000
Message-ID: <20110214160133.GA31501@n2100.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk> <E1PnviF-0002yt-EC@rmk-PC.arm.linux.org.uk> <AANLkTimmSbs7Q_068ERWeKUFV_1Fyxvj37e3r21LZYCL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42469 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab1BNQB7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 11:01:59 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimmSbs7Q_068ERWeKUFV_1Fyxvj37e3r21LZYCL@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Feb 13, 2011 at 01:59:54PM -0800, Colin Cross wrote:
> On Fri, Feb 11, 2011 at 8:19 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Allow the generic sleep code to be used with SMP CPU idle by storin=
g
> > N CPU stack pointers rather than just one.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > =A0arch/arm/kernel/sleep.S | =A0 26 +++++++++++++++++++++++++-
> > =A01 files changed, 25 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> > index 9f106fa..e10618f 100644
> > --- a/arch/arm/kernel/sleep.S
> > +++ b/arch/arm/kernel/sleep.S
>=20
> <snip>
>=20
> > @@ -107,4 +129,6 @@ ENTRY(cpu_resume)
> > =A0ENDPROC(cpu_resume)
> >
> > =A0sleep_save_sp:
> > - =A0 =A0 =A0 .word =A0 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 @ preserve stack phys ptr here
> > + =A0 =A0 =A0 .rept =A0 CONFIG_NR_CPUS
> > + =A0 =A0 =A0 .long =A0 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 @ preserve stack phys ptr here
> > + =A0 =A0 =A0 .endr
>=20
> This doesn't compile on CONFIG_SMP=3Dn, CONFIG_NR_CPUS is undefined.
> Including linux/threads.h will provide a default definition.

Added, thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
