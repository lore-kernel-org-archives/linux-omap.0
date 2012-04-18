From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: omap: hwmod: warn only when clkdm is missing from
 both clk and hwmod
Date: Wed, 18 Apr 2012 10:09:39 +0200
Message-ID: <4F8E76C3.7080803@ti.com>
References: <1334238098-29859-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204121106010.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40852 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab2DRIJs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 04:09:48 -0400
In-Reply-To: <alpine.DEB.2.00.1204121106010.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 4/12/2012 7:06 PM, Paul Walmsley wrote:
> Hi
>
> On Thu, 12 Apr 2012, Rajendra Nayak wrote:
>
>> On OMAP4+, the clkdm association is moved to hwmod while on older OMAPs'
>> its associated with a clk.
>
> Sounds like this should be conditional based on the platform, then,
> rather than weakening the warning for all platforms ?

Well, as already discussed the clockdomain information is mostly useless 
for most clock nodes because the HW is taking care of the dependencies, 
so highlighting only the ones missing in hwmod is far from enough and 
will avoid scaring people with something that is normal.

Considering that OMAP4 clock domain partition is way more complex than 
it was on OMAP2 & 3, if OMAP4 can leave without that, I doubt OMAP2 & 3 
clock nodes will ever need it, except HW bugs, as usual.

But still, it is an exception more than the regular case.

>> Hence look for a clkdm in both clk and hwmod and warn only when
>> its missing in both. Also fix the pr_warning() to print the correct
>> hwmod name.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,
Benoit
