From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2/7] MFD: twl6040: Convert to i2c driver,
 and separate it from twl core
Date: Thu, 2 Feb 2012 13:27:50 +0000
Message-ID: <20120202132750.GM7428@opensource.wolfsonmicro.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
	<1328185019-29575-3-git-send-email-peter.ujfalusi@ti.com>
	<20120202124828.GI7428@opensource.wolfsonmicro.com>
	<4F2A8912.4070701@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6179903062096694417=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4F2A8912.4070701@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============6179903062096694417==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LJm8egi4vkexsie5"
Content-Disposition: inline


--LJm8egi4vkexsie5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 03:01:06PM +0200, Peter Ujfalusi wrote:
> On 02/02/2012 02:48 PM, Mark Brown wrote:

> > The calling convention here seems a bit weird too, you've got value then
> > register but normally we have register then value for I2C/SPI devices.

> I have based these part on the twl-core's implementation. I should not
> have done that, I know.. Let's see how it will look like with regmap.

Yeah, like I say...

> > Except when we don't :(

...it's not like we've been consistent so far.  I'm not that fussed
either way, I probably wouldn't have mentioned it if I hadn't otherwise
been commenting.

--LJm8egi4vkexsie5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKo9QAAoJEBus8iNuMP3d8C8P/2APfGHxR50k12kNTnlBiL8y
n+pO+dZXR1k06mxGl4VRK5LKvtx0CJQj1ZmyiXyjTgcQk8W+HIuVm3UMIN2/X4yO
mhunULuCrPxzfPyJIaFUejgS85xoQHhWylojfujdbCSlMzFaxBn2iVsu8J4R1t5m
n/vC/OI8RXB64Bys/XyCAPvJGrRAr5J+S4RuKqImYcbxHtT2NT81h2Y8DiowN0Op
VVKHOBc37QbHX6YUnDVPBwV4o35hTPh4jMBzGCbfj4Y0SDGfbM/8uIdmQ8IfD0ii
xPWMgCNZRnxBpFRPZD+r5O/IcwcbT4Dv49CyrDshEqNZLTX94AC+gj3xYn+2Ve7m
WC/AFT3qfDPGxiztAjjtb3qsnWAXyx3/l2yQrCaqL6b0SEmhJSSE4319kgSj2Ywm
7cgDWmuiqHJpNaDvOVEb6GoH4QiIdTGiRxAXxihaea4zB9AlDvF8bs5gI1f7z9Q7
2fl1k9e60J1/JAOiZiHyOzNqiNpBoYhS7MJXknvnzlDaKb2ooKRl8lF4pDH1apBm
LCvaXxNsx+1Iv4cwBHLD37wJp8AK4HFFEX3PSjaHyzpqThWY7/km1FRCKtuSKyK9
aNJW2treDVtRBTReVx7dSXeigULGSyX44OJ4Y2KOcm5g0Gyfwe7ThkldYdTfxfep
HcOl2tNLGICDuTVwQQ1P
=IGMO
-----END PGP SIGNATURE-----

--LJm8egi4vkexsie5--

--===============6179903062096694417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6179903062096694417==--
