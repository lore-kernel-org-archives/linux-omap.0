From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] i2c: omap: TEST: do IP reset during probe.
Date: Sat, 29 Nov 2014 05:14:13 +0300
Message-ID: <AECD26B8-1FFA-4FFB-AC68-4CDC50F3F48B@gmail.com>
References: <1416685634-5864-3-git-send-email-al.kochet@gmail.com> <1417028722-29306-1-git-send-email-al.kochet@gmail.com> <7hzjbdd57j.fsf@deeprootsystems.com> <20141128221350.GW2817@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141128221350.GW2817-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


29 =CE=CF=D1=C2. 2014 =C7., =D7 1:13, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> =
=CE=C1=D0=C9=D3=C1=CC(=C1):

> Looks like for some time 2430 i2c has not been behaving
> reliably

    commit dd74548ddece4b9d68e5528287a272fa552c81d0 ("i2c: omap:
    resize fifos before each message") dropped check for dev->buf_len.
    As result, data processing loop cause dev->buf overruns for
    devices with 16-bit data register (omap2420 only).
    Found by code review.

I have the patch for that. omap2420 actually broken at all.
But I'm not ready to send it right now.

Part of the patch:

-       while (num_bytes--) {
+       while (num_bytes) {
                w =3D omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
                *dev->buf++ =3D w;
                dev->buf_len--;
+               num_bytes--;
=20
                /*
                 * Data reg in 2430, omap3 and
                 * omap4 is 8 bit wide
                 */
                if (dev->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
-                       *dev->buf++ =3D w >> 8;
-                       dev->buf_len--;
+                       if (num_bytes) {
+                               *dev->buf++ =3D w >> 8;
+                               dev->buf_len--;
+                               num_bytes--;
+                       }
                }
        }



-       while (num_bytes--) {
+       while (num_bytes) {
                if (dev->errata & I2C_OMAP_ERRATA_I462) {
                        int ret;
=20
@@ -931,14 +947,18 @@ static int omap_i2c_transmit_data(struct omap_i2c=
_dev *dev, u8 num_bytes,
=20
                w =3D *dev->buf++;
                dev->buf_len--;
+               num_bytes--;
=20
                /*
                 * Data reg in 2430, omap3 and
                 * omap4 is 8 bit wide
                 */
                if (dev->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
-                       w |=3D *dev->buf++ << 8;
-                       dev->buf_len--;
+                       if (num_bytes) {
+                               w |=3D *dev->buf++ << 8;
+                               dev->buf_len--;
+                               num_bytes--;
+                       }
                }
