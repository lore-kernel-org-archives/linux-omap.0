From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Regression in next caused by 95026658c46e i2c: do not use
 internal..
Date: Mon, 14 Mar 2016 17:52:06 +0100
Message-ID: <20160314165206.GA16371@katana>
References: <20160314160944.GG9329@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3455084729947483465=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160314160944.GG9329@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============3455084729947483465==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> Having something like this happen just as the merge window opens is
> not nice. You guys should already know..

I already applied the fix.

> The patches in next should be sitting there for a few weeks before the
> merge window so issues like this are found out early.

I understand this was a major hickup and I am sorry for this. I should
have known better.

I am not taking 100% of the blame, though: The amount of submissions is
rising faster than the amount of non-maintainer review being done (at
least in the subsystems I work on). I took a wrong step in trying to
handle the gap. I am really sorry about the fuzz, yet I can't deny there
is also something inevitable in that to me. That being said, I'll of
course try harder to not let this happen again.

Regards,

   Wolfram


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5uw2AAoJEBQN5MwUoCm2avcP/2WLqqKDCZ6vJ4JFWtvCtSMA
zV4dCa0TMek/on+ZZyQq6SpBbNHBY20VvNe7Ez+DyGmeOV1uB95CgItCFKLMu2/n
rUavH5zfTpkBYJBDnaJoCtnBi0ZamvJxMxZkQ8rTesUqUqUKu+GTRBa6ZCeVUoDC
Hz81TX78q7cFmSQXn2GtPjE2YceiuQfTnn9YPZbbDjJX/0kYaindLUlq+ls175Up
ze3FtOYqtNdxtXHDdQcoLFgz62HdM+yUj0HrA7ZusJHYBTIt6jRyFYbXcj6KZWaW
1UiPbEgKfgzoY6Zi2HO8VR2LVU7TFqDPoa0F/ahZ6fVQw2gtEUfnuVddhXH6YIvo
orrcdqwiV81pSO4wfzgEs1sDs7+0Awli/6DyO/bSRdoXGmYJxnIoMaNIZcmAuY8j
ygbRr2oD0GOhYGv2en4Kj5EsFPzyUg8PVdF04n0mZ0r2d/lt3JenjB982tYFtEPC
Jhc3RK5jWl+QOAwVVt3u/G2z2aZs9mLUT8IavFRPdmcp4WbPcc8n7tQCbkyEGLHD
8VXwYbvEjifs9sYHKp+nV+amvPDroqYXlF5zc5215DN1HiU9eOBIhhp9786dRdOp
ppDLIXb5HQpSagwJuVLLV3ndqrK0ncIn2XZRXxJ+jTkTb8/DgImxWvcNWf+rz4uJ
2mlKm45PPsY64MUFJTwh
=gkWI
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--


--===============3455084729947483465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3455084729947483465==--
