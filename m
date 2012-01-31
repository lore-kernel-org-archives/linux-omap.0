From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 07/21] OMAP3+: PM: SR/Class3: disable errorgen before
 disable VP
Date: Tue, 31 Jan 2012 15:37:08 +0400
Message-ID: <4F27D264.9050203@ru.mvista.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com> <1327504583-13408-8-git-send-email-j-pihet@ti.com> <4F213860.9050600@ru.mvista.com> <CAORVsuUNM8bpwyjbG2GcwfiUEf7A54ODC4tfhZNinUhQTE3g5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:56734 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752949Ab2AaLiR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 06:38:17 -0500
In-Reply-To: <CAORVsuUNM8bpwyjbG2GcwfiUEf7A54ODC4tfhZNinUhQTE3g5w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Hello.

On 31-01-2012 14:06, Jean Pihet wrote:

> ...

>>> +int sr_disable_errgen(struct voltagedomain *voltdm)
>>> +{
>>> +       u32 errconfig_offs, vpboundint_en;
>>> +       u32 vpboundint_st;
>>> +       struct omap_sr *sr = _sr_lookup(voltdm);
>>> +
>>> +       if (IS_ERR(sr)) {
>>> +               pr_warning("%s: omap_sr struct for sr_%s not found\n",
>>> +                       __func__, voltdm->name);
>>> +               return -EINVAL;
>>
>>
>>    Not PTR_ERR(sr)?

> _sr_lookup returns a return code using ERR_PTR so the return value
> should be checked for errors using IS_ERR. Please note that _sr_lookup
> checks for NULL parameter internally.

    That's clear. I was asking don't you want to return PTR_ERR(sr) instead of 
-EINVAL.

WBR, Sergei
