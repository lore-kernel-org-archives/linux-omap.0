From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/5 v13] arm: omap: usb: ehci and ohci hwmod structures
 for omap4
Date: Tue, 11 Oct 2011 10:01:54 +0200
Message-ID: <4E93F7F2.5090805@ti.com>
References: <1317901099-2519-1-git-send-email-keshava_mgowda@ti.com> <alpine.DEB.2.00.1110101838500.5205@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1110101838500.5205@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "parthab@india.ti.com" <parthab@india.ti.com>, "tony@atomide.com" <tony@atomide.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 10/11/2011 2:40 AM, Paul Walmsley wrote:
> Hi
>
> and some comments on this one ...
>
> On Thu, 6 Oct 2011, Keshava Munegowda wrote:

[...]

>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_tll_hs = {
>> +	.master		=&omap44xx_l4_cfg_hwmod,
>> +	.slave		=&omap44xx_usb_tll_hs_hwmod,
>> +	.addr		= omap44xx_usb_tll_hs_addrs,
>> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>
> This one has the .master pointing to something reasonable, but is missing
> a .clk entry.

In that case, there is only an interface clock and a couple of optional 
clocks, that why I did not populate the main_clk.

IIRC, we decided to not duplicate the iclk into the main_clk in case of 
module that are using only the interface clock as their functional clock.

Regards,
Benoit
