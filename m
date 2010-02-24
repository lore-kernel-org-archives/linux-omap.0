From: roel kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] OMAP: Dereference of NULL autodep in _autodep_lookup()
Date: Wed, 24 Feb 2010 23:24:23 +0100
Message-ID: <25e057c01002241424s71cc447di4cb93de895cb665b@mail.gmail.com>
References: <4B781E05.9040502@gmail.com> <alpine.DEB.2.00.1002221357280.2701@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1002221357280.2701@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> Thanks for the patch, but I don't understand what problem you're
> pointing out. =C2=A0If autodeps is NULL entering clkdm_init(), then t=
he
> for-loop won't even be entered.

My first patch was wrong, but there's something I think could
be wrong. In clkdm_init() we have:

for (autodep =3D autodeps; autodep->pwrdm.ptr; autodep++)
        _autodep_lookup(autodep);

In _autodep_lookup() we ensure that we don't dereference
autodep by:

if (!autodep)
        return;

but if autodep can be NULL we already dereferenced it in
the aforementioned for loop, so shouldn't that be:

for (autodep =3D autodeps; autodep && autodep->pwrdm.ptr; autodep++)
        _autodep_lookup(autodep);

Then since this is the only call to _autodep_lookup() we can remove
that test there. Do you agree?

> It looks like there may be a problem, however, in _clkdm_add_autodeps=
()
> and _clkdm_del_autodeps() if no autodeps were passed in. =C2=A0What d=
o you
> think about something like the following instead?
>
>
> - Paul

Your suggested patch looks right to me as well.
