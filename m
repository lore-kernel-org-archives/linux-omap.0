From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: Re: [PATCH v7] OMAP4:keypad: PM runtime
Date: Wed, 15 Dec 2010 13:24:16 +0530
Message-ID: <AANLkTimaLQYGp4pasuuvj8Z7pKYHQ+L_VCJmeXu+EACQ@mail.gmail.com>
References: <1292386198-3587-1-git-send-email-a0393217@india.ti.com>
	<20101215053146.GA1822@charu-comp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:43515 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751840Ab0LOHyR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 02:54:17 -0500
In-Reply-To: <20101215053146.GA1822@charu-comp>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Shubhrajyoti D <a0393217@india.ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Wed, Dec 15, 2010 at 11:01 AM, Varadarajan, Charulatha <charu@ti.com=
> wrote:
> * Shubhrajyoti D <a0393217@india.ti.com> [2010-12-15 09:39:58 +0530]:
>
>> From: Abraham Arce <x0066660@ti.com>
>>
>> Enable Runtime PM functionality in OMAP4 driver based on the followi=
ng assumptions
>>
>> A minimal pm runtime get/put approach is implemented in probe/remove=
 calls
>> respectively.
>>
>> - Keyboard controller in wakeup domain so it is always on and
>> =A0 power impact may be minimal
>> - In OMAP4 the device control is at module/device level and ick/fclk=
 level control is
>> =A0 difficult so cutting of clocks will prevent interrupts.
>>
>> Signed-off-by: Abraham Arce <x0066660@ti.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>
> This patch is sent thrice (once with a different subject) but the
> version numbers are the same. It is not clear what is the intention o=
f this
> patch without hwmod database update. Am I missing any more patch here=
?
Yes missed the version.
 I have updated the change logs to be more descriptive and the subject =
line.


Regarding the hwmod database update. That I deffered for reasons
- The clock changes need to be there as the update would mean reset of =
clocks.
- Thought of completing the drivers/input before the hwmod database
and the board changes.
- Also currently the driver relies on the uboot settings for clock
this might remove that dependency.

>
>> ---
>> Updating the changelogs as per Kevin's suggestion
>> =A0drivers/input/keyboard/omap4-keypad.c | =A0 10 +++++++++-
>> =A01 files changed, 9 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/k=
eyboard/omap4-keypad.c
>> index 45bd097..3d35774 100644
>> --- a/drivers/input/keyboard/omap4-keypad.c
>> +++ b/drivers/input/keyboard/omap4-keypad.c
>> @@ -29,6 +29,7 @@
>> =A0#include <linux/io.h>
>> =A0#include <linux/input.h>
>> =A0#include <linux/slab.h>
>> +#include <linux/pm_runtime.h>
>>
>> =A0#include <plat/omap4-keypad.h>
>>
>> @@ -239,8 +240,11 @@ static int __devinit omap4_keypad_probe(struct =
platform_device *pdev)
>> =A0 =A0 =A0 matrix_keypad_build_keymap(pdata->keymap_data, row_shift=
,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_dev->keycode, inpu=
t_dev->keybit);
>>
>> - =A0 =A0 omap4_keypad_config(keypad_data);
>> + =A0 =A0 pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 pm_runtime_get_sync(&pdev->dev);
>>
>> + =A0 =A0 omap4_keypad_config(keypad_data);
>> +
>> =A0 =A0 =A0 error =3D request_irq(keypad_data->irq, omap4_keypad_int=
errupt,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF_TRIGGER_=
RISING,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"omap4-keypad=
", keypad_data);
>> @@ -278,6 +282,10 @@ static int __devexit omap4_keypad_remove(struct=
 platform_device *pdev)
>> =A0 =A0 =A0 struct resource *res;
>>
>> =A0 =A0 =A0 free_irq(keypad_data->irq, keypad_data);
>> +
>> + =A0 =A0 pm_runtime_put_sync(&pdev->dev);
>> + =A0 =A0 pm_runtime_disable(&pdev->dev);
>> +
>> =A0 =A0 =A0 input_unregister_device(keypad_data->input);
>>
>> =A0 =A0 =A0 iounmap(keypad_data->base);
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
