From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/4] mfd: twl6030-irq: migrate to IRQ threaded handler
Date: Wed, 24 Jul 2013 13:50:11 +0100
Message-ID: <20130724125011.GM26801@laptop>
References: <1374595624-15054-1-git-send-email-grygorii.strashko@ti.com>
 <1374595624-15054-2-git-send-email-grygorii.strashko@ti.com>
 <20130724104945.GH26801@laptop>
 <51EFC072.9070702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:56789 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab3GXMuQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jul 2013 08:50:16 -0400
Received: by mail-ea0-f169.google.com with SMTP id h15so219730eak.14
        for <linux-omap@vger.kernel.org>; Wed, 24 Jul 2013 05:50:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51EFC072.9070702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Ruslan Bilovol <ruslan.bilovol@ti.com>, linux-kernel@vger.kernel.org, Naga Venkata Srikanth V <vnv.srikanth@samsung.com>, Oleg_Kosheliev <oleg.kosheliev@ti.com>

> >>+	if (ret) {
> >>+		pr_warn("%s: I2C error %d reading PIH ISR\n", __func__, ret);
> >
> >Does the user really care which function we're returning from.
> >
> >Would it be better if you replace '__func__' with the device name?
>=20
> This module hasn't been converted to the device yet:(
> (I mean "interrupt-controller").
> But I'm thinking about it as the next step :) and then It will be
> absolutely reasonable change to replace pr_*() with dev_*() and
> remove __func__.

I don't mean anything as compicated as that for 'this' patch. (NB: See =
my
comment in subsequent patches about creating a 'struct twl6030' where
you could store 'struct dev'.) In this patch I mean litterally
replacing "%s: ", with "tw16030_irq: ". Simples. :)

> Now, the pointer on "dev" (in our case "twl-core" device) isn't passe=
d
> in IRQ handler, so It can't be used here.
>=20
> Of course it can be done, but would it make code better?
> My opinion - no.

> >>+	if (sts.bytes[2] & 0x10)
> >>+		sts.bytes[2] |=3D 0x08;
> >>
> >>-		for (i =3D 0; sts.int_sts; sts.int_sts >>=3D 1, i++) {
> >>-			local_irq_disable();
> >>-			if (sts.int_sts & 0x1) {
> >>-				int module_irq =3D twl6030_irq_base +
> >>+	for (i =3D 0; sts.int_sts; sts.int_sts >>=3D 1, i++)
> >>+		if (sts.int_sts & 0x1) {
> >
> >I'm a little confused by this. Where does sts.int_sts come from?
>=20
> See my comment above, pls

Okay, that's my fault for not understanding unions properly as I've
never had to use one, but now I do, thanks.

> >>@@ -437,10 +386,13 @@ int twl6030_exit_irq(void)
> >>  {
> >>  	unregister_pm_notifier(&twl6030_irq_pm_notifier_block);
> >>
> >>-	if (twl6030_irq_base) {
> >>+	if (!twl6030_irq_base) {
> >>  		pr_err("twl6030: can't yet clean up IRQs?\n");
> >>  		return -ENOSYS;
> >>  	}
> >>+
> >>+	free_irq(twl_irq, NULL);
> >>+
> >
> >If request_threaded_irq() fails, isn't there a chance that
> >twl6030_irq_base will be allocated, but twl_irq will still be
> >undefined?
>=20
> Yes. A mess is here (historically:), thanks. Will use twl_irq
> instead of twl6030_irq_base (I did it, actually, in patch [3]:).

Yes, I saw it. It would be better if you still fixed up this patch to
be correct though. Even if you break it out and add it as [PATCH 1/x].

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
