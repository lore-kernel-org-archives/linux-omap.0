From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio/omap: fix invalid context restore of gpio bank-0
Date: Sat, 30 Jun 2012 09:48:03 +0530
Message-ID: <CAMQu2gx+tCujB0a+2zL8RGdJe5Y2VLPOyPUOPkys3VS7JdaKbg@mail.gmail.com>
References: <1340990551-19426-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:34895 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750699Ab2F3ESY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Jun 2012 00:18:24 -0400
Received: by qabg1 with SMTP id g1so1054177qab.20
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 21:18:23 -0700 (PDT)
In-Reply-To: <1340990551-19426-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, Kevin Hilman <khilman@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Franky Lin <frankyl@broadcom.com>

On Fri, Jun 29, 2012 at 10:52 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> Currently the gpio _runtime_resume/suspend functions are calling the
> get_context_loss_count() platform function if the function is populat=
ed for
> a gpio bank. This function is used to determine if the gpio bank logi=
c state
> needs to be restored due to a power transition. This function will be=
 populated
> for all banks, but it should only be called for banks that have the
> "loses_context" variable set. It is pointless to call this if loses_c=
ontext is
> false as we know the context will never be lost and will not need res=
toring.
>
> For all OMAP2+ devices gpio bank-0 is in an always-on power domain an=
d so will
> never lose context. We found that the get_context_loss_count() was be=
ing called
> for bank-0 during the probe and returning 1 instead of 0 indicating t=
hat the
> context had been lost. This was causing the context restore function =
to be
> called at probe time for this bank and because the context had never =
been saved,
> was restoring an invalid state. This ultimately resulted in a crash [=
1].
>
> There are multiple bugs here that need to be addressed ...
>
> 1. Why the always-on power domain returns a context loss count of 1? =
This needs
> =A0 to be fixed in the power domain code. However, the gpio driver sh=
ould not
> =A0 assume the loss count is 0 to begin with.
Indeed. GPIO driver should not assume the value.

> 2. The omap gpio driver should never be calling get_context_loss_coun=
t for a
> =A0 gpio bank in a always-on domain. This is pointless and adds unnec=
cessary
> =A0 overhead.
Make sense too.

> 3. The OMAP gpio driver assumes that the initial power domain context=
 loss count
> =A0 will be 0 at the time the gpio driver is probed. However, it coul=
d be
> =A0 possible that this is not the case and an invalid context restore=
 could be
> =A0 performed during the probe. To avoid this otherwise only populate=
d the
> =A0 get_context_loss_count() function pointer after the initial call =
to
> =A0 pm_runtime_get() has occurred. This will ensure that the first
> =A0 pm_runtime_put() initialised the loss count correctly.
>
> This patch addresses issues 2 and 3 above.
>
> [1] http://marc.info/?l=3Dlinux-omap&m=3D134065775323775&w=3D2
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Franky Lin <frankyl@broadcom.com>
>
> Reported-by: Franky Lin <frankyl@broadcom.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Thanks Jon for sorting this out. Patch looks good to me.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
