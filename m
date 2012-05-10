From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/6] arm: omap4: create pmu device via hwmod
Date: Thu, 10 May 2012 11:47:59 +0530
Message-ID: <CAMQu2gxOvuktV-XnnKAxVC7dqOfhfeDygocoXFS_YfvVgeQbYg@mail.gmail.com>
References: <1336599343-10905-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:36623 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751783Ab2EJGSW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 02:18:22 -0400
Received: by qady23 with SMTP id y23so96548qad.0
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 23:18:21 -0700 (PDT)
In-Reply-To: <1336599343-10905-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

On Thu, May 10, 2012 at 3:05 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> From: Ming Lei <ming.lei@canonical.com>
>
> The following modules is required to be enabled before configuring
> cross trigger interface for enabling pmu irq:
>
> =A0 =A0 =A0 =A0l3_instr, l3_main_3, debugss
>
> so build the arm-pmu device via the three hwmods.
>
> Cc: Ming Lei <ming.lei@canonical.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
$subject:
s/arm: omap4: / ARM: OMAP4
To be consistent with rest of the series. Same comment for patch 1/6 as=
 well

Rest of the patch is fine.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
