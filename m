From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: OMAP* Latest build failures
Date: Wed, 14 Nov 2012 11:08:35 +0100
Message-ID: <50A36DA3.2080201@ti.com>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39849 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161069Ab2KNKIp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 05:08:45 -0500
In-Reply-To: <20121114092643.GG3290@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Russell,

On 11/14/2012 10:26 AM, Russell King - ARM Linux wrote:
> OMAP* allnoconfig fails:
>=20
> arch/arm/mach-omap2/built-in.o: In function `omap_dss_set_min_bus_tpu=
t':
> twl-common.c:(.text+0x1e08): undefined reference to `omap_pm_set_min_=
bus_tput'
> arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_init_postsetu=
p':
> twl-common.c:(.init.text+0x8f8): undefined reference to `omap_pm_if_e=
arly_init'
> arch/arm/mach-omap2/built-in.o: In function `omap_serial_init_port':
> twl-common.c:(.init.text+0x1284): undefined reference to `omap_pm_get=
_dev_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `omap_timer_init':
> twl-common.c:(.init.text+0x1544): undefined reference to `omap_pm_get=
_dev_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `omap2_common_pm_init':
> twl-common.c:(.init.text+0x1af0): undefined reference to `omap_pm_if_=
init'
> arch/arm/mach-omap2/built-in.o: In function `omap2_gpio_dev_init':
> twl-common.c:(.init.text+0x2168): undefined reference to `omap_pm_get=
_dev_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `omap_display_init':
> twl-common.c:(.init.text+0x25cc): undefined reference to `omap_pm_get=
_dev_context_loss_count'

Not sure what is going on here but neither of these are referenced with=
in
twl-common.c directly.

> OMAP4 randconfig fails:
>=20
> arch/arm/mach-omap2/cm_common.c: In function 'cm_register':
> arch/arm/mach-omap2/cm_common.c:42:11: error: 'EINVAL' undeclared (fi=
rst use in this function)
> arch/arm/mach-omap2/cm_common.c:45:11: error: 'EEXIST' undeclared (fi=
rst use in this function)
> arch/arm/mach-omap2/cm_common.c: In function 'cm_unregister':
> arch/arm/mach-omap2/cm_common.c:66:11: error: 'EINVAL' undeclared (fi=
rst use in this function)

I have already sent a patch to fix this:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/131=
341.html

> You know where to find the build information and results...

It seams I can not find the link in my mail archives. Could you point m=
e to
the correct place?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
