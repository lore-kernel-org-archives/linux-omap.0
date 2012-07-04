From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Wed, 4 Jul 2012 18:01:35 +0200
Message-ID: <4FF468DF.10108@ti.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com> <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com> <4FDA45F5.9090300@ti.com> <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com> <4FDB387C.7030003@ti.com> <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47750 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab2GDQBy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 12:01:54 -0400
In-Reply-To: <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Hi Paul,

On 07/04/2012 02:48 PM, Paul Walmsley wrote:
> Hi Beno=EEt,
>=20
> On Fri, 15 Jun 2012, Cousson, Benoit wrote:
>=20
>> My point is simple, we should not add any new custom flag when all t=
he=20
>> information to detect such exception are already there in the curren=
t=20
>> data and represent accurately what the HW is doing.
>=20
> This seems like the crux of the issue.  We don't have sufficient=20
> information to detect this exception in our current data, in my view.=
 =20
> The software additionally must know when it can rely on a clockdomain=
=20
> remaining active when the MPU is active.

Yes, indeed, but that will be accurate mostly for OMAP3.
On OMAP4, *in theory* the dynamic dependency should always ensure that =
a
clock domain will be accessible upon any initiator requests.
In that case the notion of a domain active when the MPU is active becom=
e
a little bit less accurate.
Except when we have to force the static dep because of HW bugs
workaround. In that case, we are in the same situation than OMAP3.

> Ideally the hardcoded clockdomain sleep dependencies would be encoded=
, and=20
> we could test the intersection of those and the software-programmable=
=20
> clockdomain sleep dependencies.  But such a change seems too complex =
for=20
> the -rc cycle.  So the updated patch below uses a clockdomain data fl=
ag=20
> for this instead.

Yep, I do agree that encoding that kind of information will require mor=
e
thought and much more code.

I have the feeling that some information about the IP idle behavior
should help figuring out that module like counter_32k, GPIO or mailbox
can be handled without real SW control.

This intermediate approach is thus good for the moment.


> From: Paul Walmsley <paul@pwsan.com>
> Date: Wed, 4 Jul 2012 05:22:53 -0600
> Subject: [PATCH] ARM: OMAP2+: hwmod code/clockdomain data: fix 32K sy=
nc timer

[...]

> @@ -1208,8 +1219,13 @@ static void _idle_sysc(struct omap_hwmod *oh)
>  	sf =3D oh->class->sysc->sysc_flags;
> =20
>  	if (sf & SYSC_HAS_SIDLEMODE) {
> -		idlemode =3D (oh->flags & HWMOD_SWSUP_SIDLE) ?
> -			HWMOD_IDLEMODE_FORCE : HWMOD_IDLEMODE_SMART;
> +		/* XXX What about HWMOD_IDLEMODE_SMART_WKUP? */

What do you mean here?

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
