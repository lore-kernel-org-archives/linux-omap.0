From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 7/7] OMAP3: powerdomain data: add voltage domains
Date: Tue, 22 Mar 2011 22:09:35 +0100
Message-ID: <4D89100F.1000909@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com> <1300493932-17362-8-git-send-email-khilman@ti.com> <alpine.DEB.2.00.1103221324461.11798@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60174 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab1CVVJf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Mar 2011 17:09:35 -0400
In-Reply-To: <alpine.DEB.2.00.1103221324461.11798@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 3/22/2011 8:30 PM, Paul Walmsley wrote:
> Hi Kevin,
>
> a couple of comments below..
>
> On Fri, 18 Mar 2011, Kevin Hilman wrote:
>
>> Add voltage domain name to indicate which voltagedomain each
>> powerdomain is in.  A missing voltage domain name means that that
>> powerdomain is not in one of the currently scalable voltage domains.
>
> Before you add these, you might want to change the voltagedomain names for
> OMAP3.  I don't think it's correct to refer to the VDD1 voltagedomain as
> "mpu" since it includes both the MPU and IVA.  Probably best to use simply
> "vdd1" and "vdd2" since that is the historical usage.

Yes, but it was confusing, hence the change on OMAP4.
"core" is fine and better that vdd2, maybe "mpu_iva" will be better for 
vdd1.
Moreover, it will be consistent will all the OMAP4+ chips.

[...]

>>   static struct powerdomain dpll1_pwrdm = {
>
> These DPLL powerdomains should have voltagedomains also.  DPLL1 is in
> VDD1, I believe.  I think the rest are in VDD2.

DPLL1 (MPU) & DPLL2 (IVA) are inside vdd1, DPLL3, 4 & 5 are inside the 
core (vdd2)

Benoit
