From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [PATCH v2] twl4030: Fix boot with twl4030 usb transceiver enabled
Date: Thu, 01 Oct 2009 11:41:04 +0300
Message-ID: <4AC46B20.6020300@nokia.com>
References: <1254385536-26912-1-git-send-email-ext-roger.quadros@nokia.com> <1254386189.32310.20.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56723 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbZJAImP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 04:42:15 -0400
In-Reply-To: <1254386189.32310.20.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "dedekind1@gmail.com" <dedekind1@gmail.com>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Artem Bityutskiy wrote:
> On Thu, 2009-10-01 at 11:25 +0300, Roger Quadros wrote:
>>  	if (twl_has_bci() && pdata->bci && !(features & TPS_SUBSET)) {
>>  		child = add_child(3, "twl4030_bci",
>> @@ -532,16 +531,61 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
>>  	}
>>  
>>  	if (twl_has_usb() && pdata->usb) {
>> +
> Why is this extra line?
> 
>> +		static struct regulator_consumer_supply usb1v5 = {
>> +			.supply =	"usb1v5",
>> +		};
> 

oops, my bad. and checkpatch didn't point it out ;)
