From: Sebastian Reichel <sre@kernel.org>
Subject: Re: v4.1-rc1 & N900: annoying Nokia modem spam
Date: Sun, 3 May 2015 02:29:38 +0200
Message-ID: <20150503002938.GA11653@earth>
References: <20150502184337.GA575@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39361 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbbECA3s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 May 2015 20:29:48 -0400
Content-Disposition: inline
In-Reply-To: <20150502184337.GA575@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, May 02, 2015 at 09:43:37PM +0300, Aaro Koskinen wrote:
> With v4.1-rc1, after loading nokia_modem I get the following endless
> log spam until I load cmt_speech (for whatever reason it does not get
> modprobed automatically with busybox modprobe):

So ssi-protocol is loaded automatically and cmt-speech is not?
That's strange, since they are requested the same way.

> 	[   41.626983] nokia-modem n900-modem: Missing cmt-speech driver
> 	[   41.804565] nokia-modem n900-modem: GPIO lookup for consumer (null)
> 	[   41.804626] nokia-modem n900-modem: using device tree for GPIO lookup
> 	[   41.804687] of_get_named_gpiod_flags: parsed 'gpios' property of node '/ocp/ssi-controller@48058000/ssi-port@4805a000/hsi-client[0]' - status (0)
> 	[   41.804718] no flags found for (null)
> 	[   41.805023] nokia-modem n900-modem: GPIO lookup for consumer (null)
> 	[   41.805023] nokia-modem n900-modem: using device tree for GPIO lookup
> 	[   41.805145] of_get_named_gpiod_flags: parsed 'gpios' property of node '/ocp/ssi-controller@48058000/ssi-port@4805a000/hsi-client[1]' - status (0)
> 	[   41.805145] no flags found for (null)
> 	[   41.805389] nokia-modem n900-modem: GPIO lookup for consumer (null)
> 	[   41.805419] nokia-modem n900-modem: using device tree for GPIO lookup
> 	[   41.805541] of_get_named_gpiod_flags: parsed 'gpios' property of node '/ocp/ssi-controller@48058000/ssi-port@4805a000/hsi-client[2]' - status (0)
> 	[   41.805572] no flags found for (null)
> 	[   41.805816] nokia-modem n900-modem: GPIO lookup for consumer (null)
> 	[   41.805816] nokia-modem n900-modem: using device tree for GPIO lookup
> 	[   41.805969] of_get_named_gpiod_flags: parsed 'gpios' property of node '/ocp/ssi-controller@48058000/ssi-port@4805a000/hsi-client[3]' - status (0)
> 	[   41.805999] no flags found for (null)
>
> Not nice.

Everything (except of the first line) is because you have
CONFIG_DEBUG_GPIO enabled and nokia-modem returns -EPROBE_DEFER
until all drivers are available, so GPIOs will be acquired again
the next time the drivers tries to probe.

> Also, I now realize there is a forced nokia_modem Kconfig dependency
> to cmt_speech. Before I was able to use data connection only, so why
> now force this dependency to cmt_speech?

I assumed, that there is no real usecase for not building cmt-speech
together with nokia-modem. I think CMT_SPEECH and SSI_PROTOCOL
should actually be hidden and autoselected by NOKIA_MODEM.

-- Sebastian

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVRWvvAAoJENju1/PIO/qaFfwQAIzCMASQfOUJLIZ5lKDYJ45m
d0/SZ3qiLyBE4TWooOZg6+aSzGYDMSnmmZ2msG3pItxIyr6qlZbASoTCkNW51eu1
8AB7uwyNOtJPTuX4Y5UmAI6OWHa6WuUx6E2GzfHEOvdGYZS2BISqEWqoBRY5Ns8O
0H00FccCjwmIu6uXQTTD0cMaRA3UkTiYsqqsSzAv5Yhp4GG8t61311swX36F7iM0
Pe7tyMgQ04oHQJdiYhLBCEJhTAc5kb02lEOq4OHj/tT+G2vl0qP8tLKeaIoK7Puz
skS0nXueMOtUFs0keVcsptHEknCcHXBi8B3XnMTLCOFQxdONqVKph+DCUzCW2kXI
sajJ30jr1umJfTXeex/Wkm2bd27iBL0xAbok552BguAQ2dXDjlrKmBFqtiW46Wb1
hc0r0+/keks63OmxCwGe5nyb+6A8R45mzRHEPBMDrYiiSt1ldvyna+2wl4xGnWLL
fl//8jOkYfH5AtUi34rgpnYbJS7bVAvOUkQRfDv9XbhPjnidDfPeGBxctgcHyCG5
eBRWxXlEa4KyLz9dBMd5ma0e4ZpHqB7mDSeyIPcwmb3BMLtHlQ6o1RER0boUsFxR
XUIBY7KINBdRuZOCh7Rdhgzh2VQk58bjvTn6f7gNxtRMqCAcx2ruWTXThKK6N9mV
bu4eQ66XmcCZCARmgEq6
=Wk2R
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
