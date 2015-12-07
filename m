From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Subject: Re: [PATCH 04/10] omap_hwspinlock: Replace "hweight_long(i & 0xf) !=
 1" with "!is_power_of_2(i & 0xf)"
Date: Mon, 7 Dec 2015 23:03:30 +0800
Message-ID: <56659FC2.1070906@gmail.com>
References: <1449398006-14450-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <CAK=WgbZGX5zCjDbesh2sNToH3zi10K=ggGKyLgDcXga-FZSLjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbZGX5zCjDbesh2sNToH3zi10K=ggGKyLgDcXga-FZSLjw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

=E5=9C=A8 2015/12/7 19:08, Ohad Ben-Cohen =E5=86=99=E9=81=93:
> Hi,
>=20
> On Sun, Dec 6, 2015 at 12:33 PM, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com=
> wrote:
>>
>> From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
>>
>> Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
>=20
> Please explain why do you think we should make this change.

is_power_of_2 is simple, and faster than "hweightN(x) =3D=3D 1" on most=
 architectures.
And the "& 0xf" operation is unnecessary, we will check whether or not =
greater than 8 behind.

>=20
> Btw, the original code used is_power_of_2, but we thought hweight is
> more explicit so it was adopted.
>=20
> Thanks,
> Ohad.
>=20

---
 drivers/hwspinlock/omap_hwspinlock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/=
omap_hwspinlock.c
index ad2f8ca..1848a4c 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -29,6 +29,7 @@
 #include <linux/hwspinlock.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/log2.h>
=20
 #include "hwspinlock_internal.h"
=20
@@ -125,7 +126,7 @@ static int omap_hwspinlock_probe(struct platform_de=
vice *pdev)
 		goto iounmap_base;
=20
 	/* one of the four lsb's must be set, and nothing else */
-	if (hweight_long(i & 0xf) !=3D 1 || i > 8) {
+	if (!is_power_of_2(i) || i > 8) {
 		ret =3D -EINVAL;
 		goto iounmap_base;
 	}
--=20
