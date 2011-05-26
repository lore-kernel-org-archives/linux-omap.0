From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 3/8] OMAP2+: cpufreq: use
 opp/clk_*cpufreq_table based on silicon
Date: Thu, 26 May 2011 11:39:10 -0700
Message-ID: <BANLkTik=N1eJ4oUMFg_cn9pHZiSXieO0DQ@mail.gmail.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <1306366733-8439-4-git-send-email-nm@ti.com>
 <87pqn5e4zz.fsf@ti.com> <BANLkTim5A_ypRs3ZetE1WeDcQ0dUN0sxMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:36396 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758105Ab1EZSjc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 14:39:32 -0400
Received: by mail-ww0-f49.google.com with SMTP id 39so986523wwb.6
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 11:39:31 -0700 (PDT)
In-Reply-To: <BANLkTim5A_ypRs3ZetE1WeDcQ0dUN0sxMw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, May 26, 2011 at 11:35, Menon, Nishanth <nm@ti.com> wrote:
> On Thu, May 26, 2011 at 10:38, Kevin Hilman <khilman@ti.com> wrote:
>>
>> I'd prefer to see this even cleaner by dropping the clk_* versions a=
ll
>> together. =A0Then, for those who want OMAP2 support (currently not w=
orking
>> or validated anyways), all that's needed is to add a function simlil=
ar
>> to clk_init_cpufreq_table() which registers OPPs.
>
> yeah - that is better as well.. will do

oops - missed asking - are you ok with just returning a warning and
not registering the cpufreq driver for OMAP2?

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
