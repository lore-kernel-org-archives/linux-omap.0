From: Pavel Machek <pavel@ucw.cz>
Subject: partial bluetooth success on n900 [was Re: bluetooth/uart timeout
 handling]
Date: Wed, 19 Oct 2016 11:25:06 +0200
Message-ID: <20161019092506.GA1461@amd>
References: <20161016002454.ul5rdqwubvkct4pf@earth> <20161016090959.GA377@amd>
 <20161016173911.arxynrja6vely3d5@earth> <20161017085137.GA6628@amd>
 <20161018224259.jrwbaal27irzjqyo@earth>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7446472455579839288=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161018224259.jrwbaal27irzjqyo@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, abcloriens@gmail.com, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============7446472455579839288==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

[Ccing lists.]

> Can you push the patch, which gets further than negotiation into
> some git branch available to me? I tried to apply your patch to
> my code, but it did not work for me.

Ok, I've pushed the branch to kernel.org:

git push git@gitolite.kernel.org:pub/scm/linux/kernel/git/pavel/linux-n900.=
git bt-2-v4.9:bt-2-v4.9

In retrospect, I did make some changes to dts, they may be neccessary,
too.

If it still does not work, please try with my .config. I'm using
modules here, using this script:

pavel@n900:/my/modules$ cat run2
echo removing...
sudo killall a.out
rmmod nokia_h4p
#rmmod omap_serial
#rmmod serial_core
rmmod hci_uart.ko
#rmmod bcm2048.ko
echo installing...
insmod serial_core.ko
insmod omap-serial.ko
insmod bcm2048.ko
insmod hci_uart.ko
ls -al /dev/ttyO1
sleep 1
stty crtscts < /dev/ttyO1
/my/tui/ofone/a.out &

For the record, dmesg says:

Good luck,
									Pavel

[   30.694274] g_ether gadget: notify connect true
[   30.714080] g_ether gadget: notify speed 425984000
[  127.719146] ssi-protocol ssi-protocol: WAKELINES TEST OK
[  218.542694] of_get_named_gpiod_flags: can't parse 'rts-gpio'
property of node '/ocp@68000000/serial@4806c000[0]'
[  218.546264] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq =3D 89,
base_baud =3D 3000000) is a OMAP UART1
[  218.574157] of_get_named_gpiod_flags: can't parse 'rts-gpio'
property of node '/ocp@68000000/serial@49020000[0]'
[  218.574340] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq =3D 90,
base_baud =3D 3000000) is a OMAP UART2
[  218.650115] bcm2048: probe
[  218.650177] bcm2048 4806c000.serial:bluetooth: GPIO lookup for
consumer reset
[  218.650177] bcm2048 4806c000.serial:bluetooth: using device tree
for GPIO lookup
[  218.650360] of_get_named_gpiod_flags: parsed 'reset-gpios' property
of node '/ocp@68000000/serial@4806c000/bluetooth[0]' - status (0)
[  218.650390] bcm2048 4806c000.serial:bluetooth: GPIO lookup for
consumer host-wakeup
[  218.650421] bcm2048 4806c000.serial:bluetooth: using device tree
for GPIO lookup
[  218.650482] of_get_named_gpiod_flags: parsed 'host-wakeup-gpios'
property of node '/ocp@68000000/serial@4806c000/bluetooth[0]' - status
(0)
[  218.650512] bcm2048 4806c000.serial:bluetooth: GPIO lookup for
consumer bluetooth-wakeup
[  218.650543] bcm2048 4806c000.serial:bluetooth: using device tree
for GPIO lookup
[  218.650604] of_get_named_gpiod_flags: parsed
'bluetooth-wakeup-gpios' property of node
'/ocp@68000000/serial@4806c000/bluetooth[0]' - status (0)
[  218.650817] bcm2048 4806c000.serial:bluetooth: parent uart: ttyO1
[  218.650817] bcm2048 4806c000.serial:bluetooth: sysclk speed: 38400
kHz
[  218.650848] bcm2048 4806c000.serial:bluetooth: probe: 0
[  218.774139] Bluetooth: HCI UART driver ver 2.3
[  218.774169] Bluetooth: HCI UART protocol H4 registered
[  218.774169] Bluetooth: HCI UART protocol H4+ registered
[  218.774169] Bluetooth: HCI UART protocol BCSP registered
[  218.774200] Bluetooth: HCI UART protocol LL registered
[  218.774200] Bluetooth: HCI UART protocol ATH3K registered
[  218.774200] Bluetooth: HCI UART protocol Three-wire (H5) registered
[  219.904876] tty ttyO1: Nokia H4+ protocol initialized with
4806c000.serial:bluetooth!
[  219.921112] tty ttyO1: Nokia H4+ protocol setup...
[  219.921142] h4p_reset: reset
[  219.921142] hci_uart_init_tty
[  219.983520] h4p_reset: flush
[  219.983551] h4p_reset: speed
[  219.983581] tty ttyO1: setting speed to 120000 baud
[  219.983673] h4p_reset: safety
[  219.986480] tty ttyO1: wakeup received: 0 -> 1
[  220.013488] tty ttyO1: wait for cts... received!
[  220.013519] h4p_reset: flow
[  220.013549] tty ttyO1: Sending negotiation...
[  220.013580] tty ttyO1: gpio state: reset=3D1 wakehost=3D1 wakebt=3D1
[  220.013610] enqueue: hu c304cc80 skb cd4da000
[  220.017425] tty ttyO1: H4P negotiation:
[  220.017456] tty ttyO1:     baudrate =3D 416
[  220.017486] tty ttyO1:     system clock =3D 38400
[  220.017486] tty ttyO1:     manufacturer id =3D 4
[  220.017486] tty ttyO1:     version id =3D 11
[  220.017578] tty ttyO1: setting speed to 921600 baud
[  220.043457] tty ttyO1: wait for cts... received!
[  220.043548] tty ttyO1: Negotiation successful...
[  220.043579] tty ttyO1: Sending alive packet...
[  220.043579] enqueue: hu c304cc80 skb cd4dacc0
[  220.043853] tty ttyO1: Received alive packet!
[  220.047851] tty ttyO1: FW: Skip negotion packet!
[  220.047882] tty ttyO1: FW: Skip alive packet!
[  220.052185] enqueue: hu c304cc80 skb cd4da480
[  220.055175] enqueue: hu c304cc80 skb cd4dae40
[  220.058776] enqueue: hu c304cc80 skb cd4da6c0
[  220.058898] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.058929] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.064605] enqueue: hu c304cc80 skb cd4daf00
[  220.068389] enqueue: hu c304cc80 skb cd4da0c0
[  220.068542] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.068542] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.071960] enqueue: hu c304cc80 skb cd4da840
[  220.072082] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.072082] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.075592] enqueue: hu c304cc80 skb cd4da180
[  220.079803] enqueue: hu c304cc80 skb cd479cc0
[  220.084381] enqueue: hu c304cc80 skb cd479180
[  220.087982] enqueue: hu c304cc80 skb cd4793c0
[  220.088104] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.088134] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.091522] enqueue: hu c304cc80 skb cd479e40
[  220.095336] enqueue: hu c304cc80 skb cd479540
[  220.098876] enqueue: hu c304cc80 skb cd479000
[  220.102386] enqueue: hu c304cc80 skb cd479600
[  220.102478] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.102508] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.105987] enqueue: hu c304cc80 skb cd479780
[  220.109527] enqueue: hu c304cc80 skb cd450cc0
[  220.109619] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.109649] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.113098] enqueue: hu c304cc80 skb cd484600
[  220.113220] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.113250] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.116760] enqueue: hu c304cc80 skb cd4a9b40
[  220.120300] enqueue: hu c304cc80 skb cd77c840
[  220.124786] enqueue: hu c304cc80 skb cd4f7900
[  220.128387] enqueue: hu c304cc80 skb c4fb2180
[  220.131896] enqueue: hu c304cc80 skb c4fb23c0
[  220.135498] enqueue: hu c304cc80 skb c4fb2cc0
[  220.139007] enqueue: hu c304cc80 skb c4fb2000
[  220.142486] enqueue: hu c304cc80 skb cd44fcc0
[  220.146118] enqueue: hu c304cc80 skb cd4b60c0
[  220.149627] enqueue: hu c304cc80 skb cf1986c0
[  220.153106] enqueue: hu c304cc80 skb cf198480
[  220.156738] enqueue: hu c304cc80 skb cf1980c0
[  220.160278] enqueue: hu c304cc80 skb cf198240
[  220.164733] enqueue: hu c304cc80 skb cd49f780
[  220.168365] enqueue: hu c304cc80 skb cd4daf00
[  220.171844] enqueue: hu c304cc80 skb cd4da6c0
[  220.175445] enqueue: hu c304cc80 skb cd4dab40
[  220.175567] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.175567] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.178955] enqueue: hu c304cc80 skb cd479780
[  220.182434] enqueue: hu c304cc80 skb cd479540
[  220.182525] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.182556] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.186035] enqueue: hu c304cc80 skb cd4793c0
[  220.188140] enqueue: hu c304cc80 skb cd479b40
[  220.188537] enqueue: hu c304cc80 skb cd484600
[  220.236480] enqueue: hu c304cc80 skb cd4a9f00
[  220.237701] enqueue: hu c304cc80 skb cd4f7900
[  220.238830] enqueue: hu c304cc80 skb c4fb23c0
[  220.239959] enqueue: hu c304cc80 skb c4fb2b40
[  220.241119] enqueue: hu c304cc80 skb c3107000
[  220.242187] enqueue: hu c304cc80 skb cd724240
[  220.243286] enqueue: hu c304cc80 skb cf198540
[  220.244781] enqueue: hu c304cc80 skb cf198540
[  220.245758] enqueue: hu c304cc80 skb cd49f780
[  220.246612] enqueue: hu c304cc80 skb cd4daf00
[  220.247436] enqueue: hu c304cc80 skb cd479540
[  220.248535] tty ttyO1: Sending radio packet...
[  220.248565] enqueue: hu c304cc80 skb cd479cc0
[  220.248596] tty ttyO1: Radio packet sent
[  220.249328] Bluetooth: hci0: Frame reassembly failed (-84)
[  220.272949] tty ttyO1: wakeup received: 1 -> 0
[  221.283477] tty ttyO1: radio packet timeout!
[  221.283630] enqueue: hu c304cc80 skb cd4a9b40
[  223.363372] Bluetooth: hci0 command 0xfc18 tx timeout
pavel@n900:~$


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgHO/IACgkQMOfwapXb+vKQAACfdb7J0RqNbqxHahETxsICxgi6
SLEAnRXtOzpepIg0ilFvCf3vJwDMYeYN
=xDFq
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--


--===============7446472455579839288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7446472455579839288==--
