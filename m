From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/3] OMAP4: powerdomain data: Fix core mem states and
 missing cefuse flag
Date: Fri, 1 Jul 2011 12:09:33 +0200
Message-ID: <4E0D9CDD.6090008@ti.com>
References: <1308847544-2322-1-git-send-email-b-cousson@ti.com> <1308847544-2322-4-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1106301730340.2874@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55304 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755161Ab1GAKJi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 06:09:38 -0400
In-Reply-To: <alpine.DEB.2.00.1106301730340.2874@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On 7/1/2011 1:48 AM, Paul Walmsley wrote:
> On Thu, 23 Jun 2011, Benoit Cousson wrote:
>
>> Since ES2.0, the core ocmram does not support a different state
>> than the main power domain anymore during both ON and RET power
>> domain state.
>> Since PM is not supported at all in ES1.0, update the common
>> structure.
>>
>> LOWPOWERSTATECHANGE is supported by the cefuse power domain but
>> the flag was missing.
>> Add the PWRDM_HAS_LOWPOWERSTATECHANGE in flags field.
>>
>> Indent all previous flags to be aligned with other fields.
>>
>> Update the TI copyright date to 2011.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Rajendra Nayak<rnayak@ti.com>
>> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
>
> Reviewed-by: Paul Walmsley<paul@pwsan.com>
>
> I guess the CEFUSE LOWPOWERSTATECHANGE bit is in the Security TRM?

Good question... but I think so.

Benoit

