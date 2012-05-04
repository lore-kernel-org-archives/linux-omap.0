From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v4 02/39] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Fri, 4 May 2012 11:30:21 -0500
Message-ID: <4FA4041D.9010000@ti.com>
References: <cover.1335874494.git.afzal@ti.com> <e0cf9678cb9a44d2a16401383ab8496eb825c291.1335874494.git.afzal@ti.com> <4FA04A8C.4050703@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E98299B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57782 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab2EDQai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 12:30:38 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E98299B@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Menon, Nishanth" <nm@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "notasas@gmail.com" <notasas@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "vimal.newwork@gmail.com" <vimal.newwork@gmail.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi Afzal,

On 05/03/2012 03:37 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Wed, May 02, 2012 at 02:11:48, Hunter, Jon wrote:
>>> +
>>> +	pdata->clk_prd = gpmc_get_fclk_period();
>>
>> Does this need to be done here? May be this should be done in the probe
>> function. You could store the handle to the main clk in the pdata.
> 
> This is done so that migration of gpmc driver to the drivers folder
> would be smooth, remember that this function will still live here.

Sure, but why call this here?

>>> +		pr_err("error: clk_get on %s\n", oh->main_clk);
>>> +		return -EINVAL;
>>>  	}
>>>  
>>>  	clk_enable(gpmc_l3_clk);
>>
>> I would have thought we should be able to remove the gpmc_init function
>> completely by now. Most of the code should be moved to the probe function.
>>
>> Also now with hwmod in place, we should be able to remove the
>> clk_enable/disable functions and use the pm_runtime APIs instead.
> 
> There was no plan to add rpm in this series, but now that you have
> brought it up, I will adapt the driver to rpm.

Ok, great.

Jon
