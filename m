From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] regulator core: fix double-free in regulator_register() error path
Date: Tue, 28 Apr 2009 02:32:56 -0700
Message-ID: <200904280232.56329.david-b@pacbell.net>
References: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com> <200904272008.50268.david-b@pacbell.net> <20090428081646.GC20027@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n13a.bullet.mail.mud.yahoo.com ([68.142.207.51]:38859 "HELO
	n13a.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752044AbZD1JdF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Apr 2009 05:33:05 -0400
In-Reply-To: <20090428081646.GC20027@rakim.wolfsonmicro.main>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, linux-kernel@vger.kernel.org

On Tuesday 28 April 2009, Mark Brown wrote:
> > For the record, that "incomplete constraints" message is bogus.
> > On that board, VAUX3 has a complete set of constraints: =A0it may
> > only emit 2.8V.
>=20
> It's not VAUX3 that it's saying has incomplete constraints, it's the
> board as a whole - if the constraints for the board were fully specif=
ied

No; driver support !=3D constraint.  Only one of the
issues is packaged as a "constraint".


> (and the core had been told about it) then it would power off VAUX3 a=
t
> that point.
>
> > Mark and/or Liam ... you might want to fix that diagnostic, to
> > avoid leading more developers astray!
>=20
> Probably shove a "board has" in there or something I guess.

How about:  "VAUX3 board support is incomplete".
That's accurate.

A comment there might suggest constraints and
driver support as two common issues ... I'd not
be surprised to see a few more idioms pop up.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
