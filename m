From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 3/8] OMAP2+: cpufreq: use
 opp/clk_*cpufreq_table based on silicon
Date: Thu, 26 May 2011 11:35:13 -0700
Message-ID: <BANLkTim5A_ypRs3ZetE1WeDcQ0dUN0sxMw@mail.gmail.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <1306366733-8439-4-git-send-email-nm@ti.com>
 <87pqn5e4zz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:46583 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753523Ab1EZSff convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 14:35:35 -0400
Received: by wwb39 with SMTP id 39so984436wwb.6
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 11:35:33 -0700 (PDT)
In-Reply-To: <87pqn5e4zz.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, May 26, 2011 at 10:38, Kevin Hilman <khilman@ti.com> wrote:
>
> I'd prefer to see this even cleaner by dropping the clk_* versions al=
l
> together. =A0Then, for those who want OMAP2 support (currently not wo=
rking
> or validated anyways), all that's needed is to add a function simlila=
r
> to clk_init_cpufreq_table() which registers OPPs.

yeah - that is better as well.. will do

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
