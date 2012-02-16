From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 2/5] gpio/omap: Use devm_ API and add request_mem_region
Date: Thu, 16 Feb 2012 12:41:16 +0530
Message-ID: <CAC83ZvJU1J0oC5DZZt2kQ4WyaX33EMj9MRvuutRFxKTTTexSvw@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
	<1329321854-24490-3-git-send-email-b-cousson@ti.com>
	<CAC83ZvKuOkLKdAVNeoVjRZriouDCGPXPhkZZ+MgcktH+9pYN3w@mail.gmail.com>
	<20120216063533.GA29232@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:44957 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757237Ab2BPHLR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 02:11:17 -0500
Received: by mail-qw0-f52.google.com with SMTP id i31so1959751qaf.4
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 23:11:16 -0800 (PST)
In-Reply-To: <20120216063533.GA29232@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org

On Thu, Feb 16, 2012 at 12:05 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Thu, Feb 16, 2012 at 11:11:52AM +0530, DebBarma, Tarun Kanti wrote=
:
>> Hi Benoit,
>>
>> On Wed, Feb 15, 2012 at 9:34 PM, Benoit Cousson <b-cousson@ti.com> w=
rote:
>> > Replace the regular kzalloc and ioremap with the devm_ equivalent
>> > to simplify error handling.
>> >
>> > Add the missing devm_request_mem_region to reserve the region used
>> > by the driver.
>> >
>> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> > Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> > ---
>> > =A0drivers/gpio/gpio-omap.c | =A0 35 +++++++++++++++--------------=
------
>> > =A01 files changed, 15 insertions(+), 20 deletions(-)
>> >
>> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> > index a0c3e03..c3a9dc8 100644
>> > --- a/drivers/gpio/gpio-omap.c
>> > +++ b/drivers/gpio/gpio-omap.c
>> > @@ -19,7 +19,7 @@
>> > =A0#include <linux/err.h>
>> > =A0#include <linux/clk.h>
>> > =A0#include <linux/io.h>
>> > -#include <linux/slab.h>
>> > +#include <linux/device.h>
>> > =A0#include <linux/pm_runtime.h>
>> > =A0#include <linux/pm.h>
>> >
>> > @@ -1052,23 +1052,19 @@ static int __devinit omap_gpio_probe(struc=
t platform_device *pdev)
>> > =A0 =A0 =A0 =A0struct gpio_bank *bank;
>> > =A0 =A0 =A0 =A0int ret =3D 0;
>> >
>> > - =A0 =A0 =A0 if (!dev->platform_data) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_exit;
>> > - =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 if (!dev->platform_data)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> >
>> > - =A0 =A0 =A0 bank =3D kzalloc(sizeof(struct gpio_bank), GFP_KERNE=
L);
>> > + =A0 =A0 =A0 bank =3D devm_kzalloc(&pdev->dev, sizeof(struct gpio=
_bank), GFP_KERNEL);
>> > =A0 =A0 =A0 =A0if (!bank) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Memory alloc failed\n=
");
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_exit;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> > =A0 =A0 =A0 =A0}
>> >
>> > =A0 =A0 =A0 =A0res =3D platform_get_resource(pdev, IORESOURCE_IRQ,=
 0);
>> > =A0 =A0 =A0 =A0if (unlikely(!res)) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Invalid IRQ resource\=
n");
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> How is the memory allocated to 'bank' getting freed before return -E=
NODEV?
>
> The magic of devm_*() functions. =A0Anything allocated by those funct=
ions is
> automatically freed on either probe failure or driver removal.
OK, thanks.
--
Tarun
>
> g.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
