From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC][PATCH 2/7] ARM: OMAP4: cpuidle - Declare the states with
 the driver declaration
Date: Wed, 21 Mar 2012 15:20:20 +0530
Message-ID: <4F69A45C.5050802@ti.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org> <1332322070-24577-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:46115 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752892Ab2CUJu0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 05:50:26 -0400
Received: by obceq6 with SMTP id eq6so692969obc.40
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 02:50:24 -0700 (PDT)
In-Reply-To: <1332322070-24577-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, Jean Pihet <jean.pihet@newoldbits.com>

+ Jean,

On Wednesday 21 March 2012 02:57 PM, Daniel Lezcano wrote:
> The cpuidle API allows to declare statically the states in the driver
> structure. Let's use it.
> We do no longer need the fill_cstate function called at runtime and
> by the way adding more instructions at boot time.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
Jean added the fill_cstate() kind of helpers o.w in the old
cpuidle code9OMAP30, static tables were used. Ofcourse those
tables were not uinsg the cpuidle driver structure.

Regards
santosh
