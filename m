From: Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [balbi-usb:testing/next 57/84] drivers/usb/dwc3/dwc3-st.c:328:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state'
Date: Mon, 17 Oct 2016 14:50:39 +0300
Message-ID: <87funvry7k.fsf@linux.intel.com>
References: <201610171915.7Qg5kFu7%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <201610171915.7Qg5kFu7%fengguang.wu@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: kbuild-all@01.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

kbuild test robot <fengguang.wu@intel.com> writes:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git tes=
ting/next
> head:   4281ef86fae986e0a9bb553fb311fe6d8e039118
> commit: 040f47e7330045feaa8c06bf2900db2eb2038e80 [57/84] usb: dwc3: Kconf=
ig: allow all glues to build if COMPILE_TEST
> config: blackfin-allmodconfig (attached as .config)
> compiler: bfin-uclinux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.g=
it/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 040f47e7330045feaa8c06bf2900db2eb2038e80
>         # save the attached .config to linux build tree
>         make.cross ARCH=3Dblackfin=20
>
> All errors (new ones prefixed by >>):
>
>    drivers/usb/dwc3/dwc3-st.c: In function 'st_dwc3_suspend':
>>> drivers/usb/dwc3/dwc3-st.c:328:2: error: implicit declaration of functi=
on 'pinctrl_pm_select_sleep_state' [-Werror=3Dimplicit-function-declaration]
>      pinctrl_pm_select_sleep_state(dev);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/usb/dwc3/dwc3-st.c: In function 'st_dwc3_resume':
>>> drivers/usb/dwc3/dwc3-st.c:338:2: error: implicit declaration of functi=
on 'pinctrl_pm_select_default_state' [-Werror=3Dimplicit-function-declarati=
on]
>      pinctrl_pm_select_default_state(dev);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

looks like a bug in <linux/pinctrl/consumer.h>. Something along the
lines of below should be enough:

diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consu=
mer.h
index d7e5d608faa7..c8aa03aa1c42 100644
=2D-- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -44,7 +44,9 @@ extern void devm_pinctrl_put(struct pinctrl *p);
 extern int pinctrl_pm_select_default_state(struct device *dev);
 extern int pinctrl_pm_select_sleep_state(struct device *dev);
 extern int pinctrl_pm_select_idle_state(struct device *dev);
=2D#else
+#endif
+
+#else /* !CONFIG_PINCTRL */
 static inline int pinctrl_pm_select_default_state(struct device *dev)
 {
        return 0;
@@ -57,9 +59,6 @@ static inline int pinctrl_pm_select_idle_state(struct dev=
ice *dev)
 {
        return 0;
 }
=2D#endif
=2D
=2D#else /* !CONFIG_PINCTRL */
=20
 static inline int pinctrl_request_gpio(unsigned gpio)
 {


Linus, do you want me to send this as a proper patch? It's pretty clear
that currently we can have build regressions with these helpers. Was it
a conscious choice to not provide stubs or just a slip?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYBLsPAAoJEMy+uJnhGpkGtWIQAIZOyLR2nyDW3/wqgLZGVb4J
hVSY4Da7KJqW69eROGDJvxe/jh9hzJaYx/nRJdgw3NUhOAWH/cvALvwlslAcOR5J
3FwxXyLCqTCinSoh2ZC2WzX6uqi/GlZWAuuFUGTw59Jz0TZMw3e1YDUDH97CVULD
jT0T28miFXcbt58a5ljsDKMD4e5AM/0gTtWcDh4IBP9nDG9SEgH74D9GxVHjVBIk
M7f7WVPTXpnm/DD7F9IMpZfh5ebGuksPqQU3QUA8zvk3rhR38y/J+4JDycEQNReF
N5uPsg4z/UIKmLnN0Vxx2Xkd87q4j7s+mo4SZgZm6n0EOlMSKhFk96XUxL4gqWSE
+b4zfcb6HGDGVvJWNSRWFj74tKW4caZmE0pez3cbYZPQ0xVpYyrFJJJvLEp3Oqfo
IRmaut/1XHUC4XtLGbY7S8+uxdG9eBLSTvfRTfjlduMOVbkkQXkbWeEUBo3qt6y+
p259to5wnz/KLisdw0f4CugBmzgAJT4hNrdnwz5xs3H/B33ulhoh10vMf8p0y+gZ
331pnARj8n1GleVR042jBs3qwasi4B5+aNX6DlRREE22jn17ECOjBJjrXNxaLN5w
9WPpHXZ0oK7L61hrd9sSmX7jvy8UOWwyGPmESi6iixcI4bSep9kbWGZzNLu2g26P
Q6xlHt812RDTtQM4vsiV
=x8OS
-----END PGP SIGNATURE-----
--=-=-=--
