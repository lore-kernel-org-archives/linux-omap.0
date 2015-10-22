From: Felipe Balbi <balbi@ti.com>
Subject: NULL pointer deref when reloading snd_soc_simple_card
Date: Thu, 22 Oct 2015 14:10:32 -0500
Message-ID: <87vb9yen2v.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3188026585191203033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============3188026585191203033==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

I just triggered a NULL point deref with the following commands running
on AM437x SK board. This is with v4.3-rc6:

modprobe -r snd_soc_simple_card
sleep 1
modprobe snd_soc_simple_card
sleep 1

details below:

[  228.020921] Unable to handle kernel NULL pointer dereference at virtual =
address 000000f8
[  228.029546] pgd =3D ed4bc000
[  228.032375] [000000f8] *pgd=3D00000000
[  228.036154] Internal error: Oops: 5 [#1] SMP ARM
[  228.040968] Modules linked in: snd_soc_simple_card(+) matrix_keypad matr=
ix_keymap pwm_bl xhci_plat_hcd xhci_hcd usbcore joydev m25p80 spi_nor lis3l=
v02d_i2c lis3lv02d input_polldev cpufreq_dt thermal_sys hwmon dwc3_omap ext=
con tps65218_pwrbutton omap_wdt spi_ti_qspi evdev rtc_omap leds_gpio led_cl=
ass dwc3 udc_core usb_common omapfb cfbfillrect cfbimgblt cfbcopyarea panel=
_dpi snd_soc_tlv320aic3x snd_soc_davinci_mcasp snd_soc_edma snd_soc_omap sn=
d_soc_core omapdss snd_compress snd_pcm_dmaengine snd_pcm pwm_tiecap snd_ti=
mer snd soundcore phy_omap_usb2 autofs4 [last unloaded: snd_soc_simple_card]
[  228.096008] CPU: 0 PID: 710 Comm: modprobe Not tainted 4.3.0-rc6-00001-g=
ada6475ae6e4 #97
[  228.104436] Hardware name: Generic AM43 (Flattened Device Tree)
[  228.110608] task: ed4b9140 ti: ed52e000 task.ti: ed52e000
[  228.116370] PC is at dapm_wcache_lookup+0x50/0x7c [snd_soc_core]
[  228.122664] LR is at dapm_wcache_lookup+0x38/0x7c [snd_soc_core]
[  228.128922] pc : [<bf16dd2c>]    lr : [<bf16dd14>]    psr: a0070013
[  228.128922] sp : ed52fba8  ip : 00000005  fp : 00000000
[  228.140883] r10: bf17d238  r9 : bf1f138c  r8 : bf1f616c
[  228.146327] r7 : bf1f138c  r6 : bf1f616c  r5 : ee6f5158  r4 : 000000f4
[  228.153126] r3 : 00000100  r2 : 00000052  r1 : ed1057c1  r0 : ffffffff
[  228.159925] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
[  228.167354] Control: 10c5387d  Table: ad4bc059  DAC: 00000051
[  228.173339] Process modprobe (pid: 710, stack limit =3D 0xed52e218)
[  228.179689] Stack: (0xed52fba8 to 0xed530000)
[  228.184233] fba0:                   00000000 ee7c58c0 bf1f6050 bf16f244 =
00000000 ed52fc28
[  228.192765] fbc0: ee577800 c1014a44 00000000 c06430d8 00000001 00000000 =
ee6c6e90 ee6f50a0
[  228.201294] fbe0: 00000000 00000000 00000000 c09c3354 60070013 c00943bc =
ed4b9700 00000004
[  228.209835] fc00: 00000004 ed4b9140 00000006 bf1f138c bf1ef834 c0091884 =
c063f37c ed4b9140
[  228.218365] fc20: 00000001 c118a28c ed4b9140 c00919e8 ee6f506c 60070013 =
ee6f5070 c063f37c
[  228.226899] fc40: 00000001 00000000 bf16f430 00000003 00000004 ed4b9140 =
00000006 00000000
[  228.235417] fc60: bf1ef834 c0091884 c0641060 bf1f138c 00000000 ee7c58c0 =
00000004 0000001b
[  228.243938] fc80: bf1f138c bf17d238 00000000 bf16f468 00000000 00000012 =
ee7c58c0 ee7c58c0
[  228.252463] fca0: ee6c6e90 ee6c6e90 00000004 ee6c6ec0 00000000 bf1ef834 =
00000000 bf1efcec
[  228.260989] fcc0: ee7c5828 00000000 ee7c5810 ee6f5010 ee7c58c0 ee7c5858 =
ed496010 bf169ef4
[  228.269506] fce0: ee6f5180 00000002 00000634 ee6f5010 00000000 00000000 =
00000000 00000000
[  228.278029] fd00: ed440e0c bf16cb2c 00000000 ee6f5020 ee6f5180 bf17fd60 =
00000001 ee6f5028
[  228.286547] fd20: ee6f5168 60070013 00000000 00000000 eeee3304 00000000 =
ee178410 ee6f5010
[  228.295065] fd40: ed105c90 ee6f5010 ee178410 ee178410 ee178400 00000001 =
12f9f228 bf17968c
[  228.303583] fd60: ee6f5010 fffffdfb 00000001 eeee87d8 ee178410 bf0faa38 =
00000000 ee178410
[  228.312108] fd80: ee178410 ee178410 ee178410 bf0fb28c fffffdfb 0000004e =
ed060e00 c03dff28
[  228.320626] fda0: ee178410 c11be018 bf0fb28c 00000000 0000004e c03de5dc =
ee178410 bf0fb28c
[  228.329143] fdc0: ee178444 c098df20 00000000 c03de76c 00000000 bf0fb28c =
c03de6d8 c03dca40
[  228.337666] fde0: ee0362a4 ee179f10 bf0fb28c ed462ec0 00000000 c03ddba4 =
bf0fb080 c09123a0
[  228.346188] fe00: ed060d40 bf0fb28c c09123a0 ed060d40 bf0fd000 c03defb0 =
c09123a0 c09123a0
[  228.354713] fe20: ed060d40 c0009804 60070093 00000000 00000000 00000000 =
0000000f 00000000
[  228.363240] fe40: ef7c4464 40000000 0000002e c0091ccc ed060e40 000000d0 =
000000d0 c0162850
[  228.371760] fe60: ed52ff58 c0091ccc c090e108 ee0000c0 a0070013 bf0fb300 =
bf0fb300 c09c34a8
[  228.380285] fe80: ed060e40 bf0fb300 bf0fb348 00000001 12f9f228 c011b55c =
ed060e08 bf0fb300
[  228.388815] fea0: ed52ff58 c09c34a8 ed060e08 c00cc6cc bf0fb30c 00007fff =
00000000 c00c9e60
[  228.397340] fec0: c119bfa4 bf0fb458 c090e990 bf0fb51c f07fa7bc bf0fb30c =
00000000 c064c2c0
[  228.405863] fee0: f07cd000 0002d80c 02e60649 00000000 0000000f 00000000 =
00000000 00000000
[  228.414388] ff00: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[  228.422911] ff20: 00000000 00000000 00000000 00000000 00000170 00000000 =
00000003 7f606ddc
[  228.431432] ff40: 0000017b c000f8e4 ed52e000 00000000 7f61a2e8 c00ccf24 =
f07cd000 0002d80c
[  228.439952] ff60: f07fa0dc f07eebe5 f07ef600 00001690 000019d0 00000000 =
00000000 00000000
[  228.448475] ff80: 0000002c 0000002d 00000014 00000018 0000000f 00000000 =
7f607a28 00000000
[  228.457000] ffa0: 1c7d6500 c000f740 7f607a28 00000000 00000003 7f606ddc =
00000000 7f607d10
[  228.465523] ffc0: 7f607a28 00000000 1c7d6500 0000017b 00040000 00000000 =
00000000 7f61a2e8
[  228.474050] ffe0: bed179b0 bed179a0 7f5fd4bb b6f18852 80070030 00000003 =
185b0001 05000135
[  228.482659] [<bf16dd2c>] (dapm_wcache_lookup [snd_soc_core]) from [<bf16=
f244>] (snd_soc_dapm_add_route+0x74/0x23c [snd_soc_core])
[  228.494875] [<bf16f244>] (snd_soc_dapm_add_route [snd_soc_core]) from [<=
bf16f468>] (snd_soc_dapm_add_routes+0x5c/0xbc [snd_soc_core])
[  228.507428] [<bf16f468>] (snd_soc_dapm_add_routes [snd_soc_core]) from [=
<bf1efcec>] (aic3x_probe+0x41c/0x57c [snd_soc_tlv320aic3x])
[  228.519797] [<bf1efcec>] (aic3x_probe [snd_soc_tlv320aic3x]) from [<bf16=
9ef4>] (soc_probe_component+0x208/0x348 [snd_soc_core])
[  228.531812] [<bf169ef4>] (soc_probe_component [snd_soc_core]) from [<bf1=
6cb2c>] (snd_soc_register_card+0x8d8/0x10f4 [snd_soc_core])
[  228.544204] [<bf16cb2c>] (snd_soc_register_card [snd_soc_core]) from [<b=
f17968c>] (devm_snd_soc_register_card+0x2c/0x68 [snd_soc_core])
[  228.556948] [<bf17968c>] (devm_snd_soc_register_card [snd_soc_core]) fro=
m [<bf0faa38>] (asoc_simple_card_probe+0x1f4/0x434 [snd_soc_simple_card])
[  228.570587] [<bf0faa38>] (asoc_simple_card_probe [snd_soc_simple_card]) =
from [<c03dff28>] (platform_drv_probe+0x44/0xac)
[  228.581921] [<c03dff28>] (platform_drv_probe) from [<c03de5dc>] (driver_=
probe_device+0x1f4/0x2f0)
[  228.591170] [<c03de5dc>] (driver_probe_device) from [<c03de76c>] (__driv=
er_attach+0x94/0x98)
[  228.599962] [<c03de76c>] (__driver_attach) from [<c03dca40>] (bus_for_ea=
ch_dev+0x6c/0xa0)
[  228.608485] [<c03dca40>] (bus_for_each_dev) from [<c03ddba4>] (bus_add_d=
river+0x18c/0x214)
[  228.617100] [<c03ddba4>] (bus_add_driver) from [<c03defb0>] (driver_regi=
ster+0x78/0xf8)
[  228.625451] [<c03defb0>] (driver_register) from [<c0009804>] (do_one_ini=
tcall+0x80/0x1dc)
[  228.633985] [<c0009804>] (do_one_initcall) from [<c011b55c>] (do_init_mo=
dule+0x5c/0x1d0)
[  228.642421] [<c011b55c>] (do_init_module) from [<c00cc6cc>] (load_module=
+0x1a4c/0x20c0)
[  228.650769] [<c00cc6cc>] (load_module) from [<c00ccf24>] (SyS_finit_modu=
le+0x7c/0x90)
[  228.658936] [<c00ccf24>] (SyS_finit_module) from [<c000f740>] (ret_fast_=
syscall+0x0/0x1c)
[  228.667457] Code: e594300c e1550003 e243400c 0a000006 (e5131008)=20
[  228.673935] ---[ end trace d70ffb1b3028bdb3 ]---

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKTSpAAoJEIaOsuA1yqRElHEQAIGdxLq2QcCLXco1KtPIT5KD
eMny2sEyQZ9Cxu68icVwzbI0iTs7tQOIenyfraD8jSkO+CpPh77vq9L9isSeNB6z
B8x91cHH1X8+5U2GkTBahGhpcFcdAULl4xxr8RC4vyfBS6Ls2ZPra+YeWuUw8UJg
xigI9v6CbSm1GPgLDj7FHIw4Lg6/oUHTFFlhECkhlFWbj6iPPCAFLFa5hmcyE7gw
mbeYWCo+6q6jjHVJI6yHEjg1uWAAuxaGdCliiTk0M055q8sJ8LcO6MnCGbvLaFGc
vfPkrRZ8piqdHX0JGPxwbRqKhaDNvxGBZWkeQiOldyktvdOwDsApovg9S/ErKVCF
9nJx/ICAxdbk9JkO50y+eCWXZDzrSFUxguIjCPUOb8CmG4AhTMVA4VEfTL0K9HAx
dJa0iJgofsOitrvvU3zyKWV1FPwd6oEm/xcsPMuqa0b9RFQOLHDQbL/SCaUsAXdN
XdHhnsuCrbSfo5P/eQEx7DmV7iASGtiXTd9TfIoZl9Gu/abJxhRxGfgTDNI7d/aP
VNr2AVqeUo25X3D0uh7z+ydBTBYmMCUnLV0npkZ1QNRCxhchVRCcw4WdusY8yPki
C6eppjw0LqXRS+RO0Z97qti/c7mD1J2NHq4SBn4AX+ZGwxYRiiTE7Ai0oG1GcrIJ
tBjptNQFz1686Uxtpppw
=oQmx
-----END PGP SIGNATURE-----
--=-=-=--

--===============3188026585191203033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3188026585191203033==--
