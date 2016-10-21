From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 57/84] drivers/usb/dwc3/dwc3-st.c:328:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state'
Date: Fri, 21 Oct 2016 15:29:45 +0300
Message-ID: <87oa2dx4ue.fsf@linux.intel.com>
References: <201610171915.7Qg5kFu7%fengguang.wu@intel.com> <87funvry7k.fsf@linux.intel.com> <CACRpkda5isWVt2H9AvwjER24oBOdvS8M_yqaA5jxUi-aebdxLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkda5isWVt2H9AvwjER24oBOdvS8M_yqaA5jxUi-aebdxLg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kbuild-all@01.org" <kbuild-all-JC7UmRfGjtg@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio@vger.kernel.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
> On Mon, Oct 17, 2016 at 1:50 PM, Felipe Balbi
> <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>
>> kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git t=
esting/next
>>> head:   4281ef86fae986e0a9bb553fb311fe6d8e039118
>>> commit: 040f47e7330045feaa8c06bf2900db2eb2038e80 [57/84] usb: dwc3: Kco=
nfig: allow all glues to build if COMPILE_TEST
>>> config: blackfin-allmodconfig (attached as .config)
>>> compiler: bfin-uclinux-gcc (GCC) 6.2.0
>>> reproduce:
>>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests=
.git/plain/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         git checkout 040f47e7330045feaa8c06bf2900db2eb2038e80
>>>         # save the attached .config to linux build tree
>>>         make.cross ARCH=3Dblackfin
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/usb/dwc3/dwc3-st.c: In function 'st_dwc3_suspend':
>>>>> drivers/usb/dwc3/dwc3-st.c:328:2: error: implicit declaration of func=
tion 'pinctrl_pm_select_sleep_state' [-Werror=3Dimplicit-function-declarati=
on]
>>>      pinctrl_pm_select_sleep_state(dev);
>>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>    drivers/usb/dwc3/dwc3-st.c: In function 'st_dwc3_resume':
>>>>> drivers/usb/dwc3/dwc3-st.c:338:2: error: implicit declaration of func=
tion 'pinctrl_pm_select_default_state' [-Werror=3Dimplicit-function-declara=
tion]
>>>      pinctrl_pm_select_default_state(dev);
>>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>    cc1: some warnings being treated as errors
>>
>> looks like a bug in <linux/pinctrl/consumer.h>. Something along the
>> lines of below should be enough:
>
> I don't think so, that include file looks pretty solid.
>
> I think the actual problem is that dwc3-st.c doesn't
> #include <linux/pinctrl/consumer.h> even if it is using the
> functions from it.

Oh, I missed that there was already a stub further down the
file. Indeed, we need to add a patch to dwc3-st.c.

Sorry for the noise.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYCgo5AAoJEMy+uJnhGpkGQQEP+wVW6jJCFCOqjbWGQweY20AR
55NymJfD1HMVJYZnMsin8vA1z/WmP2FFwaMGnwUrOx4OAdgfsnZeIJfKfd3Gb07J
mL5It0tynmrbtlRUircOzIYhqSdTPvgxA2gQyQ+ZbFNoalZeYEo2lhRIObc/6f+P
aSTYtxYCfe9P+4Ex3zg7W7Dw08AzZsvOaNw1FxcVaGDnpQDszsRGdKKhagci/ADB
b2paPyObrfYR3BnoGUqpHdnorV1+VXWGNhaztdewWeeb8ltmQE85ulY9JuMPRYZn
I7d5iAzEmaDdemcpMCXkH5C1ell26r2/UjQwHwOzt5m2xjTjUs1e3G95qjg/Nn1T
iQfsbKYWbEne3kMTKPTv0AI8+WOaZi7iHRhF/ybBbLjpNmZgmfBKszf3DFPDMZbn
djvFaPCCTQ0GORSAnvxg3ezFlgU53oFIJtSh23t/AH64qF6Q6O5sWQke0ntaWj1A
knZ4YWLeIxGxvPPPk/2yDZ7YkpraLweu8eEz4ywOm/H7orNzI/3DSfP1y0o6f3j4
7VJ2PX4cVTc9kVbXnyU5EwdmCihNvk3JLT9bdIZclgdE+FFYFBjKcM6eK57SzHP2
H7nJW45Q7WsCSWQQhY11DyByKuTsMzIbJuelm+LglQfMy04hxPYMaQTk5Qe543Y4
vbMCxmrQY1qbSb+2srSW
=UFB9
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
