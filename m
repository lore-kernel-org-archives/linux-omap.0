From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4430 produces boot warnings
Date: Thu, 22 Nov 2012 16:44:43 +0200
Message-ID: <50AE3A5B.5040603@ti.com>
References: <20121121230337.GR3332@n2100.arm.linux.org.uk>
 <50AE1DC0.3030002@ti.com> <50AE2BB6.8080406@ti.com>
 <1353594842.786.45.camel@sokoban>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4581833754378391721=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1353594842.786.45.camel@sokoban>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: t-kristo@ti.com
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Archit Taneja <archit@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============4581833754378391721==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3ED54A86705DEE5D24D6DBED"

--------------enig3ED54A86705DEE5D24D6DBED
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-11-22 16:34, Tero Kristo wrote:

> I guess you checked that DSS pwrdm is switching between RET and ON in
> your setup?

Yes:

# cat /debug/pm_debug/count |grep dss
[   35.356567] pwrdm state mismatch(l3init_pwrdm) 3 !=3D 1
[   35.361938] pwrdm state mismatch(cam_pwrdm) 3 !=3D 0
[   35.366973] pwrdm state mismatch(ivahd_pwrdm) 3 !=3D 1
[   35.372253] pwrdm state mismatch(tesla_pwrdm) 3 !=3D 1
[   35.377532] pwrdm state mismatch(abe_pwrdm) 3 !=3D 1
dss_pwrdm (RET),OFF:1,RET:11,INA:0,ON:11,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
l3_dss_clkdm->dss_pwrdm (0)

then I load and unload the dss modules, and then:

# cat /debug/pm_debug/count |grep dss
[   60.813629] pwrdm state mismatch(l3init_pwrdm) 3 !=3D 1
[   60.819000] pwrdm state mismatch(cam_pwrdm) 3 !=3D 0
[   60.824127] pwrdm state mismatch(ivahd_pwrdm) 3 !=3D 1
[   60.829376] pwrdm state mismatch(tesla_pwrdm) 3 !=3D 1
[   60.834625] pwrdm state mismatch(abe_pwrdm) 3 !=3D 1
dss_pwrdm (ON),OFF:1,RET:21,INA:0,ON:22,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:=
0
l3_dss_clkdm->dss_pwrdm (0)

>> Does the pwrdm mistakenly think that in RET state the DSS still keeps
>> the register contents?
>=20
> This might be the case, however the pwrdm code should be generic and
> handle all domains properly. What is the tree / branch / commit you are=

> using for testing this stuff? I can take a look at this also.

arm-soc/for-next

 Tomi



--------------enig3ED54A86705DEE5D24D6DBED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQrjpbAAoJEPo9qoy8lh715h0QAIQSj4SOihQJFySEDK0kwYQf
l4/qbbMTUOvlcfGmBDAsJLh+0+Vcp2SvCgGDIKdIU1DnofKGZ6A1axmxzKKuAj3f
/hPbhudaQ+tp2t4YXcnBCppvhIEtZZxEj4mRaTqebNioE+kzpwNu0kOv7lEz+ClM
5/e0L5xVyMbYrCDpdFkw8yJ382gRtG3LhteUcLqEtJERGhMDHUu+xAHO7ETJWiYI
eFMngX9l18zQY5O5f5uohoSo/hQINixkoEF1cmH7bwsx8jbdqewbCEFUjjIzjvIv
M75S/UfTLpy6dVVObJchSQsSLPrXPgkg1TJjYcK4e8kniMX+kfBX/WPkYS4l/Thf
Nn/6v5u1xPmWoOQIrAGvTTbGX/DO/gip9+MQIuAPUndohftzsJant24Lv4XO+USa
yIDIXD5wq6nl9qgLA8HAStLPQ3mgir7HGLn8sB/xz1W98X9eiPIaUaCh31OkeK7k
Zo+tgq/C2Gc0OxGAShVm1rVO0UpwhDpxntZP439KFnO+kUWpGEOUL2hHgYPjtLyW
GkLGLA55ggTA6ievwrgf4t9uG/DTZ6fj7HzezLk8dnFq64nhrtzHiioLeUC0M3Wt
YpQHLa5ZKd+G5aj5zshnk+eSDFoivfJS1TcrHuqssJH50eg8j2oMrWgDJX+IZ0IT
GuzRQTOxO3c6IZZd1o41
=SSol
-----END PGP SIGNATURE-----

--------------enig3ED54A86705DEE5D24D6DBED--


--===============4581833754378391721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4581833754378391721==--
