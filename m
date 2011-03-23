From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 7/7] OMAP3: powerdomain data: add voltage domains
Date: Tue, 22 Mar 2011 17:20:11 -0700
Message-ID: <874o6ubscj.fsf@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
	<1300493932-17362-8-git-send-email-khilman@ti.com>
	<alpine.DEB.2.00.1103221324461.11798@utopia.booyaka.com>
	<4D89100F.1000909@ti.com>
	<alpine.DEB.2.00.1103221615340.11798@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58889 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755164Ab1CWAUP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Mar 2011 20:20:15 -0400
Received: by mail-gw0-f51.google.com with SMTP id 15so2965217gwj.10
        for <linux-omap@vger.kernel.org>; Tue, 22 Mar 2011 17:20:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1103221615340.11798@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 22 Mar 2011 16:15:56 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 22 Mar 2011, Cousson, Benoit wrote:
>
>> On 3/22/2011 8:30 PM, Paul Walmsley wrote:
>> > On Fri, 18 Mar 2011, Kevin Hilman wrote:
>> > 
>> > > Add voltage domain name to indicate which voltagedomain each
>> > > powerdomain is in.  A missing voltage domain name means that that
>> > > powerdomain is not in one of the currently scalable voltage domains.
>> > 
>> > Before you add these, you might want to change the voltagedomain names for
>> > OMAP3.  I don't think it's correct to refer to the VDD1 voltagedomain as
>> > "mpu" since it includes both the MPU and IVA.  Probably best to use simply
>> > "vdd1" and "vdd2" since that is the historical usage.
>> 
>> Yes, but it was confusing, hence the change on OMAP4.
>> "core" is fine and better that vdd2, maybe "mpu_iva" will be better for vdd1.
>> Moreover, it will be consistent will all the OMAP4+ chips.
>
> Calling it "mpu_iva" is fine with me also.
>

OK, will use "mpu_iva" and "core".  I much prefer these to vdd1 & vdd2.

>> > >   static struct powerdomain dpll1_pwrdm = {
>> > 
>> > These DPLL powerdomains should have voltagedomains also.  DPLL1 is in
>> > VDD1, I believe.  I think the rest are in VDD2.
>> 
>> DPLL1 (MPU) & DPLL2 (IVA) are inside vdd1, DPLL3, 4 & 5 are inside the core
>> (vdd2)
>
> Indeed.
>

Thanks, will fix.

Kevin

