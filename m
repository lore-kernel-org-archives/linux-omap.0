From: Abraham Arce <abraham.arce.moreno@gmail.com>
Subject: Re: [PATCH v4 2/4] OMAP4: Keyboard device registration
Date: Tue, 22 Jun 2010 17:36:37 -0500
Message-ID: <AANLkTimMbpmHZ5kh1fzuQYZsNQ22QqCKjZDoourCJtMY@mail.gmail.com>
References: <x0066660@ti.com>
	<1276704555-30625-1-git-send-email-x0066660@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5BEFCC3@dbde02.ent.ti.com>
	<87mxutl64d.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <87mxutl64d.fsf@deeprootsystems.com>
Sender: linux-input-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Varadarajan, Charulatha" <charu@ti.com>
Cc: "Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Charu, Kevin,

On Thu, Jun 17, 2010 at 4:08 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Varadarajan, Charulatha" <charu@ti.com> writes:

[...]

>>> +
>>> + =A0 =A0oh =3D omap_hwmod_lookup(oh_name);
>>
>> Use omap_hwmod_for_each_by_class() instead of lookup by name.
>
> Yes.

how about handling all keypad data in devices.c and add
omap_init_keypad() under omap2_init_devices()?

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/device=
s.c

+#ifdef CONFIG_ARCH_OMAP4
+static int sdp4430_keymap[] =3D {
+	KEY(0, 0, KEY_E),
+	KEY(0, 1, KEY_R),

[...]

+	KEY(7, 6, KEY_OK),
+	KEY(7, 7, KEY_DOWN),
+};
+
+static struct matrix_keymap_data sdp4430_keymap_data =3D {
+	.keymap			=3D sdp4430_keymap,
+	.keymap_size		=3D ARRAY_SIZE(sdp4430_keymap),
+};
+
+static struct omap4_keypad_platform_data sdp4430_keypad_data =3D {
+	.keymap_data		=3D &sdp4430_keymap_data,
+	.rows			=3D 8,
+	.cols			=3D 8,
+};
+
+struct omap_device_pm_latency omap_keyboard_latency[] =3D {
+	{
+		.deactivate_func =3D omap_device_idle_hwmods,
+		.activate_func   =3D omap_device_enable_hwmods,
+		.flags =3D OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+static int omap4_init_keypad(struct omap_hwmod *oh, void *user)
+{
+	struct omap_device *od;
+	unsigned int id =3D -1;
+	char *name =3D "omap4-keypad";
+
+	if (!oh)
+		pr_err("Could not look up omap4 kbd\n");
+
+	od =3D omap_device_build(name, id, oh, &sdp4430_keypad_data,
+			sizeof(struct omap4_keypad_platform_data),
+			omap_keyboard_latency,
+			ARRAY_SIZE(omap_keyboard_latency), 0);
+	WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
+		name, oh->name);
+
+	return 0;
+}
+
+static int omap_init_keypad(void)
+{
+	if (!cpu_is_omap44xx())
+		return -ENODEV;
+
+	return omap_hwmod_for_each_by_class("kbd", omap4_init_keypad, NULL);
+}
+#endif /* KEYBOARD CONFIG_ARCH_OMAP4 */
+
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODU=
LE)

 #define MBOX_REG_SIZE   0x120
@@ -807,6 +931,7 @@ static int __init omap2_init_devices(void)
 	 */
 	omap_hsmmc_reset();
 	omap_init_camera();
+	omap_init_keypad();
 	omap_init_mbox();
 	omap_init_mcspi();
 	omap_hdq_init();

>>> + =A0 =A0pdata->base =3D oh->_rt_va;
>>> + =A0 =A0pdata->irq =3D oh->mpu_irqs[0].irq;
>>
>> Use platform_get_() APIs to get base addr & irq instead of passing
>> it as pdata
>
> Yes.
>
> Thanks Charu!
>
> For all those working on OMAP hwmod conversions, please take some tim=
e
> to read the reviews of the other hwmod conversions that have already
> been posted and reviewed (some of them multiple times) so we don't
> keep duplicating the same mistakes and wasting review time.
>

These will be the changes....

diff --git a/drivers/input/keyboard/omap4-keypad.c
b/drivers/input/keyboard/omap4-keypad.c
index 975f8bb..c606e36 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c

@@ -158,12 +213,14 @@ static int __devinit omap4_keypad_probe(struct
platform_device *pdev)
 		return -EINVAL;
 	}

-	if (!pdata->base) {
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
 		dev_err(&pdev->dev, "no base address specified\n");
 		return -EINVAL;
 	}

-	if (!pdata->irq) {
+	irq =3D platform_get_irq(pdev, 0);
+	if (!irq) {
 		dev_err(&pdev->dev, "no keyboard irq assigned\n");
 		return -EINVAL;
 	}

@@ -184,9 +240,22 @@ static int __devinit omap4_keypad_probe(struct
platform_device *pdev)
 		return -ENOMEM;
 	}

-	keypad_data->base =3D pdata->base;
-	keypad_data->irq =3D pdata->irq;
+	mem =3D request_mem_region(res->start,
+			resource_size(res), pdev->name);
+	if (!mem) {
+		dev_err(&pdev->dev, "no mem region available\n");
+		return -ENOMEM;
+		goto err_free_keypad;
+	}
+
+	keypad_data->base =3D ioremap(res->start, resource_size(res));
+	if (!keypad_data->base) {
+		dev_err(&pdev->dev, "can't ioremap mem resource.\n");
+		error =3D -ENOMEM;
+		goto err_free_memreg;
+	}

+	keypad_data->irq =3D irq;

Best Regards
Abraham
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
