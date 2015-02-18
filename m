From: Tony Lindgren <tony@atomide.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Wed, 18 Feb 2015 06:54:47 -0800
Message-ID: <20150218145446.GA32521@atomide.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
 <20150216175826.GT2531@atomide.com>
 <CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery8.ore.mailhop.org ([54.148.222.11]:48142 "EHLO
	pmta2.delivery8.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751728AbbBRPJS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Feb 2015 10:09:18 -0500
Received: from smtp4.ore.mailhop.org (172.31.36.112) by pmta2.delivery1.ore.mailhop.org id hsiliu20u50v for <linux-omap@vger.kernel.org>; Wed, 18 Feb 2015 14:59:33 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
In-Reply-To: <CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150216 12:12]:
> On 16 February 2015 at 18:58, Tony Lindgren <tony@atomide.com> wrote:
> > The perf counter on omap3 used to work, but is buggy at least on
> > 3430 because it eventually stops producing interrupts because of
> > some bug in the Cortex-A8 version being used.
> 
> Of course the workaround of polling the counters at least once per
> 2^31 clock cycles to detect when they wrap (or in general keep local
> 64-bit copies up-to-date) is not really a huge burden.

>From memory.. I believe the issue was that for anything needing to
set the counter and rely on the counter interrupt things would fail
as the counter interrupts would not always happen.

Regards,

Tony
