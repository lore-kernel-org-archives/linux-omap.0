From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: MUSB regression in linux next at least for pandboard
Date: Wed, 6 Feb 2013 15:51:26 +0200
Message-ID: <20130206135126.GA6773@arwen.pp.htv.fi>
References: <20121004173107.GD3874@atomide.com>
 <20121004175742.GB9702@arwen.pp.htv.fi>
 <20121005013910.GI3874@atomide.com>
 <20121005162717.GL3874@atomide.com>
 <CAFp+6iEQ85EEt2m7f8WSo8y7te62O_R4iia3_xiSMjzLXrAy5g@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFp+6iEQ85EEt2m7f8WSo8y7te62O_R4iia3_xiSMjzLXrAy5g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vivek Gautam <gautamvivek1987-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 06, 2013 at 05:27:52PM +0530, Vivek Gautam wrote:
> Hi Tony,
>=20
>=20
> On Fri, Oct 5, 2012 at 9:57 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [121004 18:41]:
> >> >
> >> > > Also on the EHCI port, I've seen issues where unplugging
> >> > > the cable hangs kernel with an infinite loop. But that happens
> >> > > only occasionally, sorry does not seem to happen right
> >> > > now so no output to paste here. Or maybe this issue
> >> > > has already been fixed?
> >
> > Looks like the system eventually recovers from the EHCI issue
> > after about fivew minutes or so of spamming the logs. It seems
> > the ehci-omap errors are:
> >
> > [62934.201538] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 31
> > [62934.201660] ehci-omap ehci-omap.0: devpath 1.3.7 ep0out 3strikes
> > [62934.201873] ehci-omap ehci-omap.0: reused qh ea5632c0 schedule
> >
> > More data below.
> >
>=20
> Is this issue fixed ?
> Actually we too are getting very similar issue with samsung exynos5250 ha=
rdware.
> With latest 'usb-next' kernel and supporting arch patches, when i use
> following test scenerio:
> Connect a USB 2.0 external hub to USB 2.0 port, and connect mice or
> keyboard enumeration and
> functionality is fine but once disconnecting the HID we get to see the
> error log:
> hid-generic 0003:04B3:3025.0002: can't reset device,
> s5p-ehci-1.3/input0, status -71
>=20
> When i tried to enable CONFIG_USB_DEBUG, get the following log:

looks like it's not OMAP-specific. Alan any tips ?

(keeping logs below)

> hub 1-1:1.0: state 7 ports 7 chg 0000 evt 0008
> hub 1-1:1.0: port 3, status 0301, change 0001, 1.5 Mb/s
> hub 1-1:1.0: debounce: port 3: total 100ms stable 100ms status 0x301
> usb 1-1.3: new low-speed USB device number 5 using s5p-ehci
> usb 1-1.3: skipped 1 descriptor after interface
> usb 1-1.3: default language 0x0409
> usb 1-1.3: udev 5, busnum 1, minor =3D 4
> usb 1-1.3: New USB device found, idVendor=3D04b3, idProduct=3D3025
> usb 1-1.3: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> usb 1-1.3: Product: USB NetVista Full Width Keyboard
> usb 1-1.3: Manufacturer: CHICONY
> usb 1-1.3: usb_probe_device
> usb 1-1.3: configuration #1 chosen from 1 choice
> usb 1-1.3: adding 1-1.3:1.0 (config #1, interface 0)
> usbhid 1-1.3:1.0: usb_probe_interface
> usbhid 1-1.3:1.0: usb_probe_interface - got id
> input: CHICONY USB NetVista Full Width Keyboard as
> /devices/s5p-ehci/usb1/1-1/1-1.3/1-1.3:1.0/input/input1
> usb 1-1.3: link qh8-0e01/c193f140 start 2 [1/2 us]
> hid-generic 0003:04B3:3025.0002: input: USB HID v1.10 Keyboard
> [CHICONY USB NetVista Full Width Keyboard] on usb-s5p-ehci-1.3/input0
> hub 1-1:1.0: state 7 ports 7 chg 0000 evt 0008
>=20
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 1
> usb 1-1.3: unlink qh8-0e01/c193f140 start 2 [1/2 us]
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 1
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 2
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 3
> hub 1-1:1.0: state 7 ports 7 chg 0000 evt 0008
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 4
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 5
> hub 1-1:1.0: port 3, status 0100, change 0001, 12 Mb/s
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 6
> usb 1-1.3: USB disconnect, device number 5
> usb 1-1.3: unregistering device
> usb 1-1.3: unregistering interface 1-1.3:1.0
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 7
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 8
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 9
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 10
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 11
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 12
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 13
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 14
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 15
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 16
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 17
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 18
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 19
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 20
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 21
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 22
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 23
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 24
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 25
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 26
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 27
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 28
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 29
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 30
> s5p-ehci s5p-ehci: detected XactErr len 0/8 retry 31
> s5p-ehci s5p-ehci: devpath 1.3 ep0out 3strikes
> usb 1-1: clear tt buffer port 3, a5 ep0 t00080248
> hid-generic 0003:04B3:3025.0002: can't reset device,
> s5p-ehci-1.3/input0, status -71
>=20
> Similar log as you get on ehci-omap ;-)
> Sorry i might have missed some information to put here.
>=20
> Your help will be very much useful.
> Thanks in advance :-)
>=20
> > ...
> > [62927.200012] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
> > [62927.215606] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 25
> > [62927.220092] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 22
> > [62927.225738] ehci-omap ehci-omap.0: devpath 1.3.7 ep0out 3strikes
> > [62927.232238] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 17
> > [62927.236633] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
> > [62927.241119] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 3
> > [62927.251098] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
> > [62927.258605] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 12
> > [62927.264343] usb 1-1.3.7.5: link qh8-0e01/ea5632c0 start 6 [1/2 us]
> > [62927.274353] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 17
> > [62927.276092] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 24
> > [62927.280700] usb 1-1.3.7: clear tt 4 (0120) error -71
> > [62927.289245] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
> > [62927.292633] usb 1-1.3.7: clear tt buffer port 4, a18 ep0 t00080248
> > [62927.296356] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 26
> > [62927.302368] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 6
> > [62927.307098] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 24
> > [62927.308258] hid-generic 0003:047D:1020.000C: can't reset device, ehc=
i-omap.0-1.3.7.4/input0, status -1
> > [62927.317230] usb 1-1.3.7: clear tt buffer port 5, a26 ep0 t00080248
> > [62927.322357] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
> > [62927.324981] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
> > [62927.330718] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 9
> > [62927.336364] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 20
> > [62927.348114] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 31
> > [62927.349090] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
> > [62927.356475] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 26
> > [62927.368469] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
> > [62927.372253] usb 1-1.3.7: clear tt buffer port 4, a18 ep0 t00080248
> > [62926.616607] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
> > [62926.622863] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 10
> > [62926.627746] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
> > [62926.628112] ehci-omap ehci-omap.0: devpath 1.3.7.4 ep0out 3strikes
> > [62926.639404] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 14
> > [62926.643737] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
> > [62926.651123] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 15
> > [62926.655609] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
> > [62926.660125] usb 1-1.3.7: clear tt buffer port 4, a18 ep0 t00080248
> > [62926.667480] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 15
> > [62926.669982] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 1
> > [62926.680603] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 3
> > [62926.686126] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 14
> > [62926.693237] usb 1-1.3.7: clear tt buffer port 5, a26 ep0 t00080248
> > [62926.694091] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 4
> > [62926.706359] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
> > [62926.709350] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 7
> > [62926.712554] usb 1-1.3.7: clear tt 4 (0120) error -71
> > [62926.714599] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 16
> > [62926.720855] ehci-omap ehci-omap.0: devpath 1.3.7.5 ep0out 3strikes
> > [62926.729248] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
> > [62926.732238] usb 1-1.3.7: clear tt buffer port 4, a18 ep0 t00080248
> > [62926.736358] ehci-omap ehci-omap.0: devpath 1.3.7 ep0out 3strikes
> > [62926.742736] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 9
> > [62926.755615] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 27
> > [62926.756744] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
> > [62926.763610] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
> > [62926.769226] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
> > [62926.780609] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
> > [62926.782745] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
> > [62926.789978] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 3
> > [62926.801605] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 11
> > [62926.804626] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
> > [62926.809844] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
> > [62926.815734] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
> > [62926.828979] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 4
> > [62926.829101] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
> > [62926.840118] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 20
> > [62926.851745] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 28
> > [62926.855987] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 28
> > [62926.863220] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 13
> > [62926.876251] ehci-omap ehci-omap.0: devpath 1.3.7.4 ep0out 3strikes
> > [62926.876403] hid-generic 0003:047D:1020.000C: can't reset device, ehc=
i-omap.0-1.3.7.4/input0, status -1
> > [62926.897125] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 7
> > [62926.903747] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 26
> > [62926.920989] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 6
> > ...
> >
> > After waiting for several minutes, it stops, and dmesg shows:
> >
> > # dmesg | grep -i omap
> > [62934.193389] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
> > [62934.193542] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 3
> > [62934.193664] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 4
> > [62934.193786] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
> > [62934.194030] ehci-omap ehci-omap.0: reused qh ed0fbdc0 schedule
> > [62934.194122] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 6
> > [62934.194274] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 7
> > [62934.194396] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 8
> > [62934.194519] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 9
> > [62934.194641] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 10
> > [62934.194793] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 11
> > [62934.194915] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 12
> > [62934.195037] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 13
> > [62934.195159] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 14
> > [62934.195281] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 15
> > [62934.195404] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 16
> > [62934.195526] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 17
> > [62934.195648] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
> > [62934.195770] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
> > [62934.195892] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 20
> > [62934.196014] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 21
> > [62934.196166] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 22
> > [62934.196289] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 23
> > [62934.196411] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 24
> > [62934.196533] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 25
> > [62934.196655] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 26
> > [62934.196777] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 27
> > [62934.196899] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 28
> > [62934.197021] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
> > [62934.197143] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 30
> > [62934.197265] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 31
> > [62934.197418] ehci-omap ehci-omap.0: devpath 1.3.7.5 ep0out 3strikes
> > 1.3.7.5/input0, status -71
> > [62934.197784] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 1
> > [62934.197906] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 2
> > [62934.198028] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 3
> > [62934.198150] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 4
> > [62934.198272] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 5
> > [62934.198394] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 6
> > [62934.198516] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 7
> > [62934.198638] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 8
> > [62934.198791] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 9
> > [62934.198913] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 10
> > [62934.199035] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 11
> > [62934.199157] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 12
> > [62934.199279] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 13
> > [62934.199401] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 14
> > [62934.199523] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 15
> > [62934.199645] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 16
> > [62934.199768] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 17
> > [62934.199890] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 18
> > [62934.200042] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 19
> > [62934.200042] ehci-omap ehci-omap.0: detected XactErr len 0/4 retry 1
> > [62934.200164] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 20
> > [62934.200164] ehci-omap ehci-omap.0: detected XactErr len 0/4 retry 2
> > [62934.200286] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 21
> > [62934.200286] ehci-omap ehci-omap.0: detected XactErr len 0/4 retry 3
> > [62934.200408] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 22
> > [62934.200531] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 23
> > [62934.200653] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 24
> > [62934.200775] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 25
> > [62934.200897] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 26
> > [62934.201019] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 27
> > [62934.201141] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 28
> > [62934.201263] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 29
> > [62934.201416] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 30
> > [62934.201538] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry 31
> > [62934.201660] ehci-omap ehci-omap.0: devpath 1.3.7 ep0out 3strikes
> > [62934.201873] ehci-omap ehci-omap.0: reused qh ea5632c0 schedule

--=20
balbi

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJREl/eAAoJEIaOsuA1yqREc50QAKNDNFnH+yjD+pJWT+roT213
iqTdXe9QSUAmh2ITIg7C2Epxco+rMEoaw/i3zreqZRtewhE50kpJjX/xCRO44Bi7
3iVnrzTYnuBXhup5N+2+YEB6rvQMDfH0iQnleZJuxyloeYKrYh99NN+taMt2oMt9
Bu2C8/vDI/Uar/akQaTAivqzdDLMmhIbkay06d5QbEmEvfflS2cgzSa76nddHkAq
0k4KICJkB8c/HN2EQGzAHObdq1H/aW7cMmTXGnRa6z1iyHYQ+94RA1uhZglSN1AR
ox8jM7geh5dHzIm80ZeIphJe+uqYmIzTpo1R+++TpltA+ZddBeooDxBSTuPUlAmS
oW4J3wfhq7hZZ4ceNQUTWWfTXTuyKQi+3A0hrb2gkFOIIYczLT+mVk6pBR4IJVBi
az2WZKTXCt6Lo+AQG5O/lMi11KaCs3fEXURPh2lFj/y8o3TuP3GGkRCYXPe9ohOc
Ld40X0t8Eb8zYd6G2e7JuP4idWEcd2i8E2dcxCU0TcP2vehZwW8iT9HHwHmXulxr
FIacSSTonxeeu4KX1ctjxWIEMlURCtZ2jNJfK05FgaT+yt8AkJRzT6WnzKyq1DGr
Ex/5A0BIhYFjS6jYLxHI4C1W1X72knvDRd3/Q8hifSAmZwaVknyPKaIiTbYmF//J
gSQ/bNaPbuuLB1+3up9Y
=ChyT
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
