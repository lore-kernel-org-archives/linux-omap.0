From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/7] omap4: Temporary fix silicon version detection
Date: Thu, 09 Sep 2010 13:47:12 +0200
Message-ID: <4C88C940.6070000@ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com> <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com> <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com> <20100909114255.GK21060@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52609 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443Ab0IILrS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Sep 2010 07:47:18 -0400
In-Reply-To: <20100909114255.GK21060@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi Santosh,

On 9/9/2010 1:42 PM, Felipe Balbi wrote:
> Hi,
>
> On Thu, Sep 09, 2010 at 06:23:10AM -0500, Santosh Shilimkar wrote:
>> @@ -308,6 +308,16 @@ static void __init omap4_check_revision(void)
>> 	hawkeye = (idcode>>  12)&  0xffff;
>> 	rev = (idcode>>  28)&  0xff;
>>
>> +	/*
>> +	 * FIXME: This patch should be reverted later.
>> +	 * Few initial ES2.0 samples IDCODE is same as ES1.0
>> +	 * Use ARM register to detect the correct ES version
>> +	 */
>
> I wonder if it actually doesn't make sense to keep this in tree, the
> overhead is minimum when rev is set correctly and it's safe for the
> initial es2.0 samples which are buggy.

Yep, I agree with that, if some early ES2 samples are already out there, 
we will have no way to control the device upgrade in the future. So we 
will still have to support these early buggy devices just in case.

Benoit


