From: Colin Cross <ccross@google.com>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Thu, 28 Apr 2011 00:06:01 -0700
Message-ID: <BANLkTik6L8HkJ0YjQYjh_3eEmbffyk1kRA@mail.gmail.com>
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
	<BANLkTiniJUgTTDh7SF8yNMeSMa+JYM21wA@mail.gmail.com>
	<BANLkTimzWyvcBV2ymxaMf=HmRhGYBboB1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:47636 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab1D1HGK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 03:06:10 -0400
Received: from hpaq11.eem.corp.google.com (hpaq11.eem.corp.google.com [172.25.149.11])
	by smtp-out.google.com with ESMTP id p3S7649b007816
	for <linux-omap@vger.kernel.org>; Thu, 28 Apr 2011 00:06:04 -0700
Received: from ywf9 (ywf9.prod.google.com [10.192.6.9])
	by hpaq11.eem.corp.google.com with ESMTP id p3S762jc007867
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 28 Apr 2011 00:06:03 -0700
Received: by ywf9 with SMTP id 9so1014819ywf.36
        for <linux-omap@vger.kernel.org>; Thu, 28 Apr 2011 00:06:02 -0700 (PDT)
In-Reply-To: <BANLkTimzWyvcBV2ymxaMf=HmRhGYBboB1w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: myungjoo.ham@gmail.com
Cc: "Menon, Nishanth" <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-pm@lists.linux-foundation.org

On Wed, Apr 27, 2011 at 11:50 PM, MyungJoo Ham <myungjoo.ham@samsung.co=
m> wrote:
> On Thu, Apr 28, 2011 at 3:44 PM, Colin Cross <ccross@google.com> wrot=
e:
>> On Wed, Apr 27, 2011 at 11:12 PM, MyungJoo Ham <myungjoo.ham@samsung=
=2Ecom> wrote:
>>> On Thu, Apr 28, 2011 at 5:48 AM, Colin Cross <ccross@google.com> wr=
ote:
>>>> OPP currently has opp_enable and opp_disable functions. =A0I don't
>>>> understand why these are needed, they are only used at init time t=
o
>>>> determine available voltages, which could be handled by never pass=
ing
>>>> unavailable voltages to the dvfs implementation.
>>>
>>> We need them in runtime.
>>>
>>> A device "a" may want to guarantee that a device "b" to be at least
>>> "200MHz" or faster while it does some operations. Then, "a" will
>>> opp_disable("b", 100MHz and others); and opp_enable("b", them) late=
r
>>> on. We have similar issues with multimedia blocks (MFC, Camera, FB,
>>> GPU) and CPU/Memory Bus. Ondemand governor of CPUFREQ has some dela=
y
>>> on catching up a workload (1.5x the sampling rate in average, <2.0x
>>> the sampling rate in worst cases), which may incur flickering/teari=
ng
>>> issues with multimedia streams. On the other hand, a general therma=
l
>>> monitor or battery manager might want to limit energy usage by
>>> disabling top performance clocks if it is too hot or the battery le=
vel
>>> is low.
>>
>> That sounds like a very strange api, when what you really mean is
>> clk_set_min_rate or clk_set_max_rate.
>
> Essentially, that's what needed.
> However, with clk_set_min/max_rate, don't we need to let another
> device to be consumer of other devices' clocks? Not just introducing =
a
> device to other devices?

Yes, but that's effectively what you're doing through a backwards api
anyways.  The question is, for these complicated clock scenarios where
the final frequency of a clock depends on so many factors, should that
control go through the clock framework, or through some sort of global
clock governor (which is where OPP would reappear).
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
