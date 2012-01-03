From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/3] of/base: Take NULL string into account for property
 with multiple strings
Date: Tue, 3 Jan 2012 15:15:05 +0100
Message-ID: <4F030D69.5010709@ti.com>
References: <1323095036-3739-1-git-send-email-b-cousson@ti.com> <1323095036-3739-2-git-send-email-b-cousson@ti.com> <4EEF4401.1060303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35166 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158Ab2ACOP2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jan 2012 09:15:28 -0500
In-Reply-To: <4EEF4401.1060303@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: Rob Herring <robherring2@gmail.com>, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Grant,

On 12/19/2011 3:02 PM, Rob Herring wrote:
> On 12/05/2011 08:23 AM, Benoit Cousson wrote:
>> The current implementation just ignore any NULL string inserted in a
>> multiple strings property.
>> In some cases we can have a property with a fix number of strings but
>> not necessarily used, like for example in a list of valid pinmux modes.
>>
>>   prop = "uart_rx", "uart_tx", "", "", "safe_mode";
>>
>> Do no skip NULL string and take them into account in
>> of_property_read_string_index and of_property_count_strings.
>>
>> Reported-by: Tony Lindgren<tony@atomide.com>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Rob Herring<rob.herring@calxeda.com>
>
> Applied. The others need Grant's agreement.

New year gentle ping.

Thanks,
Benoit
