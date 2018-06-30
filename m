From: Pavel Machek <pavel@ucw.cz>
Subject: v4.18-rc2 on droid4: screen turns red
Date: Sat, 30 Jun 2018 15:18:12 +0200
Message-ID: <20180630131812.GA549@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

After longer inactivity, attempt to wake up the screen results in
screen being completely red. Not too useful. I can still connect over
ssh.

This happens all the time:

Jun 30 11:34:08 devuan kernel: [  143.605499] ------------[ cut here
]------------
Jun 30 11:34:08 devuan kernel: [  143.610168] WARNING: CPU: 1 PID:
2220 at drivers/gpu/drm/omapdrm/
dss/hdmi4.c:667 hdmi_audio_stop+0x5c/0x68
Jun 30 11:34:08 devuan kernel: [  143.619873] Modules linked in:
Jun 30 11:34:08 devuan kernel: [  143.622955] CPU: 1 PID: 2220 Comm:
pulseaudio Not tainted 4.18.0-
rc2-88315-g3452793-dirty #756
Jun 30 11:34:08 devuan kernel: [  143.631591] Hardware name: Generic
OMAP4 (Flattened Device Tree)
Jun 30 11:34:08 devuan kernel: [  143.637634] [<c010f6cc>]
(unwind_backtrace) from [<c010ba50>] (sh
ow_stack+0x10/0x14)
Jun 30 11:34:08 devuan kernel: [  143.645446] [<c010ba50>]
(show_stack) from [<c086d7ec>] (dump_sta
ck+0x8c/0xac)
Jun 30 11:34:08 devuan kernel: [  143.652740] [<c086d7ec>]
(dump_stack) from [<c012d364>] (__warn+0
xe8/0x114)
Jun 30 11:34:08 devuan kernel: [  143.659729] [<c012d364>] (__warn)
=66rom [<c012d3cc>] (warn_slowpath_null+0x3c/0x48)
Jun 30 11:34:08 devuan kernel: [  143.667358] [<c012d3cc>]
(warn_slowpath_null) from [<c047b7dc>] (hdmi_audio_stop+0x5c/0x68)
Jun 30 11:34:08 devuan kernel: [  143.675750] [<c047b7dc>]
(hdmi_audio_stop) from [<c06a9824>] (hdmi_dai_trigger+0x6c/0x88)
Jun 30 11:34:08 devuan kernel: [  143.683990] [<c06a9824>]
(hdmi_dai_trigger) from [<c06990d0>] (soc_pcm_trigger+0xf0/0x130)
Jun 30 11:34:08 devuan kernel: [  143.692291] [<c06990d0>]
(soc_pcm_trigger) from [<c067a9f4>] (snd_pcm_do_stop+0x54/0x58)
Jun 30 11:34:08 devuan kernel: [  143.700439] [<c067a9f4>]
(snd_pcm_do_stop) from [<c067a7a4>] (snd_pcm_action_single+0x38/0x78)
Jun 30 11:34:08 devuan kernel: [  143.709075] [<c067a7a4>]
(snd_pcm_action_single) from [<c067c468>] (snd_pcm_drop+0x48/0x94)
Jun 30 11:34:08 devuan kernel: [  143.717468] [<c067c468>]
(snd_pcm_drop) from [<c067d508>] (snd_pcm_ioctl+0x870/0x1180)
Jun 30 11:34:08 devuan kernel: [  143.725433] [<c067d508>]
(snd_pcm_ioctl) from [<c0215944>] (do_vfs_ioctl+0x80/0x960)
Jun 30 11:34:08 devuan kernel: [  143.733215] [<c0215944>]
(do_vfs_ioctl) from [<c0216280>] (ksys_ioctl+0x5c/0x80)
Jun 30 11:34:08 devuan kernel: [  143.740661] [<c0216280>]
(ksys_ioctl) from [<c0101000>] (ret_fast_syscall+0x0/0x54)
Jun 30 11:34:08 devuan kernel: [  143.748352] Exception
stack(0xeb8fffa8 to 0xeb8ffff0)
Jun 30 11:34:08 devuan kernel: [  143.753448] ffa0:
005129b0 b1971394 00000015 00004143 00000000 00512960


This is probably unrelated:

[13215.125732] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[13245.205535] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[13252.969940] power_supply battery: driver failed to report
`power_now' property: -22
[13275.285369] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[13291.993652] Charging, 4350000 uV, 532000 uA
[13292.001708] Charging, 4350000 uV, 532000 uA
[13305.364837] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[13335.445037] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[13365.524291] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[13372.940093] power_supply battery: driver failed to report
`power_now' property: -22
[13383.554412] g_ether gadget: packet filter 0e
[13383.558715] g_ether gadget: ecm req21.43 v000e i0000 l0
[13383.580261] g_ether gadget: notify connect true
[13383.612243] g_ether gadget: notify speed 425984000
[13387.213256] cpcap_adc cpcap_adc.0: error reading ADC: -110
[13387.218780] cpcap_battery cpcap_battery.0:
cpcap_battery_get_voltage failed: -110
[13387.523254] cpcap_adc cpcap_adc.0: error reading ADC: -110
[13387.528778] cpcap_battery cpcap_battery.0:
cpcap_battery_get_current failed: -110

Ideas welcome.

Best regards,
							Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls3gxQACgkQMOfwapXb+vK7CgCeNh5SaeNEdkxhV1WH7N+wtbgA
kWoAni7rHnqSJHeSTFg0HkQ2RHWz3Eu3
=jq3O
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
