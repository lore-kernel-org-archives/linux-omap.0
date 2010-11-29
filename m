From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Mon, 29 Nov 2010 11:57:58 +0200
Message-ID: <AANLkTimxP0ejc5i8cbEmdFidvCgH1pk5-Vc_WEGM2Hwa@mail.gmail.com>
References: <AANLkTi=JSuJCqceJ3iw3TnV5OeJd+e5T3CyHtWVzBRu_@mail.gmail.com>
 <536589.12568.qm@web180310.mail.gq1.yahoo.com> <AANLkTinQdNC0XaOqNyDbdYE6ZcP0QyzpN492j=Kovuea@mail.gmail.com>
 <1290716548.2529.136.camel@helium> <AANLkTi=sZ-4BBLAJNU5B41cAxtroGkpNomgEYO4vtx8z@mail.gmail.com>
 <1290821087.2529.252.camel@helium>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290821087.2529.252.camel@helium>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: MugdhaKamoolkar <mugdha@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, BenoitCousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, HariKanigeri <h-kanigeri2@ti.com>, SumanAnna <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 27, 2010 at 3:24 AM, David Brownell <david-b@pacbell.net> w=
rote:
> Your intent "generic" is fine, but you've not achieved it and thus I
> think you shouldn't imply that you have. =A0 Dropping the word "gener=
ic"
> should =A0suffice; it _is_ a framework, and maybe the next person wor=
king
> with hardware spinlocks can finish generalizing (and add use cases).

Sure, I can drop the word "generic".

> Haven't looked at RT in a long time. =A0Just look at the current RT
> patchset to see if it still has several spinlock variants. =A0ISTR th=
e
> "raw" spinlock stuff came from there not long ago. =A0Much compile-ti=
me
> magic was involved in switching between variants.

I'll take a look there and see if I catch anything relevant.

Thanks,
Ohad.


>
> - Dave
>
>
>
