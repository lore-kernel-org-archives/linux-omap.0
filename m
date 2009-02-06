From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc 2.6.28-rc2] input: twl4030_keypad driver
Date: Thu, 5 Feb 2009 17:11:57 -0800
Message-ID: <200902051711.57605.david-b@pacbell.net>
References: <200901211613.06427.david-b@pacbell.net> <200901291657.50008.david-b@pacbell.net> <BD79186B4FD85F4B8E60E381CAEE1909011A53D4@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:38168 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753562AbZBFBMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 20:12:00 -0500
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909011A53D4@mi8nycmail19.Mi8.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hartleys <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org, OMAP <linux-omap@vger.kernel.org>

On Friday 30 January 2009, hartleys wrote:
> > I'd support an overall cleanup patch that fixes all those things at=
 once.
>=20
> How's this for a starting point? =A0I'm willing to create a cleanup p=
atch
> for all the mach-omap1, mach-omap2, and mach-pxa users.
>=20
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

I think none of the twl4030 keypad users are in mainline, so far...

My first reaction to this is that it's a bit incomplete.
It replaces only the KEY() macro in the $SUBJECT patch:

 - There are two more public ones (for board files):
     * KEY_PERSISTENT flags row/column values to ignore
     * PERSISTENT_KEY (sigh) generates a row/col entry
       with such a marking (instead of a keycode)
 - Plus two driver-internal ones:
     * ROWCOL_MASK to strip R/C from KEY()
     * KEYCODE_MASK to stip the keycode from a KEY()

If there is going to be something reusable across the whole
input subsystem (for drivers that don't need fancy stuff),
it should really address the whole problem...

- Dave


> ---
>=20
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 1249a0c..0879493 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -598,6 +598,14 @@ struct input_absinfo {
> =A0#define KEY_CNT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0(KEY_MAX+1)
> =A0
> =A0/*
> + * Macro to pack the row/col of a key on a matrix keypad and it's as=
sociated
> + * KEY_* code into into an array. =A04 bits are used for both the ro=
w and column
> + * allowing for up to a 16x16 keypad. =A0The row (_r) and column (_c=
) are
> + * interchangable depending on a keypad drivers usage.
> + */
> +#define MATRIX_KEY(_r, _c, _v)=A0(((_r) << 28) | ((_c) << 24) | (_v)=
)
> +
> +/*
> =A0 * Relative axes
> =A0 */
> =A0=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
