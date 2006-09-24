From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: running user application on omap
Date: Sun, 24 Sep 2006 07:21:00 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A507C239B5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: srini kode <srinikode@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

When things don't work as expected one thing to do is to use strace or
ltrace and to look at the error outputs.  'strace ./apptest'

Depending on the shell type and version its errors are not always that
explicit.  Where did you get your NFS root from?  How was it compiled?
File systems can be created such that they are not compatible with
binaries (soft vs. hard float for example).

Also, what are the permissions after you copied it?  If your lucky all
you need is a chmod 777 apptest.  I would have guessed your shell might
have told you about that kind of error but I don't know.

Also, I've not used 3.3.2 with 2430, only 3.4.0 and 3.4.1.  This
shouldn't matter much, but if you are mixing and matching VFP/Hardfloat
it might.

Regards,
Richard W.

> We are writing a test user application to run in user
> space. We downloaded the gcc from linux.omap.com site,
> installed it under /usr/linux/arm
> and compiled successfully the application as follows:
>=20
> arm-linux-gcc-3.3.2 -I /usr/local/arm/3.3.2/include -L
> /usr/local/arm/3.3.2/lib apptest.c -o apptest
>=20
> Now we created a test directory on the nfs mounted
> root directory in omap 2430 sdp and copied the
> "apptest" to this directory and executed from there.
> We get the follwoing error:
>=20
> /test $ ./apptest
> -sh: ./apptest: not found
> /test $
>=20
> All the above we were trying from the
> console(hyperterminal connected to uart1-2 on omap).
>=20
> can you please let us know the steps we are missing.
>=20
> Regards
> Srini
>=20
>=20
>=20
>=20
>=20
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
