From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 2/3] OMAP i2c: pinctrl-ify i2c-omap.c
Date: Wed, 19 Sep 2012 12:39:03 +0530
Message-ID: <50596F8F.60506@ti.com>
References: <1348070841-23354-1-git-send-email-panto@antoniou-consulting.com> <1348070841-23354-3-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348070841-23354-3-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 19 September 2012 09:37 PM, Pantelis Antoniou wrote:
>  #include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/err.h>
err.h include may be removed.
