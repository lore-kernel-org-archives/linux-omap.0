From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 7/8] OMAP3: update cpuidle latency and threshold figures
Date: Wed, 12 Oct 2011 10:48:33 +0800
Message-ID: <CACVXFVOj+S73Mk8C=Ct3tQTip-dbSHCd4M1Y8hJPCE8k=UqECA@mail.gmail.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
	<1316621649-3622-8-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54979 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab1JLCsd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Oct 2011 22:48:33 -0400
Received: by gyb13 with SMTP id 13so234400gyb.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Oct 2011 19:48:33 -0700 (PDT)
In-Reply-To: <1316621649-3622-8-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi,

On Thu, Sep 22, 2011 at 12:14 AM, Jean Pihet <jean.pihet@newoldbits.com=
> wrote:
> Update the data from the measurements performed at HW and SW levels.
>
> Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_M=
easurement
> for a detailed explanation on where are the numbers magically coming =
from.
>
> ToDo:
> - Measure the wake-up latencies for all power domains for OMAP3
> - Correct some numbers when sys_clkreq and sys_offmode are supported
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 28 ++++++++++++++---------=
-----
> =A01 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/=
cpuidle34xx.c
> index 1b8e0da..4b3e994 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -44,20 +44,20 @@
> =A0* pass these details from the board file.
> =A0*/
> =A0static struct cpuidle_params cpuidle_params_table[] =3D {
> - =A0 =A0 =A0 /* C1 */
> - =A0 =A0 =A0 {2 + 2, 5, 1},
> - =A0 =A0 =A0 /* C2 */
> - =A0 =A0 =A0 {10 + 10, 30, 1},
> - =A0 =A0 =A0 /* C3 */
> - =A0 =A0 =A0 {50 + 50, 300, 1},
> - =A0 =A0 =A0 /* C4 */
> - =A0 =A0 =A0 {1500 + 1800, 4000, 1},
> - =A0 =A0 =A0 /* C5 */
> - =A0 =A0 =A0 {2500 + 7500, 12000, 1},
> - =A0 =A0 =A0 /* C6 */
> - =A0 =A0 =A0 {3000 + 8500, 15000, 1},
> - =A0 =A0 =A0 /* C7 */
> - =A0 =A0 =A0 {10000 + 30000, 300000, 1},
> + =A0 =A0 =A0 /* C1 . MPU WFI + Core active */
> + =A0 =A0 =A0 {73 + 78, 152, 1},
> + =A0 =A0 =A0 /* C2 . MPU WFI + Core inactive */
> + =A0 =A0 =A0 {165 + 88, 345, 1},
> + =A0 =A0 =A0 /* C3 . MPU CSWR + Core inactive */
> + =A0 =A0 =A0 {163 + 182, 345, 1},
> + =A0 =A0 =A0 /* C4 . MPU OFF + Core inactive */
> + =A0 =A0 =A0 {2852 + 605, 150000, 1},
> + =A0 =A0 =A0 /* C5 . MPU RET + Core RET */
> + =A0 =A0 =A0 {800 + 366, 2120, 1},

C4 exit_latency is longer than C5's, not sure if it is correct?

> + =A0 =A0 =A0 /* C6 . MPU OFF + Core RET */
> + =A0 =A0 =A0 {4080 + 801, 215000, 1},
> + =A0 =A0 =A0 /* C7 . MPU OFF + Core OFF */
> + =A0 =A0 =A0 {4300 + 13000, 215000, 1},
> =A0};
> =A0#define OMAP3_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
>
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>


thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
