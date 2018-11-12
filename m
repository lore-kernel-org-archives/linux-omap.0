From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v1 4/5] usb: dwc3: drd: Switch to device property for 'extcon' handling
Date: Mon, 12 Nov 2018 13:47:10 +0200
Message-ID: <874lcm34ch.fsf@linux.intel.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com> <20181110181101.24557-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181110181101.24557-4-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> Switch to device property for 'extcon' handling.
> No functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/usb/dwc3/drd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index e7e421521a34..5dc4cddd5b68 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -10,6 +10,7 @@
>  #include <linux/extcon.h>
>  #include <linux/of_graph.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>=20=20
>  #include "debug.h"
>  #include "core.h"
> @@ -485,8 +486,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3=
 *dwc)
>  	struct device_node *np_phy, *np_conn;
>  	struct extcon_dev *edev;
>=20=20
> -	if (of_property_read_bool(dev->of_node, "extcon"))
> -		return extcon_get_edev_by_phandle(dwc->dev, 0);
> +	if (device_property_read_bool(dev, "extcon"))
> +		return extcon_get_edev_by_phandle(dev, 0);

No reservations against any of the patches. What is the idea for getting
these merged upstream? I don't mind taking 4-5 through my tree, but what
are the other folks considering?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlvpaD4ACgkQzL64meEa
mQaAtw/+InF7b2f+wuzyOTNpr/uXn6Y7KMmBL0Cvh9ee7BiuQvghmcpKNufDLxA0
6DvmfmqxBdyvHMaKvygBJzpRVrYZIvcmzk9kGpYmTZFJ/7IF8S+jmuZZUz6V+/Db
T5MOC+czKGWBVv8XVDzvK2jG53RUMDzpeiu/KXksXvUi89Kg88kH77Brj/RnUfia
8FGJ7Vdzvbsntd/efVQl3q6gSQHRI1Syi3Nm5htsRwJxZZx6Cl0VnyDSXNLR6Ecc
GOC+xRGTDrP8f4DoSc66Bzak8NhOly9RE+DnjlqbHX8SZPp9lyg+3bWy1VlCnjW1
ze0yiIPQE5wytjKyFYg0L+0INesgsxb3ptfg2XRoeuStfjr+2z6CcXh+q2Dwve3/
pvA9ZUf2cNU6x+oiPCn26G6dfFtGaqRiliJ33L3K7dtajA52+Xt7zRg45Vz9fb1p
a2yT9lWZWpPFcDQ/pLX8H7JVpp4p8djt9v7BsVCtbbyHXnO6gtaeH7idmlQ/eTfj
bsiPYCMDCcvzjkVM69R7URy5E0sDQ4IGpm5v99c+PWnHICYb0SfaGFwEeTDe8QnF
b+SqdpIhIMinHMEYYUHnKn/8WpGx/4MrLSlCNvWWCuQjuxgyI1RawygsU9AMnyv5
JhP7cfr6dMvsXij/bzlM4XNOVbhUKpQSLyYSaOThXoeBXPyJdJI=
=htB7
-----END PGP SIGNATURE-----
--=-=-=--
