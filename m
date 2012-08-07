From: Kevin Hilman <khilman@ti.com>
Subject: Re: DSS and USBHOST powerdomains not entering low-power states on 37xx EVM
Date: Tue, 07 Aug 2012 13:48:02 -0700
Message-ID: <87628u2zul.fsf@ti.com>
References: <alpine.DEB.2.00.1208031355450.28888@utopia.booyaka.com>
	<877gtb6723.fsf@ti.com>
	<alpine.DEB.2.00.1208070401530.21945@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41001 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753667Ab2HGUsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 16:48:09 -0400
Received: by yenm2 with SMTP id m2so70833yen.23
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 13:48:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208070401530.21945@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 7 Aug 2012 04:05:33 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> On Mon, 6 Aug 2012, Kevin Hilman wrote:
>
>> Is this only happening on this 37xx platform?    Just curious, because
>> it seems to be a problem on any OMAP3xxx SoC.
>
> So far I've only run the baseline tests on 37xx, so wanted to state only 
> what was observed here.
>
>> ...it must be the usecounts that are not being updated.  This seems to
>> be a side effect of the pre/post transition optimization I did.  A quick
>> hack seems to indicate that that's indeed the case[1].  By default,
>> omap_sram_idle() is now only calling the pre/post callbacks for MPU,
>> NEON, PER, and CORE, and only if those domains are transitioning, so any
>> other domains not explicitly managed by the idle path have lots their
>> usecounting.  Oops.
>> 
>> I guess Tero's usecounting series should fix this up.
>
> Thanks for the diagnosis.  Care to put together a patch to fix this for 
> v3.6-rc?  

Done.

http://marc.info/?l=linux-omap&m=134437239010649&w=2

Kevin
