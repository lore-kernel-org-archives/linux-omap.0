From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 00/41] OMAPDSS: DT support v3
Date: Wed, 22 Jan 2014 10:41:55 +0200
Message-ID: <52DF8453.7030501@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <52DEE6B0.20106@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0160918953518885383=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52DEE6B0.20106@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Darren Etheridge <detheridge@ti.com>, Sebastian Reichel <sre@ring0.de>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, Stefan Roese <stefan.roese@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Robert Nelson <robertcnelson@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Florian Vaussard <florian.vaussard@epfl.ch>
List-Id: linux-omap@vger.kernel.org

--===============0160918953518885383==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="AgHv0g4DX2lgITqGmPg4bxLV8kbJCdjuG"

--AgHv0g4DX2lgITqGmPg4bxLV8kbJCdjuG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-21 23:29, Nishanth Menon wrote:
> Tomi,
>=20
> On 01/21/2014 04:56 AM, Tomi Valkeinen wrote:
>> Hi,
>>
>> Here's version 3 of the DSS DT series.
>>
>> The previous version can be found from:
>>
>> v1: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108249
>> v2: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108866
>>
>> The main changes to v2 are:
>>
>> - DT Binding documentation
>> - OMAP2 DSS support
>> - Split DSI register space
>> - DSS nodes disabled by default
>> - Hack to have generic DT bindings but OMAP specific drivers (for now)=

>>
>> This series can also be found from:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss=
-dt-review-3
>>
> http://slexy.org/view/s20JhteOFR is my quick build test report -> few
> checkpatch and build bisect issues would probably need fixing.

Thanks. Shouldn't make trivial changes, and then not run a full
commit-by-commit compile test...

I fixed the issues and pushed the branch again to work/dss-dt-review-3.
The fixes are minor, so the already posted series can be reviewed.

 Tomi



--AgHv0g4DX2lgITqGmPg4bxLV8kbJCdjuG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS34RXAAoJEPo9qoy8lh71JzkQAILQOThMuQQ7go86pEzYDWlj
wDpXsf1FaJL9WcUqRsSihV3jNGvs7bcXEuOf22mwqIw45uZqSbwixElA9Uac9L4S
f97a6Qx+iJJF1cbpgrsSSfvGk1RKLFARHwZwSouBO1hVaitT/+QHKFwLK6mi3Kqi
5yU0B4kADFVkcWXrKPu+SyDbC9br2+I1iMN2jzFZLCfEXiI8YPPISD8HqRBA+fbp
voA5Yx1uMqqlKHIvcdjdK8tVKxogmHI5uPTV7oqE30F6ldGww8aWO/P2iqI5LG+I
euy1acy0gLJ8wSn8APyKS9+rfihIgXX0vtWThWqdmeyP42YTgUog+WqE6A0h6EAK
Lf9dubne7x0g36FhjMuccqoko+bLg7kqM/TBnq44SBZ2bRlFhYOHnIOcWj6ZXm0J
C7hg+BPPb+r5EU47ngEqC3NX73nXe6dZjrCdCYUTcEh9et2U7hhJSDzIvQJ84wG4
TQyVmq7dX+UDLPStgjHrNPc85NwyCS+o0NL2yBkCfYBF69vGTIM05+wJvej+sZh+
2l7PJaLaQhE0yLk/tqaa1c6gqOaYlWi2U6Lfhq9AjjuXHL9RhlUcdHW+B268lZYL
r97A3zj2g8+E2pWRB3Q0/paEy87Nc+SuOxSGBbGxOAvaNck4Rpe5FHu4BRo6ircN
OdqA85sK41AezbOLOQXK
=QuRv
-----END PGP SIGNATURE-----

--AgHv0g4DX2lgITqGmPg4bxLV8kbJCdjuG--


--===============0160918953518885383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0160918953518885383==--
