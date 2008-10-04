From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc7-omap1-git 1/2] twl4030-core: move to drivers/mfd
Date: Fri, 3 Oct 2008 17:00:37 -0700
Message-ID: <200810031700.38008.david-b@pacbell.net>
References: <200810011947.55057.david-b@pacbell.net> <200810031516.32367.david-b@pacbell.net> <e5e6ade50810031631q59e527b7ke0e8787a857165f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:34868 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753352AbYJDAAk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 20:00:40 -0400
In-Reply-To: <e5e6ade50810031631q59e527b7ke0e8787a857165f2@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: linux-omap@vger.kernel.org

On Friday 03 October 2008, Nathan Monson wrote:
> > =A0http://marc.info/?l=3Dlinux-omap&m=3D122297833314280&w=3D2
> >
> > commenting on the issue I noted when I posted this patch;
> > showing how I work around that specific I2C error. =A0It'd
> > likely work for you too.
>=20
> Thanks for pointing this out. =A0The retry patch earlier in the threa=
d
> fixes the problem.
>=20
> On 5 test boots I received the "i2c_omap i2c_omap.1: controller timed
> out" message all 5 times, but it recovers and seems to work fine.

That's good news.

Now, I'll hope someone more in touch with the I2C hardware
can take a look at drivers/i2c/busses/i2c-omap.c and suggest
some way to stop getting this error ... nice that it's rather
reproducible, if one were to debug it!

As I noted in the message above, I see this error in other
cases too.  All of them "of course" should be made to handle
such faults better.  But virtually nothing in the I2C stack
does sane fault handling, so we also need the i2c-omap code
to stop misbehaving.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
