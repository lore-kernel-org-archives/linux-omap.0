From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] regulator core: fix double-free in regulator_register() error path
Date: Mon, 27 Apr 2009 20:08:50 -0700
Message-ID: <200904272008.50268.david-b@pacbell.net>
References: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com> <alpine.DEB.2.00.0904252250230.4291@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:26210 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753467AbZD1DIw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Apr 2009 23:08:52 -0400
In-Reply-To: <alpine.DEB.2.00.0904252250230.4291@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org

On Saturday 25 April 2009, Paul Walmsley wrote:
>=20
> > device_unregister() calls regulator_dev_release() which frees rdev.=
 =A0The=20
> > subsequent kfree corrupts memory and causes some OMAP3 systems to o=
ops on=20
> > boot in regulator_get().
>=20
> For the 3430SDP users out there, this patch also fixes the boot hang =
after=20
> "regulator_init_complete: incomplete constraints, leaving VAUX3 on"
> on that device.

=46or the record, that "incomplete constraints" message is bogus.
On that board, VAUX3 has a complete set of constraints:  it may
only emit 2.8V.

What it lacks is something entirely different:  driver support
for the LCD which uses the regulator framework, instead of just
bypassing it and talking directly to the PMIC.  By the time it
gets there, the LCD has probably been turned on.

Mark and/or Liam ... you might want to fix that diagnostic, to
avoid leading more developers astray!

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
