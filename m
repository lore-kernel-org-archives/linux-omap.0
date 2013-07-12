From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Fri, 12 Jul 2013 12:50:52 +0200
Message-ID: <1912926.Zzl227Nulf@avalon>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130711153559.GB2198@dhcp-172-17-186-34.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2584463.QAgveT8Y4T"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54217 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757517Ab3GLKuT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 06:50:19 -0400
In-Reply-To: <20130711153559.GB2198@dhcp-172-17-186-34.nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Tony Prisk <linux@prisktech.co.nz>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, Boris BREZILLON <linux-arm@overkiz.com>, Tomasz Figa <t.figa@samsung.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-pwm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--nextPart2584463.QAgveT8Y4T
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Thursday 11 July 2013 08:36:00 Thierry Reding wrote:
> On Thu, Jul 11, 2013 at 04:37:48PM +0200, Laurent Pinchart wrote:
> [...]
> 
> > diff --git a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> > b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt index
> > de0eaed..be09be4 100644
> > --- a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> > 
> > @@ -4,9 +4,9 @@ Required properties:
> >  - compatible: should be "atmel,tcb-pwm"
> >  - #pwm-cells: Should be 3.  The first cell specifies the per-chip index
> >    of the PWM to use, the second cell is the period in nanoseconds and
> > -  bit 0 in the third cell is used to encode the polarity of PWM output.
> > -  Set bit 0 of the third cell in PWM specifier to 1 for inverse polarity
> > &
> > -  set to 0 for normal polarity.
> > +  the third cell is used to encode the polarity of PWM output. Set the
> > +  PWM_POLARITY_NORMAL flag for normal polarity or the
> > PWM_POLARITY_INVERSED
> > +  flag for inverted polarity. PWM flags are defined in <dt-
bindings/pwm/pwm.h>.
> >  - tc-block: The Timer Counter block to use as a PWM chip.
> 
> >  Example:
>
> I'd prefer for the original text to stay in place and the reference to the
> dt-bindings/pwm/pwm.h file to go below that block. The reason is that
> perhaps somebody will look at an older version of a given DT (with the
> numerical value) and not have access to the include and therefore not know
> which flag was being set by just looking at the documentation. I'm also not
> sure about what the plans are with respect to shipping device trees in a
> separate repository and if they are, whether that repository would ship the
> includes as well.
> 
> Another issue might be that people without access to recent versions of
> DTC won't be able to use the new #include feature, so keeping the
> documentation backwards compatible seems like a good idea.
> 
> Perhaps the include file should even only be mentioned in the general
> PWM binding documentation.
> 
> Perhaps Grant and Rob (Cc'ed) can comment on how they want to handle
> this.

I'll comment on this in a reply to Stephen.

> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> > b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt index
> > ac67c68..bece18b 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> > 
> > @@ -24,8 +24,9 @@ Required properties:
> >       - phandle to PWM controller node
> >       - index of PWM channel (from 0 to 4)
> >       - PWM signal period in nanoseconds
> > 
> > -     - bitmask of optional PWM flags:
> > -        0x1 - invert PWM signal
> > +     - bitmask of optional PWM flags as defined in
> > <dt-bindings/pwm/pwm.h>: +        PWM_POLARITY_NORMAL - normal polarity
> > +	PWM_POLARITY_INVERSED - inverted polarity
> 
> This part mixes spaces and tabs for indentation. Please stick to spaces.

OK.

> > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt
> > b/Documentation/devicetree/bindings/pwm/pwm.txt index 06e6724..38c357a
> > 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > @@ -43,13 +43,15 @@ because the name "backlight" would be used as fallback
> > anyway.> 
> >  pwm-specifier typically encodes the chip-relative PWM number and the PWM
> >  period in nanoseconds.
> > 
> > -Optionally, the pwm-specifier can encode a number of flags in a third
> > cell:
> > -- bit 0: PWM signal polarity (0: normal polarity, 1: inverse polarity)
> > +Optionally, the pwm-specifier can encode a number of flags (defined in
> > +<dt-bindings/gpio/gpio.h>) in a third cell:
> > +- PWM_POLARITY_NORMAL: use the normal PWM signal polarity
> > +- PWM_POLARITY_INVERSED: invert the PWM signal polarity
> 
> You'd have a hard time finding those in the GPIO header. =)

Oops :-)

Will fix.

> > diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
> > new file mode 100644
> > index 0000000..f82be30
> > --- /dev/null
> > +++ b/include/dt-bindings/pwm/pwm.h
> > @@ -0,0 +1,15 @@
> > +/*
> > + * This header provides constants for most PWM bindings.
> > + *
> > + * Most PWM bindings can include a flags cell as part of the PWM 
> > specifier.
> > + * In most cases, the format of the flags cell uses the standard values
> > + * defined in this header.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_PWM_PWM_H
> > +#define _DT_BINDINGS_PWM_PWM_H
> > +
> > +#define PWM_POLARITY_NORMAL			(0 << 0)
> > +#define PWM_POLARITY_INVERSED			(1 << 0)
> > +
> > +#endif
> 
> I think this should go into a patch separate from the DT changes above
> because they'll likely go in via different trees. Or maybe they won't,
> but it'd still be good to introduce the header first and only then
> change the DTS files.

I'll fix that as well. Please see my reply to Stephen for details.

> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> 
> [...]
> 
> >  enum pwm_polarity {
> > 
> > -	PWM_POLARITY_NORMAL,
> > -	PWM_POLARITY_INVERSED,
> > +	PWM_POLARITY_NORMAL = 0,
> > +	PWM_POLARITY_INVERSED = 1,
> 
> That's what the enum values will be by default, so there's no need to be
> explicit here.

Please see my reply to Stephen as well. I'll at least replace this change with 
a comment, or remove enum pwm_polarity completely if that's the preferred 
solution.

-- 
Regards,

Laurent Pinchart

--nextPart2584463.QAgveT8Y4T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQEcBAABAgAGBQJR39+RAAoJEIkPb2GL7hl1z1sIALIbyte28NR+z/9YX7Z9yob5
dlINBHmg/Qb8RXllEI1FpjXPHfItXi127tvddQgDyWogV7yGYf8pUCUjmmYlICBf
lEtOP1eocfPxG8RN7ZQxG1M5yDtXHgREO8h+l8HWW5bfq07E7pKE6znHU6WtBdjc
iPerw08s8Yr2QX8zF/ZlnUHEsNO8KD2LygjP5LZlOokMR1AECcE7dfIII8j/Hqsz
MhNx8chl4ttFGicGvfYsTbEvIdX5vb5cUSeApjHr4ftWFzrKEup/LgUUNGMZdRTe
TSAnYTLtj/ECstoTSKsZj5oULZYe2Ow7u1UL+r9m4zB6fCX9JGfQ4D6dlonlGAM=
=a2PW
-----END PGP SIGNATURE-----

--nextPart2584463.QAgveT8Y4T--

