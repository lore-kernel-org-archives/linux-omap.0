From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Thu, 26 Feb 2015 04:14:56 +0100
Message-ID: <CAALWOA8kbWazwvKSeiAQ7z38+ue7DCWZPoXFSEWy0=J8v+AwVQ@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
 <20150216175826.GT2531@atomide.com> <CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
 <CANOLnOO6HWtptks+TXbJEim9fhk5mp5q94gg1wva77x4H7c3pg@mail.gmail.com>
 <CAALWOA_DWjDkmnTj1h0EaSKPeJB_Xd+8YAa6Yv=_HgH9W+ijWA@mail.gmail.com>
 <CANOLnOOgTtTeg_OBvJSGy9OOwdA65omwN=_8Webt8M5E6DoJbg@mail.gmail.com>
 <CAALWOA_Hj4bNHX2LX8w_vBBaThpnwQ+=JxScF710vc_itEfV4Q@mail.gmail.com>
 <CAALWOA_Vw=1xC=yUYJBUhp4QqZWvk+EsiLSB=J7+EQmBMTgEkQ@mail.gmail.com> <CANOLnOOBHmHjydhtH3_gL9D+ZPWywxsXHtn9RRaNWCSJb50Cnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:43406 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbBZDPR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 22:15:17 -0500
Received: by wggy19 with SMTP id y19so7428496wgg.10
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2015 19:15:16 -0800 (PST)
In-Reply-To: <CANOLnOOBHmHjydhtH3_gL9D+ZPWywxsXHtn9RRaNWCSJb50Cnw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

On 26 February 2015 at 02:09, Grazvydas Ignotas <notasas@gmail.com> wrote:
> I've finally got rid of nTRST pulldown (haven't connected TDO though),
> created hw-omap3.{h,cc}, but couldn't get it to do anything, until it
> came to my mind that you may be running ARM on your BBB slower that
> 1GHz that I'm using on my DM3730. So lowered the clock to 500MHz and
> voila, it worked!

I'm actually running at 1 GHz also, but I must admit I only assumed no
explicit delays would be necessary when bit-banging, I didn't actually
check to see what kind of TCK speed it produced. It's actually
slightly surprising to me that the CPU would end up the bottleneck.

Enabling TDO will also assuredly slow things down incredibly: without
it I'm just doing writes, which are posted (aka buffered / performed
asynchronously), while inserting a read will stall the cpu until it
gets an answer from the peripheral.

Thinking of it... unless the control module and relevant GPIO module
are connected to the same L4 interconnect (which they aren't in my
test case) I should actually perform at least a dummy read (aka "OCP
barrier") from the control module before accessing GPIO since
otherwise it's not even guaranteed that all writes to the control
module have completed. Joy.

If you want guaranteed reliability, modify tck_pulse() to insert
aforementioned barrier + an actual delay at all three points where I
put comments about them.  usleep(50) or so should do the job.

> I guess I'll still connect TDO as it's not so much fun without it,
> going to try connecting to EMU0 too, hopefully it doesn't mess up the
> boot modes.

Note that you can use *any* gpio. I just used one of the EMU pins
because the am335x lets you reconfigure those to GPIO and it was
conveniently nearby. Anyhow, even if you do use EMU0 (or EMU1) for
this, TDO is only driven during data transfers and high-Z otherwise,
so you'd need very good aim with your power-on-reset pulse to manage
to get the EMU pin sampled low (assuming the line even has enough
capacitance to avoid being pulled up fast enough).

> My main goal is to have hardware watchpoints on the cased production
> unit without extra hardware, and it looks like I can finally have
> that, thanks!

You're welcome!

> It sure is! The only thing I do not understand is why are you using
> that process_vm_readv() call, mmap() already makes unprivileged user
> mode writable mappings.

Obviously, otherwise process_vm_readv() would give EFAULT also.

The issue here is not the MMU but the control module itself. I don't
know the situation on the omap3, but at least on recent SoCs the
control module checks the request privilege (OCP MReqSupervisor
signal) and ignores all unprivileged writes. In this case that request
flag comes from the AWPROT[0] signal of the AXI bus, which (for
uncacheable writes) is set based on the CPU processor mode with which
the store-instruction is executed.

Matthijs
