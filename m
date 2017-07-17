From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv2 0/6] Motorola Droid 4 Audio Support
Date: Mon, 17 Jul 2017 12:12:58 +0200
Message-ID: <20170717101258.llyly7kwfnwtoftr@earth>
References: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
 <20170717092904.GG10026@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7721364405840618863=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170717092904.GG10026@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org


--===============7721364405840618863==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mc2oyjl5s67xweu2"
Content-Disposition: inline


--mc2oyjl5s67xweu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 17, 2017 at 02:29:04AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170712 08:19]:
> >  * Switch from simple-audio-card to audio-graph-card
>=20
> Gave this a quick try against v4.13-rc1 with SND_AUDIO_GRAPH_CARD
> enabled as a loadable module. However loading it oopses for me,
> see below. Maybe some dependencies are missing?

It works for me on top of v4.13-rc1 (my kernel is monolithic).
Looking at the stacktrace it seems to be a bug in audio graph
card and not in the codec driver.

-- Sebastian

> 8< --------------------
> BUG: sleeping function called from invalid context at kernel/locking/mute=
x.c:747
> in_atomic(): 1, irqs_disabled(): 128, pid: 1590, name: modprobe
> INFO: lockdep is turned off.
> irq event stamp: 0
> hardirqs last  enabled at (0): [<  (null)>]   (null)
> hardirqs last disabled at (0): [<c0137464>] copy_process.part.5+0x2c4/0x1=
ac8
> softirqs last  enabled at (0): [<c0137464>] copy_process.part.5+0x2c4/0x1=
ac8
> softirqs last disabled at (0): [<  (null)>]   (null)
> CPU: 0 PID: 1590 Comm: modprobe Tainted: G        W       4.13.0-rc1+ #126
> Hardware name: Generic OMAP4 (Flattened Device Tree)
> [<c0111524>] (unwind_backtrace) from [<c010d1fc>] (show_stack+0x10/0x14)
> [<c010d1fc>] (show_stack) from [<c086375c>] (dump_stack+0xac/0xe0)
> [<c086375c>] (dump_stack) from [<c0168c2c>] (___might_sleep+0x228/0x2ac)
> [<c0168c2c>] (___might_sleep) from [<c087a86c>] (__mutex_lock+0x28/0x9fc)
> [<c087a86c>] (__mutex_lock) from [<c087b25c>] (mutex_lock_nested+0x1c/0x2=
4)
> [<c087b25c>] (mutex_lock_nested) from [<c03532fc>] (kernfs_remove+0x18/0x=
30)
> [<c03532fc>] (kernfs_remove) from [<c0867abc>] (kobject_del+0x14/0x44)
> [<c0867abc>] (kobject_del) from [<c0867948>] (kobject_put+0x114/0x224)
> [<c0867948>] (kobject_put) from [<c06c8e74>] (of_get_next_parent+0x2c/0x4=
c)
> [<c06c8e74>] (of_get_next_parent) from [<c06ccd24>] (of_graph_get_port_pa=
rent+0x10/0x70)
> [<c06ccd24>] (of_graph_get_port_parent) from [<bf4685e8>] (asoc_simple_ca=
rd_parse_graph_dai+0x98/0xe0 [snd_soc_simple_card_utils])
> [<bf4685e8>] (asoc_simple_card_parse_graph_dai [snd_soc_simple_card_utils=
]) from [<bf8e5330>] (asoc_graph_card_probe+0x200/0x444 [snd_soc_audio_grap=
h_card])
> [<bf8e5330>] (asoc_graph_card_probe [snd_soc_audio_graph_card]) from [<c0=
5aa2b8>] (platform_drv_probe+0x50/0xb0)
> [<c05aa2b8>] (platform_drv_probe) from [<c05a8088>] (driver_probe_device+=
0x33c/0x478)
> [<c05a8088>] (driver_probe_device) from [<c05a82ac>] (__driver_attach+0xe=
8/0x110)
> [<c05a82ac>] (__driver_attach) from [<c05a61c8>] (bus_for_each_dev+0x6c/0=
xa0)
> [<c05a61c8>] (bus_for_each_dev) from [<c05a7354>] (bus_add_driver+0x198/0=
x270)
> [<c05a7354>] (bus_add_driver) from [<c05a92c8>] (driver_register+0x78/0xf=
4)
> [<c05a92c8>] (driver_register) from [<c010189c>] (do_one_initcall+0x3c/0x=
170)
> [<c010189c>] (do_one_initcall) from [<c01edc24>] (do_init_module+0x5c/0x1=
e0)
> [<c01edc24>] (do_init_module) from [<c01ec904>] (load_module+0x1270/0x14e=
c)
> [<c01ec904>] (load_module) from [<c01ece08>] (SyS_finit_module+0xa8/0xec)
> [<c01ece08>] (SyS_finit_module) from [<c0108440>] (ret_fast_syscall+0x0/0=
x1c)
> OF: ERROR: Bad of_node_put() on /ocp/spi@48098000/pmic@0/audio-codec/port=
@0/endpoint

--mc2oyjl5s67xweu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllsjacACgkQ2O7X88g7
+prvCg//fZUbCSIXBJx1isxVl1jiQ6Y+VpuMwFtyCeuJTxY3iVlioRSVeJelkF3d
TkEr6RgV9wMeH967lDgcYLSECYpWu9otWBLbogqWrdvjmDnDWJaiqnWTY5fjdwKP
OMk0THL4m9X3hOvPTdPUkxPEC5V+IsdsQj5mdcdTyubD1WEWi6O+IJOPEA1RvGtd
CAGiGOZ8gdwRp+02lm/JxZAdtajslpx/7zaxIUb7lxvYXsnHCtz1Vjqy7/3U1npO
S5ukL/MmsFzbb9vrjTBbYIaK8SHeATzWMpcm6Amh8xFNjvglYqgYjVeZxHgdc4kP
eZf72n2+9Vv9gZvpBv+3uj28Vs00eVRzf8PzSnzlmxg8udfI837YlmxirH2IPcRv
kVfNCQs62aP148CvLIO9R21KD+QBMTBPoROPTDMaTKy1LPCFGkOFPp9l+OUWx0It
SYsoJsvZosyPimtcgkbK6dkqZV5f1Mq80mPLo5m/sADXxhxaSeBM/86fEWMH1kkn
sCC2ssyeLPb5C6892dTC3mPd2brvXZaMtJ+/CIFen2yRWLgMeo9Y7OjQ5Ph+J+yx
gixlXY0HAgCasvckHcCv1TC3ltOUK0fVIZxemQGPuKDj74gnQYxFI1j0FQUlzbxX
Zf6JWG/m0GSK2S9m0YteUqdUSGslP239N9c9LeEPJ6BY6ZBpXhM=
=TOkW
-----END PGP SIGNATURE-----

--mc2oyjl5s67xweu2--

--===============7721364405840618863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7721364405840618863==--
