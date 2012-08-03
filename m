From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Re: [PATCH v3] printk: add option to print cpu id
Date: Fri, 3 Aug 2012 14:24:20 -0700
Message-ID: <CAFm5wm2sf9LnZNj9_BDYTF9G7XH32fOL3x5n=kZ-1ih0Cek2DQ@mail.gmail.com>
References: <1344013004-32211-1-git-send-email-vikram.pandita@ti.com>
 <m2628z6euk.fsf@firstfloor.org> <CAFm5wm3ScpUU5wa=ei3TY0zjU4kVbOgJMmE5_QDpwy7B-TJa+A@mail.gmail.com>
 <20120803200822.GC731@harshnoise.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:43199 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752689Ab2HCVYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 17:24:41 -0400
Received: by qcsd16 with SMTP id d16so861323qcs.0
        for <linux-omap@vger.kernel.org>; Fri, 03 Aug 2012 14:24:40 -0700 (PDT)
In-Reply-To: <20120803200822.GC731@harshnoise.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Andi Kleen <andi@firstfloor.org>, gregkh@linuxfoundation.org, kay@vrfy.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Vimarsh Zutshi <vimarsh.zutshi@gmail.com>

Aaro

On Fri, Aug 3, 2012 at 1:08 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Fri, Aug 03, 2012 at 11:25:37AM -0700, Pandita, Vikram wrote:
>> > And really: Wasting 1/3 of the 80 character line is too much.
>>
>> You _WASTE_ 4 chars only if you are interested in this info by
>> enabling: CONFIG_PRINTK_CPUID
>
> I guess you waste 4 + 3 chars? You could optimize the length by checking
> CONFIG_NR_CPUS?

Good point.
Looks there is a variable 'nr_cpu_ids' that could be used as well.

If there is general consensus that the patch can help the arm
community, and others in general,
this optimization should be easy to implement - saving few chars space
in each line of console output.

For now i will stick to this v3 version of path, unless you think otherwise.

>
> A.
