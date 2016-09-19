From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Gadget regression with u_ether in Linux next
Date: Mon, 19 Sep 2016 11:19:07 +0300
Message-ID: <87h99c4804.fsf@linux.intel.com>
References: <20160916220355.w6whbd75eqegrz3q@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160916220355.w6whbd75eqegrz3q-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Harish Jenny K N <harish_kandiga-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Jim Baxter <jim_baxter-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Greg,

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> Hi,
>
> Looks like commit c9ffc78745f8 ("usb: gadget: NCM: Protect dev->port_usb
> using dev->lock") causes hangs for me with Linux next.
>
> Reverting c9ffc78745f8 makes the issues go away, some more info below.

Can you revert this commit from your tree?

Here's the full commit for reference:

commit c9ffc78745f89e300fe704348dd8e6800acf4d18
Author: Harish Jenny K N <harish_kandiga-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Date:   Fri Sep 9 11:30:42 2016 +0200

    usb: gadget: NCM: Protect dev->port_usb using dev->lock
=20=20=20=20
    This commit incorporates findings from
    https://lkml.org/lkml/2016/4/25/594
=20=20=20=20
    The function has been modified to make sure we hold
    the dev lock when accessing the net device pointer.
=20=20=20=20
    Acked-by: Jim Baxter <jim_baxter-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
    Signed-off-by: Harish Jenny K N <harish_kandiga-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
    Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/fun=
ction/u_ether.c
index 9c8c9ed1dc9e..8cb08033b7c1 100644
=2D-- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -553,14 +553,16 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
                spin_lock_irqsave(&dev->lock, flags);
                if (dev->port_usb)
                        skb =3D dev->wrap(dev->port_usb, skb);
=2D               spin_unlock_irqrestore(&dev->lock, flags);
                if (!skb) {
                        /* Multi frame CDC protocols may store the frame for
                         * later which is not a dropped frame.
                         */
                        if (dev->port_usb &&
=2D                                       dev->port_usb->supports_multi_fra=
me)
+                                       dev->port_usb->supports_multi_frame=
) {
+                               spin_unlock_irqrestore(&dev->lock, flags);
                                goto multiframe;
+                       }
+                       spin_unlock_irqrestore(&dev->lock, flags);
                        goto drop;
                }
        }

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX3597AAoJEMy+uJnhGpkGXaoP/31o7kFHzlyt6SGETamAkuf3
pCxZLZCbp9kdWbt5fXqI2ZyJ++BZPw6p/ZpFmNpWfNuCh5Yc9liGCKIg2r84cJCw
REwAOYE3QJg5zhNeFAmZI2yenUkJ2xAJmejYupiZEvC0VhbXsNPAyf6TVJNDWdA5
CJi3a6yfA2EPVysHmSAGsdNzQjXVRDRL/9uQAoz4OSi9WdvW6yk3+WZQ+08f81mI
DOUeWEOTg6VRUQPSwgpzqi/ZU0wNfC/POU5sJH8B4AJirH1X7xVOd+bXAC5LP0p8
32ZmdvEejiVgG8/gS0r969UVoLqqbICJjDDj1y2eWothpuP6pQ76MEKB210tvKA/
QmeHzlpBVRDE+YqfINlGxpPxcVwZrUGz9bQ5bRlJrh7/SVbstFo8tKRKpBsTneq3
uBOpyM3xYFn05U7/0n0jnP6d9ln54XY17Xq3gqehAd8V39bgEVNcYE4e194AHn38
QJ/tGf2qhS6CQWQ7x7Mj2SImowOJWcbKasT1VDexv2R2X6dRlpxytUFVGNfrG6Gu
EZzFpJUvqp5k5iwcCMuLOsMhWP2uSrWEpxfLsuwtVHqQNnEWzIUywAaIxwOigpHw
r4DH70MnudDyep1r9sgNroGFQTx7kdcnzqjkc/QVDmDXE21W/nOmtUsU7QarLXnW
uxaPncVr7fMdw1XPKJHf
=MVUI
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
