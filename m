From: Aneesh V <aneesh@ti.com>
Subject: Re: [RFC v3 PATCH 1/3] dt: device tree bindings for DDR memories
Date: Fri, 20 Jan 2012 02:26:38 +0530
Message-ID: <4F188386.3080507@ti.com>
References: <1326983521-373-1-git-send-email-aneesh@ti.com>	<1326983521-373-2-git-send-email-aneesh@ti.com> <CAOesGMikm8szKR_yyeV-4NbnknCLG3z9N_sj+zydyu+cosj-Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:44703 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932718Ab2ASU4t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 15:56:49 -0500
Received: by ggnv2 with SMTP id v2so316374ggn.26
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 12:56:47 -0800 (PST)
In-Reply-To: <CAOesGMikm8szKR_yyeV-4NbnknCLG3z9N_sj+zydyu+cosj-Tg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

Hi Olof,

On Friday 20 January 2012 01:01 AM, Olof Johansson wrote:
> Hi,
>
> Sorry for the delay in responding, I know you pinged me about it yesterday.
>
> On Thu, Jan 19, 2012 at 6:31 AM, Aneesh V<aneesh@ti.com>  wrote:
>> device tree bindings for LPDDR2 SDRAM memories compliant
>> to JESD209-2 standard.
>>
>> The 'lpddr2' binding in-turn uses another binding 'lpddr2-timings'
>> for specifying the AC timing parameters of the memory device at
>> different speed-bins.
>
> As I just commented on the thread with Mike, I think we would be
> better off sticking to embedding a standard JEDEC SPD structure in the
> device tree. It's not large (128-256 bytes depending on memory type),
> and it's clearly defined and used all over the industry.
>
> It also has the benefit of reusing parsing code if you ever end up
> with a system that uses DIMMs for memory, thus needing to parse the
> SPD on said modules.

I did mention in the previous thread why SPD doesn't work for us ([1] 
and [2]). Let me repeat the key points here.

1. I couldn't find an SPD addendum for LPDDR2 from the JEDEC website.
2. This seems to indicate that SPD is not used for LPDDR2 devices.
3. I tried to see if I can fit the DDR3 or DDR2 SPD for our needs. But
some of the AC timing parameters needed by our controller are not
available in those layouts.

I don't see any option other than defining a new binding for LPDDR2.

br,
Aneesh

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg61250.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60473.html
