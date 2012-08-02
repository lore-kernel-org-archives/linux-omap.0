From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain
 transitioning to OFF when in-use
Date: Thu, 2 Aug 2012 13:04:25 +0530
Message-ID: <CAMQu2gx_E2eZASK-Zj0A6D4tq0VMJXCPK5QMsp7w3GHVChAkXg@mail.gmail.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com>
 <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com>
 <50045D17.9050704@ti.com> <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com>
 <50171841.40309@ti.com> <501760BF.8070801@ti.com> <5018210A.1040902@ti.com>
 <50187644.40308@ti.com> <alpine.DEB.2.00.1208010932270.21488@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:40295 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751265Ab2HBHer convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Aug 2012 03:34:47 -0400
Received: by ggnc4 with SMTP id c4so8338699ggn.3
        for <linux-omap@vger.kernel.org>; Thu, 02 Aug 2012 00:34:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208010932270.21488@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Kevin Hilman <khilman@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Madhav Vij <mvij@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 1, 2012 at 9:06 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi Jon et al,
>
> Here's what I'm planning to queue here.  The only changes from what J=
on
> posted are the patch changelog and some checkpatch fixes.  If anyone
> has any final comments, please let me know.
>
>
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Wed, 1 Aug 2012 09:11:20 -0600
> Subject: [PATCH] ARM: OMAP2+: clockdomain/hwmod: add workaround for E=
MU
>  clockdomain idle problems
>
> The idle status of the IP blocks and clocks inside the EMU clockdomai=
n
> isn't taken into account by the PRCM hardware when deciding whether
> the clockdomain is idle.  Add a workaround flag in the clockdomain
> code, CLKDM_MISSING_IDLE_REPORTING, to deal with this problem, and ad=
d
> the code necessary to support it.
>
> If CLKDM_MISSING_IDLE_REPORTING is set on a clockdomain, the
> clockdomain will be forced active whenever an IP block inside that
> clockdomain is in use, even if the clockdomain supports
> hardware-supervised idle.  When the kernel indicates that the last
> active IP block inside the clockdomain is no longer used, the
> clockdomain will be forced idle, or, if that mode is not supported in
> the hardware, it will be placed into hardware-supervised idle.
>
> This patch is an equal collaboration with Jon Hunter
> <jon-hunter@ti.com>.  Ming Lei <ming.lei@canonical.com>, Will Deacon
> <will.deacon@arm.com>, Madhav Vij <mvij@ti.com>, Kevin Hilman
> <khilman@ti.com>, Beno=EEt Cousson <b-cousson@ti.com>, and Santosh
> Shilimkar <santosh.shilimkar@ti.com> all made essential contributions
> to the understanding of EMU clockdomain power management on OMAP.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Ming Lei <ming.lei@canonical.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Madhav Vij <mvij@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Beno=EEt Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
