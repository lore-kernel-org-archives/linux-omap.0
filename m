From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Tue, 7 Jun 2011 09:12:51 +0200
Message-ID: <4DEDCF73.9030607@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>	 <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>	 <871uzahnib.fsf@ti.com> <1307122985.2016.72.camel@deskari>	 <87hb86a5mm.fsf@ti.com> <1307174504.1777.24.camel@lappyti>	 <4DECCE90.6070201@ti.com> <1307429265.1858.6.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46511 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1FGHM4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 03:12:56 -0400
In-Reply-To: <1307429265.1858.6.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

On 6/7/2011 8:47 AM, Valkeinen, Tomi wrote:
> On Mon, 2011-06-06 at 14:56 +0200, Cousson, Benoit wrote:
>
>> That terminology in the PRCM just means that an opt clock will not be
>> handled automatically by the PRCM and will require SW control.
>> This is not the case for mandatory clock. Upon module enable the PRCM
>> will ensure that all mandatory clocks (functional and interface) are
>> enabled automagically. If the clock is marked as optional it means that
>> the SW will have to enable it explicitly before enabling the module.
>
> Is that correct? This would mean that whenever a hwmod has opt clock, it
> needs to implement similar hack functions that are present in this
> patch, to be able to enable the opt clock before enabling the hwmod, and
> to disable the opt clock after disabling the hwmod.

No, because most hwmods with opt_clock does have a real main_clk as 
well. In the case of the GPIO, the driver need to enable the opt clock 
only if the debounce feature is needed.
In general we always have one main functional clock to enable the module 
first.

> I'd rather hope the optional clock could be enabled whenever the driver
> needs it, between enabling and disabling the hwmod.

Yeah, this is the case most of the time, except for you.

> If it's required that the opt clocks are enabled before enabling the
> hwmod, what is the point of having them as optional and driver
> controlled? The hwmod fmwk could as well handle the opt clocks in that
> case.

There is no point... It is just due to the particular clock setting 
required by the DSS. That specific case was simply not taken into 
account originally. You are just the first one to hit that issue :-(

Just because the DSS can choose its main functional clock, the HW team 
decided to mark them all as opt clock, in order to let the SW decide 
which one to use.

Regards,
Benoit
