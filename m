From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: IS_ERR_VALUE()
Date: Tue, 12 Mar 2013 20:56:59 +0100
Message-ID: <20130312195659.GR15375@pengutronix.de>
References: <20130312141604.GV4977@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36982 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab3CLT5D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 15:57:03 -0400
Content-Disposition: inline
In-Reply-To: <20130312141604.GV4977@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hello,

On Tue, Mar 12, 2013 at 02:16:04PM +0000, Russell King - ARM Linux wrot=
e:
> I am removing almost all references to the above macro from arch/arm.
> Many of them are wrong.  Some of them are buggy.
>=20
> For instance:
>=20
> int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
> {
>         int div;
>         div =3D gpmc_calc_divider(t->sync_clk);
>         if (div < 0)
>                 return div;
> static int gpmc_set_async_mode(int cs, struct gpmc_timings *t)
> {
> ...
>         return gpmc_cs_set_timings(cs, t);
>=20
> .....
>         ret =3D gpmc_set_async_mode(gpmc_onenand_data->cs, &t);
>         if (IS_ERR_VALUE(ret))
>                 return ret;

Well, gpmc_calc_divider returns -1 on failure, so I agree that it's
wrong to use IS_ERR_VALUE on it.
=20
> So, gpmc_cs_set_timings() thinks any negative return value is an erro=
r,
> but where we check that in higher levels, only a limited range are
> errors... seriously?  Come on guys, get with the program.  Get your
> error checking in order.
=20
Still I don't get what is really wrong in your examples (but I didn't
check all). If a function returning an int is supposed to return 0 on
success and -ESOMEERROR on failure it doesn't matter much if I do (ret =
<
0) or IS_ERR_VALUE(ret). (Even if ret is signed, the check (x) >=3D
(unsigned long)-MAX_ERRNO in IS_ERR_VALUE does the right thing.)

There is only a semantical difference between the two checks for
(unsigned)ret being between MAX_INT+1 and (unsigned)-MAX_ERRNO. But a
value in this range isn't allowed for such a function. So you could als=
o
just check using "if (ret)". All but the previous sentence also apply t=
o
functions returning an int >=3D0 on success and -ESOMEERROR on failure.

So unless I missed something---and if I do, please tell me---your patch
is not about correctness, but "only" about style and consistency?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
