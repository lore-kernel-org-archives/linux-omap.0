From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 13/15] OMAPDSS: DSS: remove legacy dss bus support
Date: Fri, 30 Aug 2013 08:52:12 +0300
Message-ID: <5220330C.9010704@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com> <1377783120-14001-14-git-send-email-tomi.valkeinen@ti.com> <521F5B80.6080802@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="71s05K2FIuRonFsIX8nX8uA1oCHGnw5PW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51974 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577Ab3H3FwR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Aug 2013 01:52:17 -0400
In-Reply-To: <521F5B80.6080802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--71s05K2FIuRonFsIX8nX8uA1oCHGnw5PW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 29/08/13 17:32, Archit Taneja wrote:
> On Thursday 29 August 2013 07:01 PM, Tomi Valkeinen wrote:
>> With all the old panels removed and all the old panel model APIs remov=
ed
>> from the DSS encoders, we can now remove the custom omapdss-bus which
>> was used in the old panel model.
>>

>>   static void __exit omap_dss_exit(void)
>>   {
>>       omap_dss_unregister_drivers();
>> -
>> -    omap_dss_bus_unregister();
>>   }
>>
>>   module_init(omap_dss_init);
>>   module_exit(omap_dss_exit);
>=20
> minor comment here, we could use
> omap_dss_register_driver/unregister_driver for the module_init/exit
> directly, the funcs omap_dss_init/ext don't seem to be doing much here.=


Yes, that's true. I'll clean it up.

 Tomi



--71s05K2FIuRonFsIX8nX8uA1oCHGnw5PW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIDMOAAoJEPo9qoy8lh71S0gQAJh2wZDCyhYdDggDYeWEM0yP
ZTTCsMjX61fnirq24snaN5vV+G5jxMmbuuk9GMP95zqtELPfg3LO/b9thJ9HQkM9
hymFyWkuZXVE2XdDgp0avLrVfdiNjtK1M3HcastnxmCgha8aLBJZNumJMj1XAvtM
ZAX49ked5TZkcS97Fpa1UcVAZEV6ZeIfmnAVWX2iP3uompRNZtInUwOCD44DlIj3
YM5kO0Cm4k5gcIdN2IVjKpKY+2RXvBueLOwstE9g6H7wSWsEMs2GUGKK2S6jbbhv
kJJygZSzGTRfnFV1IwYkubLgmRlsuQqvjYYfw1FyMkY82Cjn4+wPPuddxMMX1P2r
0vCkgajR0BnMOpiFZtB2jRqshK/XTIPp8yFHNB8S736ROBEfPOFsZinjCG4r83RS
zARdXpDB3esay2rOmFZ9uKMI3HtCrtDQ3LxH/mIPneu8sYqLUybhmdjLPToPcTDN
7jtpr/WrhgNM9kb5USLzutd/uL5TotnHCV5lsS2+HllFcYHiaFkF1d0LAPry3ZVu
lBjigGZdj8/bjT37w5qz9JKHkrOUXsXoGfhna/GCR7ugQ5AXU+eKDep0yD+CEwk3
0MT8Jysvw9rDWzppj3/8De4Mgl28cut1OEyVQP6N6eDWzGU3/kY5tmhWq8nmjW0D
zfbT8RJIPAhGLAyzo99k
=KMqH
-----END PGP SIGNATURE-----

--71s05K2FIuRonFsIX8nX8uA1oCHGnw5PW--
