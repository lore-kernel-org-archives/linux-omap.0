From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP display kconfig options changing
Date: Fri, 18 Dec 2015 17:00:57 +0200
Message-ID: <56741FA9.3080607@ti.com>
References: <5673CA0D.4000706@ti.com> <20151218135342.GF23396@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7646841374920008798=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151218135342.GF23396@atomide.com>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============7646841374920008798==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IVfXa9RWgOF9dHEekB0aVP65MpqrPNrCE"

--IVfXa9RWgOF9dHEekB0aVP65MpqrPNrCE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 18/12/15 15:53, Tony Lindgren wrote:
> Hi,
>=20
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [151218 00:55]:
>> Hi Tony,
>>
>> I've just pushed a patch series to fbdev for-next branch which makes t=
he
>> OMAP DRM and FB drivers independent of each other. This requires
>> changing the related Kconfig options.
>=20
> OK

Note that nothing has changed with omapfb and omapdrm as such. The only
(visible) change is the needed Kconfig options.

>> What should I do with omap2plus_defconfig?
>>
>> At the moment omap2plus_defconfig enables the omapfb driver and panels=

>> as modules. Should I change it to do the same with the new code? Or
>> should I change it to use omapdrm, which is the better maintained and
>> developed driver (although no one has probably tried omapdrm on omap2)=
?
>=20
> I'm all for changing omap2plus_defconfnig to use omapdrm.
>=20
> Do you have a link to a page we can point people to for instructions
> for what needs to be changed to get things working with omapdrm?

Are you referring to Kconfig options? Or userspace?

But no, I don't have links to either.

For the Kconfig options, it's pretty similar to omapfb. After the
patches I'm pushing, one needs to enable DRM, DRM_OMAP, and then the
individual panel/encoder drivers (as for omapfb).

> For omap2, I can try to peek into my rack for n800.

There were a few fixes sent a few days ago which are needed for OMAP2/3.
I think both are now in Linus' tree.

 Tomi


--IVfXa9RWgOF9dHEekB0aVP65MpqrPNrCE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWdB+pAAoJEPo9qoy8lh71arcP/RBbNnBa/r5vJdRgdkQvHkmX
C1Zt1d6Z+cEeA8Gsu9wJyWGGjeYIckH63EtecJe08HtacrYCTD74KUHcV4G0ZAaI
UtJgCNl4/YajY4QmWZbfRq/8sNR38XaEm5V8G6amFurf89Qm3GtsVm7DM4O/xG0G
Fw3m1xUaXMC0joDSLcjktYwS0firzGnGtlmL9vugd1Zllbck3e1/+AVnDIgPxHBy
I08f/h5RQ0v4MTxxEdluWujB8IsGWD3FOZXxYNgMEnen3Xm04Yf0MFwP7ftvTiuh
dVDiWSvEz5xHD/aUm0r90iJ19hH2tdjoOUKtAYd3GYajEIMMq4lcNNqX/CEujyA8
iKzcX4sif7Q/WVSBeCY3gMf3tiDBk5JViW06nDfLY/CzbIj2efRW/bp/EiswrMBB
nLlbTngaW8YPHbVEsof6rIUKens5dr5pCZ1mF0NmXQN21Gu+xkqFIuB4TphwRQGn
upbOqqnOB8vdMTddyUyNRe/xPtdfyOILzRAJqt+obB54wsnTmmKvGXX3TmSNLcUa
qJ7m+YEPuCHPoKa1vBvsCZzkE7PgIb+gJE7QJHG4pMagdGQrLHFx7jHHHgKRWWpD
t7Ex7zZzg+fm6GZgrn7h9vQ3fa2bdaoocBjeRs8oE9i5fTbock5sg3oVOTTrUshq
T7stzXryaxncPlIVgfQq
=Vfpt
-----END PGP SIGNATURE-----

--IVfXa9RWgOF9dHEekB0aVP65MpqrPNrCE--


--===============7646841374920008798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7646841374920008798==--
