From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/5] phy: add support for indexed lookup
Date: Wed, 15 Jan 2014 19:41:17 +0530
Message-ID: <52D69705.6010500@ti.com>
References: <1386601737-8735-1-git-send-email-heikki.krogerus@linux.intel.com> <1386601737-8735-3-git-send-email-heikki.krogerus@linux.intel.com> <52AEDDE2.8060406@ti.com> <20131216143227.GA22944@xps8300> <52CC03D4.50603@ti.com> <20140114142310.GA21169@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140114142310.GA21169@xps8300>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Heikki,

On Tuesday 14 January 2014 07:53 PM, Heikki Krogerus wrote:
> Hi Kishon,
> 
> And happy new year..

Happy new year :-)
> 
> On Tue, Jan 07, 2014 at 07:10:36PM +0530, Kishon Vijay Abraham I wrote:
>>>>>  /**
>>>>> - * phy_get() - lookup and obtain a reference to a phy.
>>>>> + * phy_get_index() - obtain a phy based on index
>>>>
>>>> NAK. It still takes a 'char' argument and the name is misleading.
>>>> Btw are you replacing phy_get() or adding a new API in addition to phy_get()?
>>>
>>> Additional API. The phy_get() would in practice act as a wrapper after
>>
>> In this patch it looks like you've replaced phy_get().
>>> this. It could actually be just a #define macro in the include file.
>>> The function naming I just copied straight from gpiolib.c. I did not
>>> have the imagination for anything fancier.
>>>
>>> I would like to be able to use some function like phy_get_index() and
>>> be able to deliver it both the name and the index. With DT you guys
>>> will always be able to use the name (and the string will always
>>> supersede the index if we do it like this), but with ACPI, and possibly
>>> the platform lookup tables, the index can be used...
>>
>> I think in that case, we should drop the 'string' from phy_get_index since we
>> have the other API to handle that? I don't know about ACPI, but is it not
>> possible to use strings with ACPI?
> 
> No unfortunately. We just have what the ACPI tables provide. The PHYs
> would be "child" device entries under the controller and we can only
> get handle to them based on the index.
> 
> I think I'll skip this patch from this set. Let's wait until we have
> an actual ACPI DSDT describing some PHYs.

yeah.. sure.

Cheers
Kishon
