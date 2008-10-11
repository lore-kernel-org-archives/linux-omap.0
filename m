From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Git tree updated to v2.6.27, some issues remain
Date: Sat, 11 Oct 2008 06:47:19 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870239624A53@dbde02.ent.ti.com>
References: <20081010120427.GZ3044@atomide.com>
 <200810101554.34176.david-b@pacbell.net>
 <FCCFB4CDC6E5564B9182F639FC3560870239624A4A@dbde02.ent.ti.com>
 <200810101732.31094.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48027 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148AbYJKBRh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 21:17:37 -0400
In-Reply-To: <200810101732.31094.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


>From: David Brownell [mailto:david-b@pacbell.net]
>Sent: Friday, October 10, 2008 7:33 PM
>To: Pandita, Vikram
>Cc: Steve Sakoman; linux-omap@vger.kernel.org List
>Subject: Re: Git tree updated to v2.6.27, some issues remain
>
>On Friday 10 October 2008, Pandita, Vikram wrote:
>> Somewhere for the T2 interrupts following function has to be run:
>> =A0=A0=A0=A0=A0=A0=A0=A0set_irq_flags(i, IRQF_VALID);
>
>Why do you think that's not being done?
>
>On Beagle, it's clearly done.  And the init sequence is
>the same on Overo.  So I see no reason to think it's not
>being done there too...
>


I did not have your following patch.
Without this patch, the pwrirq does not initialize TWL-USB flag: set_ir=
q_flags(i, IRQF_VALID);=20
And hence the failure.=20

With your patch, you delay the i2c writing and then the set_irq_flags()=
 gets called.


Index: l-o/drivers/i2c/chips/twl4030-pwrirq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- l-o.orig/drivers/i2c/chips/twl4030-pwrirq.c 2008-10-10 13:45:21.000=
000000 -0500
+++ l-o/drivers/i2c/chips/twl4030-pwrirq.c      2008-10-10 18:14:42.000=
000000 -0500
@@ -128,14 +128,24 @@ static int twl4030_pwrirq_thread(void *d
        return 0;
 }

+#include <linux/delay.h>
+
 static int __init twl4030_pwrirq_init(void)
 {
        int i, err;

        twl4030_pwrirq_mask =3D 0xff;

+/* HEY:  core already did this.
+ * But that's surely not why we
+ * sometimes see timeouts here ...
+ */
+for (i =3D 0; i < 5; i++) {
        err =3D twl4030_i2c_write_u8(TWL4030_MODULE_INT, twl4030_pwrirq=
_mask,
                                        TWL4030_INT_PWR_IMR1);
+if (!err) break;
+msleep(10);
+}
        if (err)
                return err;

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
