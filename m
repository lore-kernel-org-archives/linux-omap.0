From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH V4 0/5] ARM: OMAP: HOST: TLL driver implementation
Date: Mon, 24 Sep 2012 12:39:42 +0530
Message-ID: <CAP05o4+gA6nRV6d3HETObJFccNcjNwNE5+LAut6zb7Msgu1hLQ@mail.gmail.com>
References: <CAP05o4+rdtsXKV9U0MrLyu7Ce8zJ4uUEcZOJ5yfarpF42gSogA@mail.gmail.com>
	<20120723140830.GA8155@arwen.pp.htv.fi>
	<CAP05o4JDa5WH14SLkFswEqx6jWyr94VfxtEBsbmaiQ+5kT_abQ@mail.gmail.com>
	<CAP05o4+dOH6tDXU4bs5ubh8rqjpjumZjfu4zM1G6MupE0T4fhQ@mail.gmail.com>
	<CAP05o4LRS=svfTsNV45CcToKT7XcZ+et3+fmYzJ7xMLhidtCOA@mail.gmail.com>
	<20120813140928.GH14781@arwen.pp.htv.fi>
	<CAP05o4K1J_ZzUT7PtKb6ZK-DzxJogLZ+hFUv65qKE2zFFNFbGg@mail.gmail.com>
	<CAP05o4K5f5xUdfT2V7m+Jp9D74btPMz1bB6eYCnkBBpsZqP9tA@mail.gmail.com>
	<CAP05o4KaQFvOBwQoVy_-Ve=T_fwDw-SEyO8DCtfuX-r5ryiOeA@mail.gmail.com>
	<alpine.DEB.2.00.1209192030270.5264@utopia.booyaka.com>
	<20120921220720.GY28670@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:60750 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755104Ab2IXHJo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 03:09:44 -0400
Received: by vcbfo13 with SMTP id fo13so5931759vcb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 00:09:42 -0700 (PDT)
In-Reply-To: <20120921220720.GY28670@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Paul Walmsley <paul@pwsan.com>, parthab@india.ti.com, linux-omap@vger.kernel.org, Linux USB Devel <linux-usb@vger.kernel.org>

On Sat, Sep 22, 2012 at 3:37 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Paul,
>
> On Wed, Sep 19, 2012 at 08:39:40PM +0000, Paul Walmsley wrote:
>>
>> Hi Samuel,
>>
>> I've queued patch 1 of this series for 3.7, which should go upstream via
>> the OMAP -> arm-soc path.  Also asked Keshava to re-send patch 5 to me
>> once patches 2-4 have been merged.
>>
>> It's up to you how to handle patches 2-4.  The series is a good step
>> forward for us in terms of cleanup.  But what is probably worthwhile at
>> some point is for that USB TLL "phy" code (added in patch 2) to be moved
>> into some place like drivers/usb/phy, since it's not MFD-related.
> That would be ideal, yes. I kept patches 2-4 as they're alreeady going in the
> right direction (I dropped patches 1 and 5).
>
> Thanks for the heads up.
>
> Cheers,
> Samuel.
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/


thanks paul and Samuel

regards
keshava

regards
keshava
