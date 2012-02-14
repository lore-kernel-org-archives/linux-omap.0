From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HACK: Ensure DSS clock domain gets out of
 idle when HDMI is enabled
Date: Tue, 14 Feb 2012 13:58:05 +0100
Message-ID: <4F3A5A5D.4020906@ti.com>
References: <1328854552-30714-1-git-send-email-archit@ti.com> <1329220678.1845.68.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59503 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977Ab2BNM6N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 07:58:13 -0500
In-Reply-To: <1329220678.1845.68.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org

Hi Tomi,

On 2/14/2012 12:57 PM, Tomi Valkeinen wrote:
> Hi,
>
> On Fri, 2012-02-10 at 11:45 +0530, Archit Taneja wrote:
>> For DSS clock domain to transition from idle to active state. It's necessary
>> to enable the optional clock DSS_FCLK before we enable the module using the
>> MODULEMODE bits in the clock domain's CM_DSS_DSS_CLKCTRL register.
>>
>> This sequence was not followed correctly for the 'dss_hdmi' hwmod and it led
>> to DSS clock domain not getting out of idle when pm_runtime_get_sync() was
>> called for hdmi's platform device.
>>
>> Since the clock domain failed to change it's state to active, the hwmod code
>> disables any clocks it had enabled before for this hwmod. This led to the clock
>> 'dss_48mhz_clk' gettind disabled.
>>
>> When hdmi's runtime_resume() op is called, the call to dss_runtime_get()
>> correctly enables the DSS clock domain this time. However, the clock
>> 'dss_48mhz_clk' is needed for HDMI's PHY to function correctly. Since it was
>> disabled previously, the driver fails when it tries to enable HDMI's PHY.
>>
>> Fix this for now by ensuring that dss_runtime_get() is called before we call
>> pm_runtime_get_sync() for hdmi's platform device. A correct fix for later would
>> be to modify the DSS related hwmod's mainclks, and also some changes in how
>> opt clocks are handled in the DSS driver.
>>
>> This fixes the issue of HDMI not working when it's the default display. The
>> issue is not seen if any other display is already enabled as the first display
>> would have correctly enabled the DSS clockdomain.
>
> I think this looks fine, it's shouldn't have any side effects and is
> easy to remove later.
>
> Benoit, do you think we'll get the MODULEMODE mess cleaned up in the
> hwmod/clk framework at some point, and the drivers could do without
> these kinds of hacks? =)

The best way to fix that for my point of view is to go to device tree 
or/and to consider the DSS as the parent of all the DSS modules.
pm_runtime will then always ensure that the parent is enabled before any 
of the child are used.

Implementing that with hwmod is not the right approach since is will 
require to add some more complex OMAP custom stuff in the hwmod fmwk 
whereas the LDM is already able to handle that.

The whole point is that going to device tree, we will have to change the 
responsibility of hwmod to make it focus mainly on OMAP PRCM stuff and 
let the device handles the IRQ/DMA/REG/CLKS resources since it is the 
correct place to do that.


Regards,
Benoit
