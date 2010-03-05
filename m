From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/2] arm: omap: ehci: avoid compiler error with
 touchbook
Date: Fri, 5 Mar 2010 09:03:30 +0200
Message-ID: <20100305070330.GB12757@nokia.com>
References: <20100304074434.GI15954@nokia.com>
 <1267688753-6344-1-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321CBCDFE@dbde02.ent.ti.com>
 <a05a09f453a7473f2ba54a9056589b72@secure211.sgcpanel.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58455 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab0CEHEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 02:04:21 -0500
Content-Disposition: inline
In-Reply-To: <a05a09f453a7473f2ba54a9056589b72@secure211.sgcpanel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext me@felipebalbi.com" <me@felipebalbi.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Thu, Mar 04, 2010 at 08:15:27PM +0100, ext me@felipebalbi.com wrote:
>Hi,
>
>On Thu, 4 Mar 2010 18:33:15 +0530, "Gadiyar, Anand" <gadiyar@ti.com>
>wrote:
>>> This patch fixes that for the ehci_hdc_omap_platform_data.
>>>
>>
>> should be ehci_hcd_omap_platform_data ;)
>>
>> BTW, this breaks compile for omap3-evm.
>> Could you please build with omap3_defconfig and check.
>
>will do first thing tomorrow :-)

yeah, it breaks because evm tries to assign to a (now) const variable. 
Maybe the only way is to move everybody out of the __initconst section 
and put them on __initdata.

or we drop the revision check for EVM and use only the newer one, I'm 
more into doing the first one.

Tony, do you have any comments ??

-- 
balbi
