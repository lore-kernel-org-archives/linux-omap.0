From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: Renaming elpida_ecb240abacn.dtsi as lpddr2_data.dtsi
Date: Thu, 11 Oct 2012 10:28:10 +0200
Message-ID: <5076831A.4020701@ti.com>
References: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com> <1349870716-25511-2-git-send-email-lokeshvutla@ti.com> <50758AA0.5080307@ti.com> <5076644D.5050703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53852 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab2JKI2V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 04:28:21 -0400
In-Reply-To: <5076644D.5050703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, devicetree-discuss@lists.ozlabs.org

On 10/11/2012 08:16 AM, Lokesh Vutla wrote:
> + devicetree-discuss
> 
> Hi Benoit,
> 
> On Wednesday 10 October 2012 08:18 PM, Benoit Cousson wrote:
>> Hi Lokesh,
>>
>> On 10/10/2012 02:05 PM, Lokesh Vutla wrote:
>>> Renaming elpida_ecb240abacn.dtsi file generic, so that the
>>> same file can be reused for other parts from different vendors.
>>
>> Could you elaborate a little bit?
>> Are these settings purely reflecting lpddr2 spec timings?
> 
> The basic idea is to group data for all the lpddr2 devices in a single
> file instead of creating separate file for each lpddr2 device.
> 
> Right now the file elpida_ecb240abacn.dtsi contains only data for
> lpddr2-s4 2G parts from Elpida.
> I wanted to add data for lpddr2-s4 4G parts from Samsung.
> So I renamed the file elpida_ecb240abacn.dtsi as lpddr2_data.dtsi.
> 
> Please let me know if more clarification is needed.

Well, not anymore... as explained in the previous email, you should not
do that.
Keep the Elpida file and create another one for the Samsung part.
Then each board will be able to select the proper one and include only
the relevant data.

Regards,
Benoit

