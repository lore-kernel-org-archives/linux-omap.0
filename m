From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP2+: Fix Wake-up power domain power status
Date: Sat, 30 Jun 2012 09:57:20 +0530
Message-ID: <CAMQu2gxS8+xXUvAqMxcb3sq5dNinEXgtSphJh0TbfAX0uEGvhg@mail.gmail.com>
References: <1341003892-14424-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:56741 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750838Ab2F3E1m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Jun 2012 00:27:42 -0400
Received: by qcad1 with SMTP id d1so898447qca.30
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 21:27:41 -0700 (PDT)
In-Reply-To: <1341003892-14424-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

+ Paul, Rajendra,

On Sat, Jun 30, 2012 at 2:34 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> Note: Re-sending with updated kernel doc.
>
> The wake-up power domain is an alway-on power domain and so this powe=
r domain
> does not have a power state status (PM_PWSTST_xxx) register that indi=
cates the
> current state. However, during the registering of the wake-up power d=
omain the
> state of the domain is queried by calling pwrdm_read_pwrst(). This ac=
tually
> tries to read a register that does not exist and returns a value of 0=
 that
> indicates that the current state is OFF. The OFF state count of the w=
ake-up
> power domain is then set to 1 and the current state to OFF. Both of w=
hich are
> incorrect.
>
> To fix this, if a power domain only supports the ON state, do not att=
empt to
> read the power state status register and simply return ON as the curr=
ent power
> state.
>
> This is based upon Tony's current linux-omap master branch.
>
> Testing:
> - Boot tested on OMAP4460 panda.
> - Boot tested on OMAP3430 beagle and validated CORE RET still working=
 (using
> =A0Paul's 32k timer patch [1]).
>
> [1] http://marc.info/?l=3Dlinux-omap&m=3D134000053229888&w=3D2
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
> =A0arch/arm/mach-omap2/powerdomain.c | =A0 =A06 +++++-
> =A01 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index eefe179..69b36e1 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -526,7 +526,8 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwr=
dm)
> =A0*
> =A0* Return the powerdomain @pwrdm's current power state. =A0 =A0 =A0=
 =A0Returns -EINVAL
> =A0* if the powerdomain pointer is null or returns the current power =
state
> - * upon success.
> + * upon success. Note that if the power domain only supports the ON =
state
> + * then just return ON as the current state.
> =A0*/
> =A0int pwrdm_read_pwrst(struct powerdomain *pwrdm)
> =A0{
> @@ -535,6 +536,9 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
> =A0 =A0 =A0 =A0if (!pwrdm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> + =A0 =A0 =A0 if (pwrdm->pwrsts =3D=3D PWRSTS_ON)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PWRDM_POWER_ON;
> +
The patch as such is correct but just wondering whether we should
have some flag rather than above check.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
