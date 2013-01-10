From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v3 0/3] ARM: dts: omap: add dt data for MUSB
Date: Thu, 10 Jan 2013 10:58:14 +0100
Message-ID: <50EE90B6.2060308@ti.com>
References: <1348047128-25692-1-git-send-email-kishon@ti.com> <505A8BAB.2020004@ti.com> <20121227183524.GB7097@blackmetal.musicnaut.iki.fi> <50EE5D61.1020307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50EE5D61.1020307@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon <kishon@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, tony@atomide.com, linux@arm.linux.org.uk, balbi@ti.com, gregkh@linuxfoundation.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

On 01/10/2013 07:19 AM, kishon wrote:
> On Friday 28 December 2012 12:05 AM, Aaro Koskinen wrote:
>> Hi,
>>
>> On Thu, Sep 20, 2012 at 05:21:15AM +0200, Benoit Cousson wrote:
>>> On 09/19/2012 11:32 AM, Kishon Vijay Abraham I wrote:
>>>> This patch series adds dt data to get MUSB working in omap4 and omap3
>>>>
>>>> Changes from v2:
>>>> * Changes the subject of all the patches to include "ARM: dts:"
>>>> * Added reg property and interrupt property for "usb_otg_hs".
>>>> Previously these
>>>>    were obtained from ti,hwmods property.
>>>> * Rebased on
>>>>   
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>>>> devel-dt
>>>>
>>>> Changes from v1:
>>>> Just removed the omap-usb2 dt data and sent that as a separate patch.
>>>>
>>>> Kishon Vijay Abraham I (3):
>>>>    ARM: dts: Add twl6030-usb data
>>>>    ARM: dts: Add twl4030-usb data
>>>>    ARM: dts: omap: Add usb_otg and glue data
>>>
>>> Thanks for the update. I've just pulled the series for 3.7.
>>
>> I wonder what happened to the patch #3 (Add usb_otg and glue data)
>> of this series? Why was it dropped? I cannot see it in 3.7 or 3.8-rc1.

I don't remember the context, can you repost it rebased on 3.8-rc2? Did
it generate some discussion at that time?

Benoit
