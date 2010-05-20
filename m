From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] OMAP2/3: Keypad: Fix memory leak
Date: Thu, 20 May 2010 20:46:33 +0530
Message-ID: <AANLkTineC6_hndRJGOrF9DdSfXGZRdsc0QVNAkImTYCI@mail.gmail.com>
References: <1274365792-24938-1-git-send-email-manjugk@ti.com>
	<AANLkTiludDGO8EW_siAzxqo2bC6SNmtnMTV932D1Wumv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35128 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab0ETPQz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 11:16:55 -0400
Received: by pva18 with SMTP id 18so1564277pva.19
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2010 08:16:54 -0700 (PDT)
In-Reply-To: <AANLkTiludDGO8EW_siAzxqo2bC6SNmtnMTV932D1Wumv@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Damodar <x0132156@ti.com>, Tony Lindgren <tony@atomide.com>

On Thu, May 20, 2010 at 8:41 PM, Vimal Singh <vimal.newwork@gmail.com> =
wrote:
> On Thu, May 20, 2010 at 7:59 PM, Manjunatha GK <manjugk@ti.com> wrote=
:
>> From: Damodar <x0132156@ti.com>
>>
>> This patch corrects Possible memory leak of 'input' allocated
>> through input_allocate_device and Suspicious dereference of pointer =
'pdata'
>> before NULL check
>>
>> Signed-off-by: Damodar Santhapuri <x0132156@ti.com>
>> Signed-off-by: Manjunatha GK <manjugk@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>>
>> ---
>> =A0drivers/input/keyboard/twl4030_keypad.c | =A0 21 +++++++++++++---=
-----
>> =A01 files changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input=
/keyboard/twl4030_keypad.c
>> index 7aa59e0..aa13aec 100644
>> --- a/drivers/input/keyboard/twl4030_keypad.c
>> +++ b/drivers/input/keyboard/twl4030_keypad.c
>> @@ -326,30 +326,34 @@ static int __devinit twl4030_kp_program(struct=
 twl4030_keypad *kp)
>> =A0*/
>> =A0static int __devinit twl4030_kp_probe(struct platform_device *pde=
v)
>> =A0{
>> - =A0 =A0 =A0 struct twl4030_keypad_data *pdata =3D pdev->dev.platfo=
rm_data;
>> - =A0 =A0 =A0 const struct matrix_keymap_data *keymap_data =3D pdata=
->keymap_data;
>> + =A0 =A0 =A0 struct twl4030_keypad_data *pdata;
>> + =A0 =A0 =A0 const struct matrix_keymap_data *keymap_data;
>> =A0 =A0 =A0 =A0struct twl4030_keypad *kp;
>> =A0 =A0 =A0 =A0struct input_dev *input;
>> =A0 =A0 =A0 =A0u8 reg;
>> =A0 =A0 =A0 =A0int error;
>> -
>> + =A0 =A0 =A0 if (!pdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Invalid platorm_devic=
e\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
>> =A0 =A0 =A0 =A0if (!pdata || !pdata->rows || !pdata->cols ||
>> =A0 =A0 =A0 =A0 =A0 =A0pdata->rows > TWL4030_MAX_ROWS || pdata->cols=
 > TWL4030_MAX_COLS) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "Invalid platform=
_data\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> =A0 =A0 =A0 =A0}
>> -
>> + =A0 =A0 =A0 keymap_data =3D pdata->keymap_data;
>> =A0 =A0 =A0 =A0kp =3D kzalloc(sizeof(*kp), GFP_KERNEL);
>> + =A0 =A0 =A0 if (!kp)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENOMEM;
>> =A0 =A0 =A0 =A0input =3D input_allocate_device();
>> - =A0 =A0 =A0 if (!kp || !input) {
>> + =A0 =A0 =A0 if (!input) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
>
> If I am not mistaking you should still goto 'err1', as
> 'input_register_device' is yet not called.

Sorry, my ignorance that device is yet not allocated.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
