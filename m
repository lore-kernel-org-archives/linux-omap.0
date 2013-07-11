From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Thu, 11 Jul 2013 12:32:46 -0700
Message-ID: <20130711193245.GB17212@dhcp-172-17-186-34.nvidia.com>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20130711153559.GB2198@dhcp-172-17-186-34.nvidia.com>
 <51DEF078.1010408@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:39628 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab3GKTcy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 15:32:54 -0400
Content-Disposition: inline
In-Reply-To: <51DEF078.1010408@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, Grant Likely <grant.likely@linaro.org>, Boris BREZILLON <linux-arm@overkiz.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2013 at 11:50:48AM -0600, Stephen Warren wrote:
> On 07/11/2013 09:36 AM, Thierry Reding wrote:
> > On Thu, Jul 11, 2013 at 04:37:48PM +0200, Laurent Pinchart wrote:=20
> > [...]
> >> diff --git
> >> a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> >> b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt index
> >> de0eaed..be09be4 100644 ---
> >> a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt +++
> >> b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt @@ -4,9
> >> +4,9 @@ Required properties: - compatible: should be
> >> "atmel,tcb-pwm" - #pwm-cells: Should be 3.  The first cell
> >> specifies the per-chip index of the PWM to use, the second cell
> >> is the period in nanoseconds and -  bit 0 in the third cell is
> >> used to encode the polarity of PWM output. -  Set bit 0 of the
> >> third cell in PWM specifier to 1 for inverse polarity & -  set to
> >> 0 for normal polarity. +  the third cell is used to encode the
> >> polarity of PWM output. Set the +  PWM_POLARITY_NORMAL flag for
> >> normal polarity or the PWM_POLARITY_INVERSED +  flag for inverted
> >> polarity. PWM flags are defined in <dt-bindings/pwm/pwm.h>. -
> >> tc-block: The Timer Counter block to use as a PWM chip.
> >>=20
> >> Example:
> >=20
> > I'd prefer for the original text to stay in place and the reference
> > to the dt-bindings/pwm/pwm.h file to go below that block.
>=20
> I disagree here. The whole point of creating header files for the
> constants in binding definitions was so that you wouldn't have to
> duplicate all the values into the binding definitions. Rather, you'd
> simply say "see <dt-bindings/xxx.h>".

But that's not something that this patch solves. And it could be solved
even in the absence of the header file defining the symbolic constants.
If all the standard flags that dt-bindings/pwm/pwm.txt now specifies
were to be listed in pwm.txt (they actually are) then referring to that
document as the canonical source works equally well.

> > The reason is that perhaps somebody will look at an older version
> > of a given DT (with the numerical value) and not have access to the
> > include and therefore not know which flag was being set by just
> > looking at the documentation.
>=20
> It's pretty trivial to find the header that defines the values; just
> grab the latest source. If you're looking at an old version of the
> .dts file, it's almost certain that's within the context of an old
> Linux kernel soruce tree, in which case you trivially have access to
> the old version of the binding document that spelled out the values.
>=20
> > I'm also not sure about what the plans are with respect to
> > shipping device trees in a separate repository and if they are,
> > whether that repository would ship the includes as well.
>=20
> It would have to. That separate repository would be upstream for
> <dt-bindings/> files, which would be imported into the kernel
> periodically as drivers wanted to make use of any new headers/values
> defined there.

If we can take both of the above for granted, then sure, let's refer to
the header from within the generic pwm.txt file and add a reference to
that in bindings for drivers that use the standard flags.

> > Another issue might be that people without access to recent
> > versions of DTC won't be able to use the new #include feature, so
> > keeping the documentation backwards compatible seems like a good
> > idea.
>=20
> The dtc source tree is duplicated into the kernel source tree, so that
> isn't an issue for now.
>=20
> Besides, the dtc version is an entirely unrelated issue to how the
> documentation is written.

Well, not really. If the documentation specifies the binding in a way
that the DTC can't handle that's still a problem. People will end up
with a DTS that their DTC can't compile. I guess that can be resolved
by adding a note to the upstream device tree repository about the
minimum required version of DTC.

> > Perhaps the include file should even only be mentioned in the
> > general PWM binding documentation.
>=20
> I wondered about that too. It's slightly indirect in that you'd read
> foo-pwm.txt which would say something like:
>=20
> -----
> the third cell encodes standard PWM flags, as defined by the core PWM
> binding in pwm.txt in this directory.
> -----
>=20
> and pwm.txt would say:
>=20
> -----
> The PWM specifier should include a flags cell to contain standard PWM
> flags. Values for that cell are defined in <dt-bindings/pwm/pwm.h>.
> -----
>=20
> Which is somewhat like following a lot of symlinks. Still, I agree
> that's arguably the correct thing to do.

Yes, I like this a whole lot better than the current situation. It gets
us almost automatic consistency, which is harder to do with the current
approach.

Thierry

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR3whdAAoJEN0jrNd/PrOhMgMQAIYVFsOk3w8USqRZq4g3kOI0
sy5s77m4wlKhFnCPs/39/vkHZIeY7kWMMW1AcqkrLxFS1xe+nSv0sUz6VthVCdmW
U7uLCEcDvebL+Z2gj3WxyQKPODenQ+EbJ51Lse0XRFt1/tP3htxybswjoW0rfQNk
fSfiLfsy1sKaWOMwpNVn/Cw+NCDmKPibMYAIlhGq6HhtAqUkozOPhMKiMKPfLAKj
qbdbNkDSRsQkMN5grCCK6PMOchBrV6KE1aCCpXsPFpfT4tzEHc+ucjmS43LrpclT
QF+0ODhwj5Ps35EvXcj9nKr0uu4u33TCyL7PB8wY5OcbLBBUUZN6g+wOas31Mdyu
9ZwrO02aprWHjP+gYJoC6y319FbOckkEVN9+ESKMC6T8zjAIQSu3SkFmcvmDIZhv
Xw81tWjiNWkBobpzhrPYLQYiCuGDm/RbhcIYB89Aw+eTRu5QfKKbysmThHcr4bRF
phWiUA1a2Dz6W+PPEHmy0fw4O97coZ6X4N39KbXv1PQaBx+TPzSYPx1ZoGi31bSz
OdTEZS/uBpkN3bezyuKSPs6U5m6r2zurUeDbAREQztX2BxaBoCqR+kWi6SH1DUuh
PaEhKjr+2NEpw7tNBUL1qdQDy2kF59l9Kc6rPdHlDLxvsJSpuTR/lJ4+9+xIuPB9
/50t4Q2XO/EwPZ6ctJ9N
=XGkO
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
