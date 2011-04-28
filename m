From: Colin Cross <ccross@google.com>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Wed, 27 Apr 2011 23:44:46 -0700
Message-ID: <BANLkTiniJUgTTDh7SF8yNMeSMa+JYM21wA@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
	<BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
	<BANLkTikEtTDp3Cpj0D5z34wA0_G_DWwKFg@mail.gmail.com>
	<alpine.LFD.2.02.1104272104390.3323@ionos>
	<BANLkTinWD0ktYKzR_jnQSE76AuW+Z1PSLw@mail.gmail.com>
	<BANLkTi=Be3DrAUoPmgHpjhAVmN-Pi5Au7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:31534 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab1D1Gou convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 02:44:50 -0400
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com [172.25.149.6])
	by smtp-out.google.com with ESMTP id p3S6inh1031985
	for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 23:44:49 -0700
Received: from gwj15 (gwj15.prod.google.com [10.200.10.15])
	by hpaq6.eem.corp.google.com with ESMTP id p3S6ilGk022324
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 23:44:48 -0700
Received: by gwj15 with SMTP id 15so986683gwj.25
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 23:44:47 -0700 (PDT)
In-Reply-To: <BANLkTi=Be3DrAUoPmgHpjhAVmN-Pi5Au7g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Menon, Nishanth" <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, linux-omap <linux-omap@vger.kernel.org>

On Wed, Apr 27, 2011 at 11:12 PM, MyungJoo Ham <myungjoo.ham@samsung.co=
m> wrote:
> On Thu, Apr 28, 2011 at 5:48 AM, Colin Cross <ccross@google.com> wrot=
e:
>> OPP currently has opp_enable and opp_disable functions. =A0I don't
>> understand why these are needed, they are only used at init time to
>> determine available voltages, which could be handled by never passin=
g
>> unavailable voltages to the dvfs implementation.
>
> We need them in runtime.
>
> A device "a" may want to guarantee that a device "b" to be at least
> "200MHz" or faster while it does some operations. Then, "a" will
> opp_disable("b", 100MHz and others); and opp_enable("b", them) later
> on. We have similar issues with multimedia blocks (MFC, Camera, FB,
> GPU) and CPU/Memory Bus. Ondemand governor of CPUFREQ has some delay
> on catching up a workload (1.5x the sampling rate in average, <2.0x
> the sampling rate in worst cases), which may incur flickering/tearing
> issues with multimedia streams. On the other hand, a general thermal
> monitor or battery manager might want to limit energy usage by
> disabling top performance clocks if it is too hot or the battery leve=
l
> is low.

That sounds like a very strange api, when what you really mean is
clk_set_min_rate or clk_set_max_rate.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
