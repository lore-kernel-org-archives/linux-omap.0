From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] ARM: add cpufreq transiton notifier to adjust
 loops_per_jiffy for smp
Date: Wed, 29 Feb 2012 14:12:09 +0530
Message-ID: <CAMQu2gxwb8=Pn6tp6SCc+G=juUUtfXfe5wuLAD8f0fDVJqwpEA@mail.gmail.com>
References: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org> <1330499895-12364-2-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:40047 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755620Ab2B2Ima (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 03:42:30 -0500
Received: by mail-qy0-f181.google.com with SMTP id d17so2890664qcs.40
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 00:42:29 -0800 (PST)
In-Reply-To: <1330499895-12364-2-git-send-email-richard.zhao@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Zhao <richard.zhao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux@arm.linux.org.uk, davej@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com, davidb@codeaurora.org, arnd@arndb.de, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org

On Wed, Feb 29, 2012 at 12:48 PM, Richard Zhao <richard.zhao@linaro.org> wrote:
> If CONFIG_SMP, cpufreq skips loops_per_jiffy update, because different
> arch has different per-cpu loops_per_jiffy definition.
>
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
