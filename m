From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
Date: Fri, 2 Mar 2018 17:47:52 +0100
Message-ID: <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
 <20180302152712.GA22262@uda0271908>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="czKtVf7VtiN2ETNudbl7RgFrMq5PxKP82"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180302152712.GA22262@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--czKtVf7VtiN2ETNudbl7RgFrMq5PxKP82
Content-Type: multipart/mixed; boundary="YGYerZQA0vuWlSrKlrrQiatlbXLjkm5y5";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
Message-ID: <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
 <20180302152712.GA22262@uda0271908>
In-Reply-To: <20180302152712.GA22262@uda0271908>

--YGYerZQA0vuWlSrKlrrQiatlbXLjkm5y5
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 02/03/18 16:27, Bin Liu wrote:
> Hi,
>=20
> On Fri, Mar 02, 2018 at 12:47:07AM +0100, Merlijn Wajer wrote:
>> Hi,
>>
>> I found that the "mode" file in musb sys node will return "(null)" whe=
n
>> one would expect it show b_idle.
>>
>> Wrong /mode file:
>>
>> [Fresh boot, cable not connected yet]
>> root@n900devuan:~# modprobe g_nokia
>> [Insert cable connected to PC]
>> root@n900devuan:~# cat
>> /sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.aut=
o/mode
>> b_peripheral
>> [Remove cable connected to PC]
>> root@n900devuan:~# cat
>> /sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.aut=
o/mode
>> b_idle
>> root@n900devuan:~# rmmod g_nokia
>> root@n900devuan:~# cat
>> /sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.aut=
o/mode
>> (null)
>=20
> I can reproduce this on AM335x EVM,

>> [Insert cable connected to PC]
>> root@n900devuan:~# cat
>> /sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.aut=
o/mode
>> b_idle
>=20
> but not this, I still get (null). g_nokia is not loaded here, right?

I don't think so:

# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_peripheral
[unplug]
# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_idle
# rmmod g_nokia
# lsmod|grep nokia
nokia_modem            16384  0
ssi_protocol           20480  2 nokia_modem,cmt_speech
hsi                    20480  5
hsi_char,omap_ssi,nokia_modem,cmt_speech,ssi_protocol
# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
(null)

=2E.. libcomposite is loaded, but nothing is in configfs (apart from the
empty usb_gadget):

root@n900devuan:~# zgrep COMPOSITE /proc/config.gz
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_USB_LIBCOMPOSITE=3Dm
CONFIG_USB_CDC_COMPOSITE=3Dm
root@n900devuan:~# ls /sys/kernel/config/
usb_gadget
root@n900devuan:~# ls /sys/kernel/config/usb_gadget/

Do you have USB_LIBCOMPOSITE and USB_CONFIGFS enabled as module?

I tried to unload libcomposite and the usb_f_* modules:

# rmmod libcomposite
rmmod: ERROR: Module libcomposite is in use by: usb_f_ecm usb_f_phonet
usb_f_acm usb_f_mass_storage usb_f_obex
# rmmod usb_f_ecm usb_f_phonet usb_f_acm usb_f_mass_storage usb_f_obex
# rmmod libcomposite
# lsmod|grep libcom

Yet it now states this: (No change made in cable, was disconnected)

# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_peripheral

And the mode doesn't change any more, even when I connect the cable.

Then, when I probe libcomposite and g_nokia again (in this order) the
mode changes to b_idle, with the cable plugged in. It doesn't change
when I plug the phone in again. When I remove g_nokia again, remove the
cable, modprobe it again, and connect the cable, it seems to work again
as expected and I can see some gadget.

I do not see any errors messages from the kernel.

Finally, when I issued 'rmmod g_nokia', the device hung and rebooted agai=
n.

>> I would expect it to state "b_idle" instead of "(null)".
>=20
> Actually, I'd like to see (null) whenever a gadget driver is not loaded=
,
> which indicates a gadget is not bound to the udc.

Hm... Sounds fine to me. I'm using this mode in combination with the usb
phy (vbus property) to detect if the phone is detect to a 'dumb' charger
of a PC, but I can just always have a gadget loaded -- same as before,
really.

Cheers,
Merlijn


--YGYerZQA0vuWlSrKlrrQiatlbXLjkm5y5--

--czKtVf7VtiN2ETNudbl7RgFrMq5PxKP82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWpmAOQAKCRAGN09rynK8
WkrgAQDim6zwWYPYPTLgIBKGprQMAnsf4ja6Yu6bbka+gSg4rwEA7ns7Kpg2CBXf
AeMU+QQWGtOT8tXiwNxXQMuMrhql4QU=
=9VU0
-----END PGP SIGNATURE-----

--czKtVf7VtiN2ETNudbl7RgFrMq5PxKP82--
