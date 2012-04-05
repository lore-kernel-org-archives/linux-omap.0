From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for v3.4-rc1
Date: Thu, 5 Apr 2012 11:19:00 -0700
Message-ID: <20120405181900.GE3785@atomide.com>
References: <20120405004256.GB10780@atomide.com>
 <CAOesGMg7DWDH4ix30fh23YZ1hg207S7oQ05njrfEBkaYPjKWDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:28176 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518Ab2DESTG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 14:19:06 -0400
Content-Disposition: inline
In-Reply-To: <CAOesGMg7DWDH4ix30fh23YZ1hg207S7oQ05njrfEBkaYPjKWDQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Olof Johansson <olof@lixom.net> [120405 10:51]:
> Hi,
>=20
> On Wed, Apr 4, 2012 at 5:42 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> > Hi Arnd & Olof,
> >
> > Please pull omap fixes from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fix=
es
> >
> > Note that this also contains a set of fixes that are not regression=
s
> > or oopses to properly deal with the smsc911x regulator issue.
> >
> > Basically the regulators must be per board file as the regulators
> > can also come from drivers, such as twl4030. So it's best to dumb
> > down gpmc-smsc911x.c to not even care about the regulators.
> >
> > Regards,
> >
> > Tony
> >
> >
> > The following changes since commit dd775ae2549217d3ae09363e3edb305d=
0fa19928:
> > =C2=A0Linus Torvalds (1):
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux 3.4-rc1
> >
> > are available in the git repository at:
> >
> > =C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-om=
ap fixes
>=20
>=20
> Thanks, pulled.

Thanks.
=20
> Feel free to start sending these as signed tags with the above in the
> tag description, so it's carried forward in the git history without
> any work for us. :-)

OK will do.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
