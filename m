From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] arm: omap2: timer: don't disable our timers
Date: Tue, 6 Oct 2015 11:09:26 -0500
Message-ID: <87d1ws2d3d.fsf@saruman.tx.rr.com>
References: <1444092332-9011-1-git-send-email-balbi@ti.com>
 <20151006080028.GI23801@atomide.com> <8737xo3uuq.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1275218308761861476=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8737xo3uuq.fsf@saruman.tx.rr.com>
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
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============1275218308761861476==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Felipe Balbi <balbi@ti.com> writes:

> Tony Lindgren <tony@atomide.com> writes:
>
>> * Felipe Balbi <balbi@ti.com> [151005 17:49]:
>>> We actually want these devices to be created because
>>> we will be moving timers to drivers/clocksource and
>>> this will prevent them from probing.
>>
>> Great. Is this safe to appy on it's own? We are not getting
>> system timers re-inited to the default values?
>
> not that I could notice. I booted on BBB and AM4. If you give me a few
> minutes I can boot again and save console logs for reference.

found another dependency. This will have to be done only after my
clocksource conversion is finished. Oh well

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWE/I3AAoJEIaOsuA1yqRExNwQAJDN34y475501n16RM08HX9Y
Ax80anO8j8Gxk8vLQE3Uhvq/VVuhPbXwFyim1Eq72VJucT5snlzpOZHtfHUbfHY/
lJXDettjQlt2kaRMc8CfGCDQb9ZiYTnjWHAfJu1M4oEyNSvuUYWPo8SjgEwV8aep
WPQcxktrl4hDbVt1t0hqPYfOAnAtDTbJ+QntQ5RrJqJ/hB1xS5xxxq4rSX0LAWKn
4cWyfBjVokKLg40962KAyO/E12NPUT/pY5k+BqhULGebStAVlnkaoUlOBEOVPFlI
GSkTsCuUPVnjxobGS+MoySBPif0fbwMY7I20SWBGro6+LEQ0yjEb81AofqKFM5c7
bihRDf9u310CX8N1qo1AapuwfzsUnTPReem8JWQ4b/Fw2kx5bA3MYsJerXiH4GjQ
HmnLMzoXL45qFpltUL4M4On9FUONf/MXvl3r6ewDDeXMjAfpDBbo60Paibvx+ee0
s5fyun8YenLYENAQ0e4JhuRYT50Eu4rt7kaQdCc+pzapkLbzdGupAMqU7sb+EVpU
6FG8KTjOyV/JMVJ19Ozw83LqaaUDO7vAZdN0hF2jUTq1dC7ln9oD+hZROkCMZqjY
oUD8hIDAEvfRbbGMp0VdX280Em2u8J0jD4UywG93dQgF+7sWlM1lcID4fCmUDYQM
imyGia8G37VsuXzqQb++
=qhd5
-----END PGP SIGNATURE-----
--=-=-=--


--===============1275218308761861476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1275218308761861476==--
