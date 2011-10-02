From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: Re: [PATCH 04/30] ARM: omap: add missing __devexit_p() annotations
Date: Sun, 2 Oct 2011 17:56:07 +0200
Message-ID: <CAFULf_wevZxWW1RW+r-18R_8=ry2kD6_i5L9NfPd9t8afm5Cog@mail.gmail.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-5-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317566760-25681-5-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Arnd,

Ref http://www.spinics.net/lists/linux-omap/msg57274.html

Don't get me wrong.  This is not about you "stealing" my patch, or
anything like that.  But look also at thread starting at
http://www.spinics.net/lists/linux-omap/msg57667.html Also a patch
that I have posted previously.  Something is not right with the
workflow when bugs are identified, patches are submitted, then
ignored, only for someone else to fix the same bug.  Enough said.

Best regards,

Bjarne Steinsbo

On Sun, Oct 2, 2011 at 4:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Drivers that refer to a __devexit function in an operations
> structure need to annotate that pointer with __devexit_p so
> replace it with a NULL pointer when the section gets discarded.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> =A0arch/arm/mach-omap2/smartreflex.c | =A0 =A02 +-
> =A0arch/arm/plat-omap/dma.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A02 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smar=
treflex.c
> index 34c01a7..67bc6ce 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -1002,7 +1002,7 @@ static int __devexit omap_sr_remove(struct platform=
_device *pdev)
> =A0}
>
> =A0static struct platform_driver smartreflex_driver =3D {
> - =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap_sr_remove,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(omap_sr_remove),
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "smartreflex",
> =A0 =A0 =A0 =A0},
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index c22217c..f7150ba 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -2105,7 +2105,7 @@ static int __devexit omap_system_dma_remove(struct =
platform_device *pdev)
>
> =A0static struct platform_driver omap_system_dma_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D omap_system_dma_probe,
> - =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap_system_dma_remove,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(omap_system_dma_rem=
ove),
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "omap_dma_system"
> =A0 =A0 =A0 =A0},
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
