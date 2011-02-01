From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/6] omap4: powerdomain: Add supported INACTIVE power
 state
Date: Tue, 1 Feb 2011 13:39:30 +0100
Message-ID: <4D47FF02.9090709@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com> <1296212688-21951-2-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1101311613230.16671@utopia.booyaka.com> <30bccb5d133f92cdbf1a4aa75ba54e7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36156 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634Ab1BAMjh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 07:39:37 -0500
In-Reply-To: <30bccb5d133f92cdbf1a4aa75ba54e7b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2/1/2011 7:29 AM, Santosh Shilimkar wrote:
>> From: Paul Walmsley [mailto:paul@pwsan.com]
>> Sent: Tuesday, February 01, 2011 4:44 AM
>>
>> Hello Santosh,
>>
>> On Fri, 28 Jan 2011, Santosh Shilimkar wrote:
>>
>>> On OMAP4, one can explicitly program INACTIVE as the power state
>> of
>>> the logic area inside the power domain. Techincally PD state
>> programmed
>>> to ON and if all the clock domains within the PD are idled, is
>> equivalent
>>> tp PD programmed to INACTIVE and all the clock domains within the
>> PD are
>>> idled. There won't be any power difference in above two.
>>>
>>> Since the CPUIDLE C-states explicitly make use of INACTIVE as a PD
>>> targeted state and also there is some additional latancy involved
>>> with PD INACTIVE vs PD ON, it's better to support it as an explcit
>>> PD state.
>>>
>>> This patch adds the support to allow explicit PD INACTIVE
>>> programming if supported.
>>
>> What does the hardware do when the powerdomain is programmed to
>> INACTIVE?
>> Does it actually force the clockdomains idle?
>>
> No. It doesn't force it. The power domain to hit INACTIVE, the
> clockdomain within the power domain needs to idle and it is
> still a prerequisite. With INACTIVE being programmed, we could
> issue a sleep transition.
>
> PD_ON:
> No power transition, only clocks are gated. Power domain stays ON.
>
> PD_INA:
> Power domain transitions to INACTIVE state. All logic and
> memory stay powered. This state allows for a voltage
> sleep transition.

Just a small note on the latest point:
The voltage sleep transition can occur only if all power domains inside 
a voltage domain are INACTIVE, RET or OFF.

Regards,
Benoit
