From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] OMAP3: Fix 34xx/35xx revision check
Date: Tue, 30 Sep 2008 22:05:28 +0100
Message-ID: <yw1xmyhpjqef.fsf@thrashbarg.mansr.com>
References: <1222807935-27378-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:52479 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbYI3VFh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2008 17:05:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KkmPY-00025i-JC
	for linux-omap@vger.kernel.org; Tue, 30 Sep 2008 21:05:36 +0000
Received: from thrashbarg.mansr.com ([78.86.181.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 30 Sep 2008 21:05:36 +0000
Received: from mans by thrashbarg.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 30 Sep 2008 21:05:36 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Mans Rullgard <mans@mansr.com> writes:

> The 35xx TRM lists incorrect values for the VERSION field of the
> CONTROL_IDCODE register.  The correct values are those listed in
> the 34xx TRM.
>
> Correct message on boot verified on ES2.1 and ES3.0.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  arch/arm/mach-omap2/id.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index ab7a6e9..9f72ae6 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -162,14 +162,15 @@ void __init omap34xx_check_revision(void)
>  	/*
>  	 * Detection for 34xx ES2.0 and above can be done with just
>  	 * hawkeye and rev. See TRM 1.5.2 Device Identification.
> -	 * Note that rev cannot be used directly as ES1.0 uses value 0.
> +	 * The 35xx TRM lists incorrect values for the revision number.
> +	 * Correct values are documented in the 34xx TRM.
>  	 */
>  	idcode =3D read_tap_reg(OMAP_TAP_IDCODE);
>  	hawkeye =3D (idcode >> 12) & 0xffff;
>  	rev =3D (idcode >> 28) & 0xff;
>
>  	if (hawkeye =3D=3D 0xb7ae)
> -		system_rev =3D 0x34300034 | ((1 + rev) << 12);
> +		system_rev =3D 0x34300034 | (rev << 12);
>
>  out:
>  	switch (system_rev) {

=46orget this.  A fix was already in the tree, but not merged to my
branch.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
