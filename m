From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 06/19] OMAP3: voltagedomain data: add wakeup domain
Date: Fri, 25 Mar 2011 10:00:50 +0100
Message-ID: <AANLkTimVV8eMUjJhMzAQA32xU0-ubydYw3=GKkYcvZk8@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-7-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50031 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab1CYJAu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 05:00:50 -0400
Received: by qwk3 with SMTP id 3so482701qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 02:00:50 -0700 (PDT)
In-Reply-To: <1300924833-26745-7-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> Add wakeup voltage domain so that the wakeup powerdomain can have an
> associated powerdomain. =A0Note that the scalable flat is not set for
Extra space. s/flat/flag ?

> the this voltagedomain, so it will not be fully initialized like
> scalable voltage domains.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/voltagedomains3xxx_data.c | =A0 =A05 +++++
> =A01 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm=
/mach-omap2/voltagedomains3xxx_data.c
> index 2167ef4..b476ee6 100644
> --- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> @@ -69,9 +69,14 @@ static struct voltagedomain omap3_voltdm_core =3D =
{
> =A0 =A0 =A0 =A0.vdd =3D &omap3_vdd2_info,
> =A0};
>
> +static struct voltagedomain omap3_voltdm_wkup =3D {
> + =A0 =A0 =A0 .name =3D "wkup",
> +};
> +
> =A0static struct voltagedomain *voltagedomains_omap3[] __initdata =3D=
 {
> =A0 =A0 =A0 =A0&omap3_voltdm_mpu,
> =A0 =A0 =A0 =A0&omap3_voltdm_core,
> + =A0 =A0 =A0 &omap3_voltdm_wkup,
> =A0 =A0 =A0 =A0NULL,
> =A0};
>
> --
> 1.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
