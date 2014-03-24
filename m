From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Do not reset gpio5
Date: Mon, 24 Mar 2014 13:50:27 -0500
Message-ID: <20140324185027.GC12500@saruman.home>
References: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com>
 <20140321055242.GA1959@saruman.home> <53304F76.8090703@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2039278067719843225=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53304F76.8090703@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: nm@ti.com, devicetree@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, rnayak@ti.com, nsekhar@ti.com, balbi@ti.com, tony@atomide.com, bcousson@baylibre.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============2039278067719843225==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline

--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 24, 2014 at 10:29:58AM -0500, Dave Gerlach wrote:
> On 03/21/2014 12:52 AM, Felipe Balbi wrote:
> >On Fri, Mar 21, 2014 at 10:50:13AM +0530, Lokesh Vutla wrote:
> >>From: Dave Gerlach <d-gerlach@ti.com>
> >>
> >>Do not reset GPIO5 at boot-up because GPIO5_7 is used
> >>on AM437x GP-EVM to control VTT regulators on DDR3.
> >>Without this some GP-EVM boards will fail to boot because
> >>of DDR3 corruption.
> >>
> >>Reported-by: Nishanth Menon <nm@ti.com>
> >>Tested-by: Nishanth Menon <nm@ti.com>
> >>Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> >>Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >
> >every now and again we see a patch like this because yet another board
> >is using a GPIO to toggle DDR regulators.
> >
> >Instead of constantly patching things like this, how about we try
> >something like below (build-tested only):
>=20
> Why should we change all of them? Is it correct to leave every single GPIO
> at the mercy of the bootloader in every situation? The reason we see these

it's not leaving anything at the mercy of the bootloader. It's simply
looking at the HW itself and asking "what's the current state of this
GPIO ?"

> patches only every now and again is because it's a special case that shou=
ld

I wouldn't call it "special". A GPIO block is pretty dumb, its registers
only give you current pin state, there's virtually no state machine
involved whatsoever.

> be handled only for that situation. I also don't think it makes sense
> to make gpio's a unique case that never gets reset while every other
> IP does by default.

Well, if it doesn't need to be reset, why would you spend that time
resetting it ? In the GPIO case, you gain nothing by resetting the IP,
nothing at all, other than "now I'm sure the IP is in
no-standby/no-idle" but that can be easily read back from SYS[SC]
registers anyway.

The point is that we have two choices here:

a) every time a new board comes around using GPIO as an enable signal
for DDR, we spend a few days debugging why it's not booting.

b) make sure no GPIO block is ever reset, so we never go through the
debugging cycle again.

--=20
balbi

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTMH5zAAoJEIaOsuA1yqRE2GkQALUtGXsczwSITwLk6yCp081f
cJHBn2pLI61LHlbLPXwPVS2xc3xySrIQWImGstg2s7SePIMzMDYyIUvFGToOrdVO
mSHmzpCP4JBysPeoj6IN6ZOicQV6zwpr5BQCf1/RAeus8iw94kbBHn/6BSv1Ntim
Dz30q/ITeEBSD3j44xc4spHIdArzkuVT/HbCUP3TkprkrycPYbqx5UDagJQz9FVB
RJEvypRv0I0Ba0hTRNYDUJqHklK6CuuEErmkxF+wyfNmymAl7OjtH+t3oLvsdRui
kDbWIEYdqB6hIbjk+f+CK8/Vgr7RrnyXMp2HpJeNekEmSA/m6zN6iS+gfAEMRU7E
73iD8vku1ffHKq7qhoEQUH7bjjnauj9dF8zGprApKDF4bxEWojTPGxyKdK6ADLXu
bf2EGjlZw/zZkMQswDdXYP2qRrvMrfQWPWqZUjUGgilzj8o+FX36eG2ilszfo8FL
p3i2YBwIBLealy22J8cIlBm4mwGFGKQ9kWmVdLyacPqcmf6ApHEHeuPgUXXti0og
rTpK9migYYoV3NvWL/kgOGO4Y0AAR76q5BPXVlNi85XmfkycsnrrAPeWUk+rmDPn
SA0AaePiRoQCEc3PQpf7rBBIavmV9dbY9UtmHZ/lpNLf4UihQdzkb+S9+JMEBOLZ
RN1dB1q6FVczoSZOIGcc
=Pp8f
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--


--===============2039278067719843225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2039278067719843225==--
