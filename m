From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Wed, 5 Aug 2015 12:50:13 +0100
Message-ID: <20150805115013.GJ20873@sirena.org.uk>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-2-git-send-email-vigneshr@ti.com>
 <20150731181745.GM20873@sirena.org.uk>
 <55BEF4AF.5090704@ti.com>
 <20150804155148.GR20873@sirena.org.uk>
 <55C0FD98.1090107@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s+oWWcayER+yiG5Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C0FD98.1090107@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "R, Vignesh" <vigneshr@ti.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Huang Shijie <b32955@freescale.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--s+oWWcayER+yiG5Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2015 at 11:29:52PM +0530, R, Vignesh wrote:
> On 8/4/2015 9:21 PM, Mark Brown wrote:
> > On Mon, Aug 03, 2015 at 10:27:19AM +0530, Vignesh R wrote:

> > I still can't tell from the above what this interface is supposed to do.
> > It sounds like the use of memory mapped mode is supposed to be
> > transparent to users, it should just affect how the controller interacts
> > with the hardware, but if that's the case why do we need to expose it to
> > users at all?  Shouldn't the driver just use memory mapped mode if it's
> > faster?

> 2. SFI_MM_IF(SPI memory mapped interface): The SFI_MM_IF block only
> allows reading and writing to an SPI flash device only. Used to speed up
> flash reads. It _cannot_ be used to communicate with non flash devices.
> Now, the spi_message that ti-qspi receives in transfer_one() callback
> can be from mtd device(in which case SFI_MM_IF can be used) or from any
> other non flash SPI device (in which case SFI_MM_IF must not be used
> instead SPI_CORE is to be used) but there is no way(is there?) to
> distinguish where spi_message is from. Therefore I introduced flag
> (use_mmap_mode) to struct spi_message. mtd driver will set flag to true,
> this helps the ti-qspi driver to determine that the user is flash device
> and thus can do read via SFI_MM_IF. If this flag is not set then the
> user is assumed to be non flash SPI driver and will use SPI_CORE block
> to communicate.

So if you're trying to do this you need to document it adequately so
that other people can understand what it is supposed to do and how to
use and implement it.  People can't really tell how the interface is
supposed to work based on what was in the patch and the above isn't
really helping.  For example, how does this change or restrict what the
contents of the spi_message are?

> On the whole, I just need a way to determine that the user is a flash
> device in order to switch to memory mapped interface.

As far as I can tell you want to set a per spi_message flag saying that
the message is a flash read command?  If that's what this is trying to
do then why do you need to set the flag at all?  If the message is in a
clearly defined format and it's more efficient to use this mmap mode
then surely the driver can just recognise that the format is approprate
and switch into mmap mode without being explicitly told - I'm not clear
what the flag adds here.

--s+oWWcayER+yiG5Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwfh0AAoJECTWi3JdVIfQsVoH/ijzfz90BinO96BW5ivE2U/Y
Mj2uaLVQxBNLnZ3KJhwwiH8jqVHZcxsaJd1Gps10fI3mmTuBCQF6X2Qx4UQ0HABE
ZKZsYFyXGJ7uHr5OUmTwqQFCJrsig0xJiB/Ii4GnseERnbi2GY+xI+iz8LS29gLa
WviPqvCnK1/GKTTsC2Kz8rU4QSwCGdoE+cfsPw7x8guvptzXyhHLlvkChLIiPW6G
7TANH0gUFPplziwl+A+JopsZNZpGq+Qx7u7Yl+85aYjgT60fHltHgSYXQWDXuU4l
SjgAaSlcI9tDLVsYzd1kd0vn+px2tJtio++Uc0XdJplEGnWyyFOoOB+4Bdpdytk=
=YStL
-----END PGP SIGNATURE-----

--s+oWWcayER+yiG5Z--
