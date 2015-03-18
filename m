From: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 0/5] Add support for Fujitsu USB host controller
Date: Thu, 19 Mar 2015 00:02:33 +0800
Message-ID: <CAJ1gpc2fnBfOKmiv0SsZt5-8qMh9yhpjqLh2+pcCDbpbg-UkBw@mail.gmail.com>
References: <1424579140-30567-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
	<20150310213023.GL25666@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150310213023.GL25666-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sneeker Yeh <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2015-03-11 5:30 GMT+08:00 Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>:
> On Sun, Feb 22, 2015 at 12:25:35PM +0800, Sneeker Yeh wrote:
>> These patches add support for XHCI compliant Host controller found
>> on Fujitsu Socs, and are based on http://lwn.net/Articles/629162/
>> The first patch is to add Fujitsu glue layer of Synopsis DesignWare USB3 driver
>> and last four patch is about quirk implementation of errata in Synopsis
>> DesignWare USB3 IP.
>>
>> Patch 1 introduces a quirk with device disconnection management necessary
>> Synopsys Designware USB3 IP with versions < 3.00a and hardware configuration
>> DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1. It solves a problem where without the
>> quirk, that host controller will die after a usb device is disconnected from
>> port of root hub.
>>
>> Patch 2 is to set Synopsis quirk in xhci platform driver based on xhci platform
>> data.
>>
>> Patch 3 is to add a revison number 2.90a and 3.00a of Synopsis DesignWare USB3
>> IP core driver.
>>
>> Patch 4 introduces using a quirk based on a errata of Synopsis
>> DesignWare USB3 IP which is versions < 3.00a and has hardware configuration
>> DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1, which cannot be read from software. As a
>> result this quirk has to be enabled via platform data or device tree.
>>
>> Patch 5 introduces Fujitsu Specific Glue layer in Synopsis DesignWare USB3 IP
>> driver.
>>
>> Successfully tested on Fujitsu mb86s7x board.
>>
>> Changes since v4 (RFC):
>> [https://lkml.org/lkml/2015/2/17/13]
>>  - based on Felipe's comment, rename dwc3-mb86s70.c to dwc3-fujitsu.c which is
>>    more generic.
>>  - based on Mathias's comment, remove unhelpful comment, and change the
>>    function name of xhci_try_to_clear_csc() to xhci_late_csc_clear_quirk()
>>    which is more appropriate.
>>
>> Changes since v3 (RFC):
>> [https://lkml.org/lkml/2015/1/25/8]
>>  - based on Mathias's comment, fix bug and using xhci_port_state_to_neutral()
>>    helper function to mask out some RW1C bits, prevent writing back all the
>>    bits read from the PORTSC register.
>>
>> Changes since v2 (RFC):
>> [https://lkml.org/lkml/2015/1/19/55]
>>  - based on Felipe's comment, re-order patches to avoid breaking bisectability,
>>  - based on Felipe's comment, add comment to structure's member, and sort it
>>    alphabetically,
>>  - based on Felipe's comment, add another v2.90 revision number in dwc3 IP.
>>
>> Changes since v1 (RFC):
>> [https://lkml.org/lkml/2014/12/15/929]
>>  - based on Arnd's comment, remove entire unnecessary Fujitsu EHCI/OHCI glue,
>>  - based on Felipe's comment, fix mis-using of runtime-pm API and setting dma
>>    mask, remove unnecessary comment, and refactor suspend/resume handler in
>>    Fujitsu Specific Glue layer in dwc3,
>>  - based on Felipe's comment, add more commit log and comments in Synopsis
>>    quirk implementation, and separate it into four patches.
>>
>> Sneeker Yeh (5):
>>   xhci: add a quirk for device disconnection errata for Synopsis
>>     Designware USB3     core
>>   xhci: Platform: Set Synopsis device disconnection quirk based on
>>     platform data
>>   usb: dwc3: add revision number DWC3_REVISION_290A and
>>     DWC3_REVISION_300A
>>   usb: dwc3: Add quirk for Synopsis device disconnection errata
>>   usb: dwc3: add Fujitsu Specific Glue layer
>
> Mathias, if you want me to take this series I need your Acked-by,
> otherwise I can give you mine, just let me know.

Hi Mathias, I hope I'm not imposing here,
but would you let me know if there's any further comment for the patchset.

Much appreciate,
Sneeker

>
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
