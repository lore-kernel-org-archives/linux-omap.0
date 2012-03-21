From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC][PATCH 1/7] ARM: OMAP4: cpuidle - Remove unused valid field
Date: Wed, 21 Mar 2012 15:11:12 +0530
Message-ID: <CAMQu2gw+GGnpG_s6TCk2fH094Lfmj1zgAZqQ4zdQmpj3ZZhu3w@mail.gmail.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org> <1332322070-24577-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:52695 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751565Ab2CUJlf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 05:41:35 -0400
Received: by mail-qc0-f171.google.com with SMTP id p15so635629qcs.30
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 02:41:32 -0700 (PDT)
In-Reply-To: <1332322070-24577-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> The 'valid' field is never used in the code, let's remove it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
It is used during the registration. This field has been very useful for
debug when need to disable a C-state etc.
So unless and until there is a strong reason, i would like to retain it.

Regards
Santosh
