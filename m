From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] OMAP/I2C - Fix timeout problem during suspend.
Date: Fri, 30 Dec 2011 12:40:30 +1100
Message-ID: <20111230124030.12c3d02c@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/rGSApU6yCXFNaoH5IWNYQfl"; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--Sig_/rGSApU6yCXFNaoH5IWNYQfl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable



On a board with OMAP3 processor and TWL4030 Power management,
we need to talk to the TWL4030 during late suspend but cannot
because the I2C interrupt is disabled (as late suspend disables
interrupt).

e.g. I get messages like:

[   62.161102] musb-omap2430 musb-omap2430: LATE power domain suspend
[   63.167205] omap_i2c omap_i2c.1: controller timed out
[   63.183044] twl: i2c_read failed to transfer all messages
[   64.182861] omap_i2c omap_i2c.1: controller timed out
[   64.198455] twl: i2c_write failed to transfer all messages
[   65.198455] omap_i2c omap_i2c.1: controller timed out
[   65.203765] twl: i2c_write failed to transfer all messages

The stack shows omap2430_runtime_suspend calling twl4030_set_suspend
which tries to power-down the USB PHY (twl4030_phy_suspend ->
twl4030_phy_power -> __twl4030_phy_power which as a nice WARN_ON
that helps).

Then we get the same in resume:

[   69.603912] musb-omap2430 musb-omap2430: EARLY power domain resume
[   70.610473] omap_i2c omap_i2c.1: controller timed out
[   70.626129] twl: i2c_write failed to transfer all messages
etc.

So don't disable interrupts for I2C.

Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fa23faa..23e4c65 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1066,7 +1066,7 @@ omap_i2c_probe(struct platform_device *pdev)
=20
 	isr =3D (dev->rev < OMAP_I2C_OMAP1_REV_2) ? omap_i2c_omap1_isr :
 								   omap_i2c_isr;
-	r =3D request_irq(dev->irq, isr, 0, pdev->name, dev);
+	r =3D request_irq(dev->irq, isr, IRQF_NO_SUSPEND, pdev->name, dev);
=20
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);

--Sig_/rGSApU6yCXFNaoH5IWNYQfl
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTv0Wjjnsnt1WYoG5AQLIZQ//TDuzhzLs9t52n636kja7JYx5X2uQPaLx
+52/M7wjeV/XXm7kre+ZmL8JhNdb4Y68GGaCNRaImIe7pywbUmlL3yRxnhIjLfc+
zy+6dhz2edD++G5FkIXkT7RsKRyABjOzU4IjKBWpCMlHj+uOMKq+9ufUTuYN6oAA
T1ctQkD92AbPKwzNQbMgcCKx0NO7WGX9RVgTpKU5FfgGhaeze2CpIQVK40hzX/fG
/BgblYd42vwVoZ2glsHhsZkWxUySv6Fk/NX8jaDFCeJRWbCtCGvNhCQNLYKPRVXS
LLSCciiKLIUk0QmT1rWycyYKCy/ofi+UyRG4BtWryppSAUHGzrZYmcDMp/20eQ8t
4DAH6hzsxwOFuxxMGK1RmtGZL2nDZUbwd9mVXClYPvEcEbjDjaZ+WOs9NfkBH+aS
jb64hevo1y1pITugB0SToH66UmFkrTV6COEg9Vn+ngUfefa9t3LVRUbi2PeXxn8v
pTSjK1lmwW1E8rPI/Qey8FWn+oU+AXlON5D31CCt9c+7JpQuZgmsEAUcQER3f3vc
yWEwrOcAJVn/kNU7gDW3yvjWIoKLT1iW77b8E4oggZjqUZMd1YbM7dUtB/thRgcK
CCpL6M36SeQ/ELha4M3V7CaawA12wl6d8auArKNJYF/lgSh2X0isYPpZmepyFymv
nY0XUsb+JCo=
=TIO5
-----END PGP SIGNATURE-----

--Sig_/rGSApU6yCXFNaoH5IWNYQfl--
