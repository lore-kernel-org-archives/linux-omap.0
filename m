From: Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH v3 0/5] Add support for Fujitsu USB host controller
Date: Wed, 11 Feb 2015 13:57:58 +0200
Message-ID: <54DB43C6.1040605@intel.com>
References: <1422173608-24355-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>	<20150127152250.GB13776@saruman.tx.rr.com>	<20150129162312.GH21217@saruman.tx.rr.com>	<20150130163815.GG15318@saruman.tx.rr.com> <CAJ1gpc1PD0quDyeUcNr+CdCm78cFMua0dPhdBp-veLXWZAZe5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ1gpc1PD0quDyeUcNr+CdCm78cFMua0dPhdBp-veLXWZAZe5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sneeker Yeh <sneeker.yeh@gmail.com>, Felipe Balbi <balbi@ti.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Huang Rui <ray.huang@amd.com>, Kishon Vijay Abraham I <kishon@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andy Green <andy.green@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
List-Id: linux-omap@vger.kernel.org

On 10.02.2015 17:43, Sneeker Yeh wrote:
> Hi
> 
> 2015-01-31 0:38 GMT+08:00 Felipe Balbi <balbi@ti.com>:
>> Hi,
>>
>> On Thu, Jan 29, 2015 at 10:23:12AM -0600, Felipe Balbi wrote:
>>> On Tue, Jan 27, 2015 at 09:22:50AM -0600, Felipe Balbi wrote:
>>>> Hi,
>>>>
>>>> On Sun, Jan 25, 2015 at 04:13:23PM +0800, Sneeker Yeh wrote:
>>>>> These patches add support for XHCI compliant Host controller found
>>>>> on Fujitsu Socs, and are based on http://lwn.net/Articles/629162/
>>>>> The first patch is to add Fujitsu glue layer of Synopsis DesignWare USB3 driver
>>>>> and last four patch is about quirk implementation of errata in Synopsis
>>>>> DesignWare USB3 IP.
>>>>>
>>>>> Patch 1 introduces a quirk with device disconnection management necessary
>>>>> Synopsys Designware USB3 IP with versions < 3.00a and hardware configuration
>>>>> DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1. It solves a problem where without the
>>>>> quirk, that host controller will die after a usb device is disconnected from
>>>>> port of root hub.
>>>>>
>>>>> Patch 2 is to set Synopsis quirk in xhci platform driver based on xhci platform
>>>>> data.
>>>>>
>>>>> Patch 3 is to add a revison number 2.90a and 3.00a of Synopsis DesignWare USB3
>>>>> IP core driver.
>>>>>
>>>>> Patch 4 introduces using a quirk based on a errata of Synopsis
>>>>> DesignWare USB3 IP which is versions < 3.00a and has hardware configuration
>>>>> DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1, which cannot be read from software. As a
>>>>> result this quirk has to be enabled via platform data or device tree.
>>>>>
>>>>> Patch 5 introduces Fujitsu Specific Glue layer in Synopsis DesignWare USB3 IP
>>>>> driver.
>>>>>
>>>>
>>>> Mathias, let me know how you want to handle this. Either I take them
>>>> all, or you take them all. What do you prefer ?
>>>
>>> Mathias ?
>>
>> Mathias, a reminder on this series.
> 
> Would any problem is still in my patchset?
> e.g. I might still not arrange these patch in a appropriate order so
> that Mathias cannot review and accept these?
> 

Sorry about the delay.
Let me take a better look at the first patch and reasons behind the
race. I want to check if a quirk is enough or if we need to dig deeper into xhci.

I'll try to do it today still

-Mathias
