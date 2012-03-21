From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Date: Wed, 21 Mar 2012 15:06:30 +0530
Message-ID: <CAMQu2gxit11dSbruPLCGx37TRwo9mwNCN9JXn0fZLDTVGu2GcA@mail.gmail.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob129.obsmtp.com ([74.125.149.136]:41364 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753002Ab2CUJgv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 05:36:51 -0400
Received: by mail-qc0-f174.google.com with SMTP id w6so598274qcq.5
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 02:36:50 -0700 (PDT)
In-Reply-To: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> This patchset is a proposition to improve a bit the code.
> The changes are code cleanup and does not change the behavior of the
> driver itself.
>
Thanks. Will have a look at your series.

> A couple a things call my intention. Why the cpuidle device is set for cpu0 only
Because the mainline code CPUIDLE is supported along with CPUhotplug.
This is going to change though with Couple CPUIDLE and corresponding
OMAP updates.

> and why the WFI is not used ?
>
I didn't get this question. Do you mean the generic WFI?
If yes, then, it's mainly because OMAP need additional
custom barriers.

Regards
Santosh
