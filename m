From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Date: Mon, 22 May 2017 12:27:19 +0200
Message-ID: <20170522102719.yzqujz327hv5zu7r@earth>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tjpa2ifnbroetnta"
Return-path: <rtc-linux+bncBDZOX5PQ7YDBBCX2RLEQKGQECJK3RVA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170521220212.1404-4-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Felipe Balbi <bal>
List-Id: linux-omap@vger.kernel.org


--tjpa2ifnbroetnta
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

Hi,

On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> ---
> [...]
>  drivers/power/supply/twl4030_charger.c  | 2 +-
> [...]

Acked-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

-- Sebastian

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--tjpa2ifnbroetnta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkivQQACgkQ2O7X88g7
+pr+JBAAgfqciZwOxlKdgg1Ffp+cnY74bMb+kL52A5+T4mkbwSyRNm944UI4PbYg
y4k137b5tcH/YyF66lqI+C3pXQzbrMBvO0rLfqHCB0HKRd7akG8AKSwhe7TA52MH
zt58f9un02aqyyNceNOzr/jg2DAFCQP3q/w3ZscyoehFC2rezpCbX8Vb2PTu81hR
9STMybSMS0K/B1D9X5gmBIhZ8ofTPDZDirPUNgdn4zD26iNsEnWbPc/5qCL2ecFU
H9RWUUmUdkYxtyjmWVa2fktT66VYhq4Ku6BiD8E6f7qwtQ+WqjVglTLx6s+PdxWI
tbgbf/6BVLw+ogSIvEuDdXlZeZVM7e4qUjcRw6FnzsqgyBDMbB+SqIpnbRYHUwsH
Y4Jh6yD9M6X0YA71B7i2nkUIRoYFmEzRI+Evk5vchFTZIyW5V4nu95BcsgTH/ZVZ
le93GTruiQSSZkLS471xqZ+XCgSMIE052sJLhLRjzT+PjLqs3F0b8fpg53/wITcJ
Rr06jGF/k0YdgpBGHexUiA+3frXdkdY5bx9wKh9C7y1JnjR6ZME4FN2rhkecZHX2
VxwW9ra2g9wdJn0SL/eZNtb79FKNCigQik5grIG7kw55bdybGXgGZMHRvYbN91eU
wccj0CYykJ9wKuRfttth4jVCwoMV1vt2TvYcrUfMv9eTEd7VeTU=
=JcW1
-----END PGP SIGNATURE-----

--tjpa2ifnbroetnta--
