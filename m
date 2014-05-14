From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
Date: Wed, 14 May 2014 09:41:26 +0300
Message-ID: <53731016.8020103@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-2-git-send-email-tony@atomide.com> <536C860E.1000501@ti.com> <20140509143703.GA17814@atomide.com> <5370B222.7050702@ti.com> <20140512143934.GC31772@atomide.com> <5370DE42.2060607@ti.com> <20140513152626.GB16837@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="o4rrmRDoDogx8XTQ1MwgADa2j0BLfKlan"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33567 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbaENGlx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 May 2014 02:41:53 -0400
In-Reply-To: <20140513152626.GB16837@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--o4rrmRDoDogx8XTQ1MwgADa2j0BLfKlan
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/05/14 18:26, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 07:45]:
>> On 12/05/14 17:39, Tony Lindgren wrote:
>>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 04:36]:
>>>> On 09/05/14 17:37, Tony Lindgren wrote:
>>>>>
>>>>> This is just the 3730-evm with the Sharp VGA panel mentioned in
>>>>> this series.
>>>>
>>>> Hmm, well, those both look fine. The fck is well below the maximum,
>>>> which is somewhere around 170MHz-180MHz. The lck/pck ratio is higher=

>>>> with this patch, but that should affect the GFX overlay.
>>>>
>>>> So you're just booting, and there are no applications that use the
>>>> framebuffer? And there is no rotation or such configured?
>>>
>>> Right. The rotation is set to 3 though.
>>
>> Hmm, that's probably the issue then. VRFB rotation is very heavy on th=
e
>> memory bandwidth, and is generally a very easy way to get sync lost er=
rors.
>=20
> I found another case without rotation where the error always triggers.
> By forcing 3730-evm LCD panel to QVGA mode it always seems to happen
> even without rotation.
>=20
> Without this patch with errors and no image:
>=20
> # cat /sys/kernel/debug/omapdss/clk=20
> [   55.185729] DSS: dss_runtime_get
> [   55.189422] DSS: dss_runtime_put
> [   55.192810] DISPC: dispc_runtime_get
> [   55.196685] DISPC: dispc_runtime_put
> - DSS -
> DSS_FCK (DSS1_ALWON_FCLK) =3D 27000000
> - DISPC -
> dispc fclk source =3D DSS_FCK (DSS1_ALWON_FCLK)
> fck             27000000       =20
> - LCD -
> LCD clk source =3D DSS_FCK (DSS1_ALWON_FCLK)
> lck             27000000        lck div 1
> pck             5400000         pck div 5
>=20
> With this patch without errors and penguin showing:
>=20
> # cat /sys/kernel/debug/omapdss/clk
> [   19.905792] DSS: dss_runtime_get
> [   19.909545] DSS: dss_runtime_put
> [   19.912933] DISPC: dispc_runtime_get
> [   19.916778] DISPC: dispc_runtime_put
> - DSS -
> DSS_FCK (DSS1_ALWON_FCLK) =3D 108000000
> - DISPC -
> dispc fclk source =3D DSS_FCK (DSS1_ALWON_FCLK)
> fck             108000000      =20
> - LCD -
> LCD clk source =3D DSS_FCK (DSS1_ALWON_FCLK)
> lck             108000000       lck div 1
> pck             5400000         pck div 20
>=20
> In this case the errors are different too:
>=20
> DISPC: channel 0 xres 240 yres 320
> DISPC: pck 5400000
> DISPC: hsw 3 hfp 3 hbp 39 vsw 1 vfp 2 vbp 7
> DISPC: vsync_level 1 hsync_level 1 data_pclk_edge 1 de_level 0 sync_pcl=
k_edge 0
> DISPC: hsync 18947Hz, vsync 57Hz
> DISPC: lck =3D 27000000 (1)
> DISPC: pck =3D 5400000 (5)
> APPLY: DISPC IRQ: 0x60: GFX_FIFO_UNDERFLOW=20
> APPLY: DISPC IRQ: 0x4062: GFX_FIFO_UNDERFLOW SYNC_LOST=20
> DISPC: dispc_runtime_get
> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay

I'm quite out of ideas... The pixel clock is so low that underflow
shouldn't really happen. I was trying to find 3730 documentation that
would describe the PRCM's multipliers and dividers for DSS (i.e. the
ones you change in this patch), but I didn't find anything.

Maybe the DSS clock's fixed multiplier has been changed for 3730. But in
that case our .dts files related to the clocks are wrong too. The clock
nodes related to this are dpll4_m4x2_mul_ck, which is corresponds to the
"dss_fck_multiplier" value in omapdss, and dpll4_m4_ck, which
corresponds to the "fck_div_max" value.

One thing to try out is, without this patch, change
CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK to force the dss func clock higher.
With QVGA mode, you could try, say, value of 19, which should make sure
the fck is at least 19 times higher than pck.

> Regarding rotation, it does look like that with VGA mode enabling
> rotation makes the error trigger quite often on 3730.
> =20
>> will handle it fine with the clock rates and bandwidth usage you have
>> for your use cases.
>=20
> I don't think it's all because of rotation. And rotating my head

No, probably not. The pixel clocks are so low that the rotation should
work fine. Except if there's something wrong the the VRFB or the memory
bus, which make the VRFB rotation not work even with low pixel clocks.

> makes my neck hurt!

You need to learn to hold the device a bit differently!

 Tomi



--o4rrmRDoDogx8XTQ1MwgADa2j0BLfKlan
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcxAWAAoJEPo9qoy8lh71wikQAKeAseU9vrnBHAXNn3aNLT0R
nT/+PSiXWFTjLooYDEESTm0bRUi+Aj168d8Cz/J028a6NEhsxNFsR1XG7PpIs9c8
DXWGjy9GTTRGrjCi/DEjuqOWQVmEdWvzZCeUkB97azDMb0PVze7fAztUwNiaF2Lk
RFxQahwEs7dMSwBryDCOKHrflWac8myuwlY8QeV0Wlu5FIg1KvqF0+cHPdUzdX4e
4ZKeqY9opLsbC9I15fMbS2v2/gCvYqYsfd7SbvWqsDGuWxfe3iqs3RGMHOHQgsJw
KHBFih4cW/fdCbOMM2avDzFQoFdn5cvDrmTdEfE6gI9a+01Zw7UswCzi8JQ5ubKy
g+iZ/pJxnup+iTn3kO2X9lkVowxXcidP/72+yDNatP2/3V2VYG3b76YZ/Ge0Ct23
Yfn44a7B+DqZrztAKTnr+sq877HamlUr6pjdblHiNkasC7tQyRMUqh9ibTV/sioZ
ag/V8pFlSRxQeYRX/PTIcvCIf0McFImKPs7r3XjDx+6PCFlXETb/mEeYQFIWRYOR
+0CiG+NntNGxyHTma+yU/VQP6tRBGI2oGdCG3moaXrE94JFi22ryYNidgmgED0ub
cn7MLdbBzKMgmM4pRu+Y2DreXfA3KzWIVCa/gSz7tRTX74f7XcaQred1GoJ+VkVQ
Msm1+4jvU5m8H19M1oJQ
=hMuw
-----END PGP SIGNATURE-----

--o4rrmRDoDogx8XTQ1MwgADa2j0BLfKlan--
