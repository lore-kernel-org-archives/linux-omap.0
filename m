From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: [PATCH 3/7] omap4: l2x0: Fix init parameter for ES2.0
Date: Mon, 13 Sep 2010 21:58:10 +0530
Message-ID: <AANLkTik3wD+A-EC0Bs79CT53=AP8nC0Bxg3FDxm7GO16@mail.gmail.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com> <1284031395-25988-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53144 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750920Ab0IMQe5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Sep 2010 12:34:57 -0400
Received: by mail-wy0-f176.google.com with SMTP id 23so6537003wyf.21
        for <linux-omap@vger.kernel.org>; Mon, 13 Sep 2010 09:34:51 -0700 (PDT)
In-Reply-To: <1284031395-25988-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com

On Thu, Sep 9, 2010 at 4:53 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On ES2.0 the L2 cache init parameter ineeds to be changed to take
> care of cache size. The cache size is 1MB on ES2.0 vs 512KB on ES1.0
>
> This patch fixes the init parameter to update the same using
> dynamic cpu version check
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap4-common.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2=
/omap4-common.c
> index 13dc979..2b32229 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -64,7 +64,10 @@ static int __init omap_l2_cache_init(void)
> =A0 =A0 =A0 =A0 * 32KB way size, 16-way associativity,
> =A0 =A0 =A0 =A0 * parity disabled
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
> + =A0 =A0 =A0 if (omap_rev() =3D=3D OMAP4430_REV_ES2_0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2x0_init(l2cache_base, 0x0e070000, 0xc=
0000fff);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2x0_init(l2cache_base, 0x0e050000, 0xc=
0000fff);


It's probably better to invert this check - you need 512 kB on ES1
alone, but ES2 and newer will need more. You need the exception only
for the ES1 case.

(else you will end up patching this section again with newer revisions =
as well).

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
