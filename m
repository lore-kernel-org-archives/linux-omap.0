From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 4/6] ARM: OMAP: fix missing __devexit_p() annotations
Date: Thu, 15 Mar 2012 12:06:44 +0100
Message-ID: <CAORVsuUVC4hpotK=eybA=Eqtfg0+PivjwRUENjCwcLG2dp1Ucg@mail.gmail.com>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk>
	<E1S87wp-0000Mz-V8@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43490 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758Ab2COLGp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 07:06:45 -0400
Received: by vcqp1 with SMTP id p1so2999088vcq.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Mar 2012 04:06:44 -0700 (PDT)
In-Reply-To: <E1S87wp-0000Mz-V8@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Russell,

On Thu, Mar 15, 2012 at 11:30 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Missing __devexit_p() annotations in driver structures for remove fun=
ctions
> marked with __devexit is waiting for build errors to happen, such as:
>
> `omap_system_dma_remove' referenced in section `.data' of arch/arm/pl=
at-omap/bui
> lt-in.o: defined in discarded section `.devexit.text' of arch/arm/pla=
t-omap/buil
> t-in.o
>
> Add the necessary annotation, and as a result of audit, fix others wh=
ich
> are also missing in arch/arm/*omap*.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
> =A0arch/arm/mach-omap2/smartreflex.c | =A0 =A02 +-
> =A0arch/arm/plat-omap/dma.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A02 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/=
smartreflex.c
> index 7e755bb..47c77a1 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -1012,7 +1012,7 @@ static int __devexit omap_sr_remove(struct plat=
form_device *pdev)
> =A0}
>
> =A0static struct platform_driver smartreflex_driver =3D {
> - =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap_sr_remove,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(omap_sr_remove)=
,
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "smartreflex",
> =A0 =A0 =A0 =A0},
Tony already has this change in his master branch, commit
149f1d5c8d2fd6879cdf93ca70f1cb745e698a1e ('ARM: OMAP2+: Fix devexit
for smartreflex when CONFIG_HOTPLUG is not set').

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
