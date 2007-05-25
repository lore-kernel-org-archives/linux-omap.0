From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 1/2] OMAP: Kill compile warnings
Date: Fri, 25 May 2007 18:17:25 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47FF0C48@dlee13.ent.ti.com>
References: <20070525231215.GL21314@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070525231215.GL21314@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, nishanth menon <menon.nishanth@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


>
>This warning is wrong, and we cannot mark sys_timer as initdata. See
>other mails related to this on this list. I'd assume this will get =
fixed
>once sys_timer is added to the list of things to ignore.
>
>Tony

Yes, I had a similar discussion with Dirk, he passed me few pointers =
yesterday, please see through if it helps....


-----Original Message-----
From: Dirk Behme [mailto:dirk.behme@googlemail.com]=20
Sent: Friday, May 25, 2007 7:56 AM
To: Syed Mohammed, Khasim
Subject: Re: Compiler warning in omap-twl4030keypad.c

Syed Mohammed, Khasim wrote:
> Hi Dirk,
> =20
> Thanks for the info. I was kind of busy with other stuff. Will look =
into=20
> this later this week and submit a patch.

I got the following stuff from Felipe Balbi regarding this in private=20
mail:

1) -- cut --
I don't think the problem is with TI's code for the omap-twl4030. If
you check the definition of struct input_dev, at
include/linux/input.h:

     union {            /* temporarily so while we switching to struct=20
device */
         struct device *parent;
     } dev;

Probably, we just need to wait until they switch to struct device=20
completely.
Or maybe this code will help if we assume that omap_twl4030->cdev->dev
points to the same place as omap_twl4030->dev. I would need any of you
guys to test it:

diff --git a/drivers/input/keyboard/omap-twl4030keypad.c
b/drivers/input/keyboard/omap-twl4030keypad.c
index b96e84f..3776f97 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -254,7 +254,7 @@ static int __init omap_kp_probe(struct
platform_device *pdev)
        omap_twl4030kp->keycodemax      =3D pdata->keymapsize;

        /* Get the debug Device to omap keypad device */
-       dbg_dev =3D &(omap_twl4030kp->dev);
+       dbg_dev =3D omap_twl4030kp->dev.parent;

        ret =3D input_register_device(omap_twl4030kp);
        if (ret < 0) {
-- cut --

2) -- cut --
I forgot to change the text... sorry...
I'm not using the struct class_device here... I'm just accessing the
struct device member inside the union dev.

This is an ugly hack :-P ... but it seems to work.
-- cut --

3) -- cut --
Still a hack, but probably looks better:

diff --git a/drivers/input/keyboard/omap-twl4030keypad.c
b/drivers/input/keyboard/omap-twl4030keypad.c
index b96e84f..5eb3ece 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -50,6 +50,8 @@
#define KEYNUM_MASK            0xFF000000
#define ROWCOL_MASK            0x00FFFFFF

+#define get_dbg_dev(d)         (d).parent
+
static char *switch_name[NUM_ROWS][NUM_COLS] =3D {
        {"S2_L", "S2_D", "S2_S", "S3", "S4", "S23"},
        {"S2_R", "S2_U", "S5", "S6", "S7", "S24"},
@@ -254,7 +256,7 @@ static int __init omap_kp_probe(struct
platform_device *pdev)
        omap_twl4030kp->keycodemax      =3D pdata->keymapsize;

        /* Get the debug Device to omap keypad device */
-       dbg_dev =3D &(omap_twl4030kp->dev);
+       dbg_dev =3D get_dbg_dev(omap_twl4030kp->dev);

        ret =3D input_register_device(omap_twl4030kp);
        if (ret < 0) {

-- cut --

Regards

Dirk
