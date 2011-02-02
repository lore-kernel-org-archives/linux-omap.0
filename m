From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 1/4] drivers: hwspinlock: add framework
Date: Wed, 2 Feb 2011 12:11:47 +0000
Message-ID: <20110202121147.GA24993@n2100.arm.linux.org.uk>
References: <1296470024-26854-1-git-send-email-ohad@wizery.com> <1296470024-26854-2-git-send-email-ohad@wizery.com> <20110131153831.dca62146.akpm@linux-foundation.org> <AANLkTik-fgCF_W0-DBE6UVTpjqF6Jf=u7bQYkcweEegQ@mail.gmail.com> <20110131223859.27169db0.akpm@linux-foundation.org> <AANLkTinJLAT0B61Eu1Chn9k9rmbHXa1ZNcedo_m8TZp3@mail.gmail.com> <20110131234028.8744b5fd.akpm@linux-foundation.org> <AANLkTi=zOO_vDQ4+LWQs38xjo+VaRG0jfgo6ifvh=L-M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42310 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab1BBMMM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 07:12:12 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=zOO_vDQ4+LWQs38xjo+VaRG0jfgo6ifvh=L-M@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@ti.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul@pwsan.com>, Hari Kanigeri <hari.kanigeri@gmail.com>, Simon Que <simonque@gmail.com>

On Tue, Feb 01, 2011 at 10:12:38AM +0200, Ohad Ben-Cohen wrote:
> On Tue, Feb 1, 2011 at 9:40 AM, Andrew Morton <akpm@linux-foundation.=
org> wrote:
> > On Tue, 1 Feb 2011 09:36:22 +0200 Ohad Ben-Cohen <ohad@wizery.com> =
wrote:
> >
> >> On Tue, Feb 1, 2011 at 8:38 AM, Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >> >> I'll do a quick respin of the patches with that and the
> >> >> hwspinlock_internal.h comment above.
> >> >
> >> > OK..
> >> >
> >> > The patch series looks OK to me.
> >>
> >> Can I add your Acked-by on the non-omap parts when I respin the se=
ries ?
> >
> > spose so. =A0I don't normally do acked-by's. =A0I think it's my way=
 of
> > avoiding getting blamed when it all blows up.
>=20
> I don't want to be breaking old habits then :)
>=20
> >> > Maybe Tony or Russell or Greg can grab them
> >> > if they like the look of it all?
>=20
> Let's just wait a bit for Tony's or Russell's or Greg's answer.

As it touches OMAP code, it makes sense to merge it through Tony's tree
as that should reduce the number of possible conflicts.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
