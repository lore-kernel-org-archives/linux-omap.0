From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 01/23] I2C: TWL4030: checkpatch.pl fixes for twl4030-core.c
Date: Fri, 11 Apr 2008 09:16:39 -0700
Message-ID: <200804110916.40089.david-b@pacbell.net>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com> <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com> <010C7BAE6783F34D9AC336EE5A01A08805D6500C@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:30601 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760134AbYDKQQl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Apr 2008 12:16:41 -0400
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08805D6500C@dbde01.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Friday 11 April 2008, Gadiyar, Anand wrote:
> > =A0static int __init twl4030_init(void)
> > =A0{
> > -=A0=A0=A0=A0=A0int res;
> > -
> > -=A0=A0=A0=A0=A0if ((res =3D i2c_add_driver(&twl4030_driver))) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_ERR "TWL4030: D=
river registration failed\n");
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return res;
> > -=A0=A0=A0=A0=A0}
> > -
> > -=A0=A0=A0=A0=A0pr_info(KERN_INFO "TWL4030: Driver registration com=
plete.\n");
> > -
> > -=A0=A0=A0=A0=A0return 0;
> > +=A0=A0=A0=A0=A0return i2c_add_driver(&twl4030_driver);
> > =A0}
>=20
> You're losing the failure print here. Not sure if it matters, but
> I'm pointing it out anyway.=20

Doesn't matter; the standard policy is to have module init
just add the drivers and let the subsystems handle any
(unlikely) warning messages.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
