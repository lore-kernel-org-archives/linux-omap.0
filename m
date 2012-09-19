From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 2/3] OMAP i2c: pinctrl-ify i2c-omap.c
Date: Wed, 19 Sep 2012 11:34:27 +0300
Message-ID: <D63B475E-E552-4ED6-9C25-21BC188722ED@antoniou-consulting.com>
References: <1348070841-23354-1-git-send-email-panto@antoniou-consulting.com> <1348070841-23354-3-git-send-email-panto@antoniou-consulting.com> <50596F8F.60506@ti.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50596F8F.60506@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi

On Sep 19, 2012, at 10:09 AM, Shubhrajyoti wrote:

> On Wednesday 19 September 2012 09:37 PM, Pantelis Antoniou wrote:
>> #include <linux/pm_runtime.h>
>> +#include <linux/pinctrl/consumer.h>
>> +#include <linux/err.h>
> err.h include may be removed.

Right, Updated patch series (without the message patch follows)...

Regards

-- Pantelis
