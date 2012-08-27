From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] arm: omap: ratelimit omap_l3_smx error log spam
Date: Tue, 28 Aug 2012 02:26:13 +0300
Message-ID: <20120827232613.GB783@harshnoise.musicnaut.iki.fi>
References: <1346101403-5882-1-git-send-email-aaro.koskinen@iki.fi>
 <CAMQu2gyEctrq_3K8W6VahMW-ODOiv7TjrBfPTkZqNGJ+0m9ozw@mail.gmail.com>
 <20120827220254.GA783@harshnoise.musicnaut.iki.fi>
 <CAMQu2gz9HE0xEoW7gu257rpLWdCUpt7N6GQNQzWVhFb-A+69hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:35712 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab2H0X12 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Aug 2012 19:27:28 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gz9HE0xEoW7gu257rpLWdCUpt7N6GQNQzWVhFb-A+69hg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Aug 27, 2012 at 03:12:07PM -0700, Shilimkar, Santosh wrote:
> On Mon, Aug 27, 2012 at 3:02 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > Hi,
> >
> > On Mon, Aug 27, 2012 at 02:35:57PM -0700, Shilimkar, Santosh wrote:
> >> > -       pr_err("%s seen by %s %s at address %x\n",
> >> > +       pr_err_ratelimited("%s seen by %s %s at address %x\n",
> >> >                         omap3_l3_code_string(code),
> >> >                         omap3_l3_initiator_string(initid),
> >> >                         multi ? "Multiple Errors" : "", address);
> >> > -       WARN_ON(1);
> >> > +       WARN_ON_ONCE(1);
> >> >
> >> The issue needs to be fixed instead of WARN_ON_ONCE() and then
> >> just moving ahead. Interconnect in bad states is really bad state and you
> >> won't have reliable operations post that on SOC.
> >
> > How printing megabytes of identical stack traces helps anything?
> >
> It just says repeatedly and  loudly... Fix the issue :-)
> 
> > This has been there always (since the L3 driver was added) on every boot
> > with N950/N9 (which BTW are HS devices, not sure if that has anything
> > to do with it). There is no apparent effect on device functionality,
> > at least nothing unusual has been observed...
> >
> I assumed this is secure device when I saw the SRAM memset is causing the
> issue.
> 
> > Is there any documentation how to interpret and debug this error report?
> >
> The issue could be, there is memset tried on Secure portion of SRAM or
> CPU speculatively accessed adjacent SRAM region of public SRAM which
> is secure and hence the error.

Thanks, that makes sense.

> If you just bypass the SRAM init [1], does the issue go away ?

I tried bypassing the whole SRAM init, but the device does not seem to
boot up at all.

If I comment out the memset alone, then it boots and the issue is gone:

+#if 0
	memset_io(omap_sram_base + SRAM_BOOTLOADER_SZ, 0,
		  omap_sram_size - SRAM_BOOTLOADER_SZ);
+#endif

A.
