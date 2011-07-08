From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 4/6] OMAP4: clocks: Update the clock tree with 4460
 clock nodes
Date: Fri, 08 Jul 2011 00:09:12 -0700
Message-ID: <4E16AD18.7040402@ti.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com> <1309573826-10615-2-git-send-email-rnayak@ti.com> <1309573826-10615-3-git-send-email-rnayak@ti.com> <1309573826-10615-4-git-send-email-rnayak@ti.com> <1309573826-10615-5-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1107080044270.24181@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37322 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752752Ab1GHHJQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 03:09:16 -0400
Received: by mail-iy0-f175.google.com with SMTP id 10so2193960iym.34
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 00:09:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1107080044270.24181@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

On 7/7/2011 11:49 PM, Paul Walmsley wrote:
> On Sat, 2 Jul 2011, Rajendra Nayak wrote:
>
>> Add the new clock nodes (bandgap_ts_fclk, div_ts_ck) for omap4460.
>> Handle these nodes using the clock flags (CK_*).
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Reviewed-by: Kevin Hilman<khilman@ti.com>
>
> Is this data coming from autogenerator scripts that have been checked into
> that repository, or have these been hand-edited?

They have been hand edited to create a diff from the 4430 autogen output
and 4460 autogen output.

>
> Also, this isn't the complete set of clock changes needed for full 4460
> support, right?  I'm thinking of the duty cycle correction changes
> described in TRM 3.6.3.7.2 "Tactical Clocking Adjustment".
> Are those planned to go into a future patch?

Yes, this series was targeted at providing basic boot support. I was
planning to add the DCC changes as part of the next series.

regards,
Rajendra
>
>
> - Paul

