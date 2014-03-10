From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 00/41] OMAPDSS: DT support v3
Date: Mon, 10 Mar 2014 15:22:48 +0200
Message-ID: <531DBCA8.80507@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <531823C5.1020008@ti.com> <20140307164929.GC3789@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6364485765324715740=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140307164929.GC3789@atomide.com>
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
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Enric Balletbo Serra <eballetbo@gmail.com>, Sebastian Reichel <sre@debian.org>, Javier Martinez Canillas <javier@dowhile0.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Darren Etheridge <detheridge@ti.com>, Sebastian Reichel <sre@ring0.de>, Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Stefan Roese <stefan.roese@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6364485765324715740==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="afr6f1SGcBTWJSX9cwlt8HDNQfmPvF2Vp"

--afr6f1SGcBTWJSX9cwlt8HDNQfmPvF2Vp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/03/14 18:49, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140305 23:32]:
>> Hi Tony,
>>
>> On 21/01/14 12:56, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> Here's version 3 of the DSS DT series.
>>
>> Can you have a look at the arch/arm/ parts in the series and ack if
>> they're ok, i.e, patches 1, 2, 32.
>=20
> Patches 1, 2 & 32 look OK to me, so for those please feel free to add:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks.

> How about do a pull request for just the .dts changes against current
> omap-for-v3.15/dt branch ASAP for me so I can pull it in? That is assum=
ing
> that just the .dts changes alone won't break anything.

Unfortunately they do break. At least pinmuxing is moved from the global
definitions to be handled by the respective display drivers, and there
are some regulator_name hacks that the DT patches remove.

I think those changes could be removed from my patches, and then added
back later when everything else has been merged.

The bigger issue is that suddenly there's lots of discussion about the
display DT bindings. If those are not resolved very soon, I guess I have
no choice but to again skip the merge window for the DSS DT changes.

 Tomi



--afr6f1SGcBTWJSX9cwlt8HDNQfmPvF2Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTHbyoAAoJEPo9qoy8lh71VLQP/2z8H92z1o1BnIA2roTyljxA
eVcatLA4UaZhfPHojbjzlN5Ap6lwAT5E5RtlNZfrdo41cGErxCk4mXmgO5IOa8EQ
i8NXlBaPWYJKuyUWdtuPP70p7rHBSM83a5GBWpCkVu70+qnoUXTA+ZbNYSG3PVqu
OSnwUFwLoBPjNiadK5PP0MvuFjwLHRYDb2GuB3smJu50DAe6g8Xh7OVDKZipyZbY
5B15zLp+64FEbRsfA6PiIrwiILQSPkmPNhsnijjfjM2lAM2CUxDRVQSgofOfxk6Y
nbyB4g2Yoe1hyo/RgsatQMhIzp6k+btO2LoKiKQxMay8r1+Tm9+VQZDCdMdK7Yrf
3kdYFaDv9YUO3MxIRQrwGH+TqiK1H83Z106nKKBp9G9mV1sufJQMs8S4+q/5C2Co
eXGAF0BByBIBKdrTMUUMVV0qew6AWCRTos5qmtkDdL2EBGVnxDirexD8L1i3EQFv
gpqJf9BzhXSRpGnQKFect8J+cZfklmhztDA18UOsUwMAzhSobrlQG1klxAFzTmGv
0c/7BjMzncj0a0f/JnOPRZcPRzbNtdwTdEIg8jIK2jyNDU9mWGmVe+QtlQTXPGCB
sFyT62bQP3GQTVr1encH+3xiw61HPnHyRQX0/pGLIy1o67kSUhuND0DPQOgY8gFX
2o0UnNug+ewRE4pE0w7H
=q7+W
-----END PGP SIGNATURE-----

--afr6f1SGcBTWJSX9cwlt8HDNQfmPvF2Vp--


--===============6364485765324715740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6364485765324715740==--
