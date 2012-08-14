From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 09/13] OMAPDSS: SDI: Create a function to set timings
Date: Tue, 14 Aug 2012 16:44:05 +0300
Message-ID: <1344951845.4845.58.camel@lappyti>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	 <1344512989-4071-1-git-send-email-archit@ti.com>
	 <1344512989-4071-10-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-CcAd1kP5HDlUBaHOaW15"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:36640 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751663Ab2HNNoU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 09:44:20 -0400
Received: by lagp5 with SMTP id p5so193406lag.9
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 06:44:09 -0700 (PDT)
In-Reply-To: <1344512989-4071-10-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-CcAd1kP5HDlUBaHOaW15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-09 at 17:19 +0530, Archit Taneja wrote:
> Create function omapdss_sdi_set_timings(). Configuring new timings is don=
e the
> same way as before, SDI is disabled, and re-enabled with the new timings =
in
> dssdev. This just moves the code from the panel drivers to the SDI driver=
.
>=20
> The panel drivers shouldn't be aware of how SDI manages to configure a ne=
w set
> of timings. This should be taken care of by the SDI driver itself.

I'm not sure about this one. Although I see that dpi.c does currently
the same thing as you're doing in your patch.

One thing is that we should try to remove dssdev uses from the output
drivers, including use of dssdev->state.=20

The other thing is that I don't think the output driver should disable &
enable the output during set timings. I think sdi's set_timings should
return EBUSY if the output is enabled. The same way as other
configuration functions should (like dpi_set_data_lines or such).

I'm actually not sure if even the panel driver should disable & enable
the output during set_timings. Perhaps it should be the caller's
(omapdrm or such) responsibility....

My reasoning here is that disabling & enabling the video output is not
invisible to the upper layers, so doing it "in secret" may be bad.

Then again, perhaps timings can be changed freely on some other
platforms, and then it'd be nice if the panel driver wouldn't disable &
enable the output.

So I'm again not quite sure what's the best way to handle this... (of
the dssdev->state I'm sure, its use should be removed from omapdss). Any
thoughts?

 Tomi


--=-CcAd1kP5HDlUBaHOaW15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQKlYlAAoJEPo9qoy8lh71sEkP/1cKQS6aB0XAPCr+meXGwyhs
dJDcGu18Pg/0j8nmukOF7Td3B/EOgCbNfF1/aLjWVXyPlWP0ajSOrnnX4yza0D8w
4Loj/g2ouznSSGlFp+lOqs06O/LH7kXeAIHKnNTjtUm3m6MOTDo7ZKty+Ou959eK
gHMbyOO+65Ng/s55O8vo27ZBB2AUFpXvwqe5iDhXmEUx648JldC2c4X/Q0u+fwAZ
fKUCC6/LcZKj5VMu91E5N4iTMHeva9QmaigsQEvUVtuezf8joJn3lvfpWI/amFMg
qyq5ATgzmFjd7KJlBDTxz+B0CxWHNWumeknhobLetta4hpEIedxvfAG9/99wrVhj
xVrqTkoNXupQuVlhGnRSkwDg16l5i75TRQLP1QHMbAnOmPgM05mihA1UQ6qspRCU
9H6yyVlQGZ9tRKDk9X/b2Tl+djvGpfuuXXG1uryeMFf63UM6J9vKJmysGlr+ZkhF
FUYfFYYUyIFJGkkFubLYAeUtngxdIa/RLtMNWvh0x+V5nqN7ASaraA7BOhEv+aYn
DVch99YxLsFgjmsRWjYnLh050eVCXPvnzMv/9DO8vHr7ToWUt0cBAKdOG26dg/3E
hajxVIVVbIilUEOWzf+RCjvuPjBobT1p799NN0VuJWM+b4FJKVVaYVROIec9HKVQ
WZbeMtEa0+WhtXFdPInb
=NxRR
-----END PGP SIGNATURE-----

--=-CcAd1kP5HDlUBaHOaW15--

