From: Tony Lindgren <tony@atomide.com>
Subject: Re: n800 build error in clock24xx.c: 'secure_32k_ck' undeclared
Date: Mon, 20 Apr 2009 10:38:14 -0700
Message-ID: <20090420173814.GI27304@atomide.com>
References: <873ac7ko2n.fsf@litku.valot.fi> <20090419050020.GC1736@swansys> <87prf8skiq.fsf@litku.valot.fi> <20090420012336.GE1736@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55722 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZDTRiS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 13:38:18 -0400
Received: from c-67-160-239-110.hsd1.ca.comcast.net ([67.160.239.110] helo=localhost.localdomain)
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LvxRg-000Kog-6i
	for linux-omap@vger.kernel.org; Mon, 20 Apr 2009 17:38:17 +0000
Content-Disposition: inline
In-Reply-To: <20090420012336.GE1736@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* green <greenfreedom10@gmail.com> [090419 18:43]:
> Kalle Valo wrote at 2009-04-19 09:58 -0600:
> > green <greenfreedom10@gmail.com> writes:
> >=20
> > > Kalle Valo wrote at 2009-04-17 14:44 -0600:
> > >
> > >> arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_epoll_w=
ait':
> > >> arch/arm/kernel/sys_oabi-compat.c:289: error: implicit declarati=
on of function 'kmalloc'
> > >> arch/arm/kernel/sys_oabi-compat.c:289: warning: assignment makes=
 pointer from integer without a cast
> > >> arch/arm/kernel/sys_oabi-compat.c:302: error: implicit declarati=
on of function 'kfree'
> > >> arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_semtime=
dop':
> > >> arch/arm/kernel/sys_oabi-compat.c:325: warning: assignment makes=
 pointer from integer without a cast
> > >
> > > I see nearly the same:
> > >
> > > arch/arm/kernel/sys_oabi-compat.c: In function =E2=80=98sys_oabi_=
epoll_wait=E2=80=99:
> > > arch/arm/kernel/sys_oabi-compat.c:288: error: implicit declaratio=
n of function =E2=80=98kmalloc=E2=80=99
> > > arch/arm/kernel/sys_oabi-compat.c:288: error: =E2=80=98GFP_KERNEL=
=E2=80=99 undeclared (first use in this function)
> >=20
> > I think that's the same error. Most probably my tree was dirty and
> > that's the line numbers are different.
>=20
> I was noticing the 'GFP_KERNEL' undeclared error rather than the line=
 numbers.

Looks like the above is fixed by cbb55092a674bcfd9774637a06d0f1511763aa=
2c,
I'll git cherry-pick that one.

The secure_32k_ck is still undefined though.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
