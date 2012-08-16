From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] regulator: twl-regulator: fix up VINTANA1/VINTANA2
Date: Thu, 16 Aug 2012 13:21:54 +0530
Message-ID: <502CA69A.2000500@ti.com>
References: <1344982205-21186-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344982205-21186-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: lrg@ti.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 15 August 2012 03:40 AM, Aaro Koskinen wrote:
> It seems commit 2098e95ce9bb039ff2e7bf836df358d18a176139 (regulator: twl:
> adapt twl-regulator driver to dt) accidentally deleted VINTANA1. Also
> the same commit defines VINTANA2 twice with TWL4030_ADJUSTABLE_LDO and
> TWL4030_FIXED_LDO. This patch changes the fixed one to be VINTANA1.

Thanks for the fix, the commit does seem to have mixed up things.

Acked-by: Rajendra Nayak <rnayak@ti.com>
