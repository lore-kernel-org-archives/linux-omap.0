From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] i2c-omap: add mpu wake up latency constraint in i2c
Date: Mon, 26 Apr 2010 17:16:12 -0700
Message-ID: <20100427001612.GU7225@atomide.com>
References: <1271876654-13613-1-git-send-email-khilman@deeprootsystems.com>
 <1271876654-13613-2-git-send-email-khilman@deeprootsystems.com>
 <20100426225851.GR7225@atomide.com>
 <8739yhu8b5.fsf@deeprootsystems.com>
 <20100426231219.GS7225@atomide.com>
 <87sk6hssds.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63415 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab0D0AQM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 20:16:12 -0400
Content-Disposition: inline
In-Reply-To: <87sk6hssds.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [100426 16:27]:
> >> +	if (cpu_is_omap34xx())
> >> +		pd->set_mpu_wkup_lat =3D omap_i2c_set_wfc_mpu_wkup_lat;
>=20
> > BTW, in your version looks like compile will break if CONFIG_ARCH_O=
MAP3
> > is not set.
>=20
> it shouldn't since if !CONFIG_ARCH_OMAP3, cpu_is_omap34xx() is zero
> and that code will not be compiled.

Yes but look how there's no else after #ifdef CONFIG_ARCH_OMAP3..

The if (0) does not help if the code refers something that's
undefined, in this case omap_i2c_set_wfc_mpu_wkup_lat would be
undefined. So I'd assume you'll get something like when
CONFIG_ARCH_OMAP3 is not set:

error: =E2=80=98omap_i2c_set_wfc_mpu_wkup_lat=E2=80=99 undeclared (firs=
t use in this function)

One way to fix that would be to have #else statement with
#define omap_i2c_set_wfc_mpu_wkup_lat	NULL

Anyways, commenting on this just based on my virtual preprocessor,
I have not actually tried it :)
=20
> Anyways, here's updated version which gets rid of both problems.

Thanks! Will add to i2c-omap-for-ben branch.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
