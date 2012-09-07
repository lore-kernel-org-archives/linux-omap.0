From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: Perf doesn't support coresight or it doesn't read the PMU
 registers on Pandaboard Rev.A2
Date: Fri, 7 Sep 2012 17:05:52 +0530
Message-ID: <CAMQu2gx=C+KOZg_8xg1arPqL+i82_zm5iE99yDyf7ieL+hPS9g@mail.gmail.com>
References: <CAO8ONPyN_c9Tek1ym3jNx0K4B7SvEghRCON_ZP-dMeFP_jcirA@mail.gmail.com>
 <CAO8ONPwRiWi6JOHXVVK7wx9UOZ9Bsv-L7yV-w2hcCKpjXfLhOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:51516 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751412Ab2IGLgO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 07:36:14 -0400
Received: by qcse13 with SMTP id e13so3668262qcs.1
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 04:36:13 -0700 (PDT)
In-Reply-To: <CAO8ONPwRiWi6JOHXVVK7wx9UOZ9Bsv-L7yV-w2hcCKpjXfLhOw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vanni Genua <vannigenua@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>

On Fri, Sep 7, 2012 at 1:07 PM, Vanni Genua <vannigenua@gmail.com> wrote:
>
>
> Hi there,
> I'm testing a Pandaboard (OMAP4430, ARMv7) with Linux kernel 3.0.27-rt46
> installed on it.
> The following instruction is not working due to unsupported cache-misses
> event.
> #perf stat -e cache-misses echo "Hello"
> Performance counter stats for 'echo "Hello" ':
>
>    <not supported> cache-misses
>
>        0.007507575 seconds time elapsed
>
> How to solve this problem?
> Is there any patch for Perf o Linux kernel?

You are missing some patches which recently got sorted out
to get PMU event work on OMAP.

Patches are against the latest tree, you can find on Jon's
tree [1]

They are against Linux 3.6-rc2, so you may have to back-port them
to get counters working on 3.0.X kernel.

Regards
Santosh

[1] https://github.com/jonhunter/linux/tree/dev-pmu
