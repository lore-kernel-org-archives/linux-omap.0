From: Vikas Sajjan <vikas.sajjan@linaro.org>
Subject: Re: [PATCH v3 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Fri, 26 Oct 2012 10:34:22 +0530
Message-ID: <CAD025ySWpF-_o4K030Sib2NsZXA3Qcw0MN8qpTZhPn4OR170EQ@mail.gmail.com>
References: <20121018150009.GT5378@xanatos>
	<Pine.LNX.4.44L0.1210181244080.1495-100000@iolanthe.rowland.org>
	<20121018172936.GB7823@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:33930 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128Ab2JZFEX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 01:04:23 -0400
Received: by mail-gh0-f174.google.com with SMTP id g15so485589ghb.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 22:04:22 -0700 (PDT)
In-Reply-To: <20121018172936.GB7823@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Alan Stern <stern@rowland.harvard.edu>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

Hi Felipe,

On 18 October 2012 22:59, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Oct 18, 2012 at 12:44:50PM -0400, Alan Stern wrote:
>> On Thu, 18 Oct 2012, Sarah Sharp wrote:
>>
>> > For system suspend while the DW3 hardware is in host mode, doesn't the
>> > USB core prevent drivers from submitting URBs just before the
>> > PCI/platform suspend is called?  Alan?
>>
>> Sure it does.
>
> ok great, so my concerns is limited to the gadget side ;-) I still want
> to see both sides tested, though.
>
> (sorry guys, but with DWC3 now passing full USB3 certification, I want
> to be very careful with patches I accept, specially related to PM ;-)
>
> --
> balbi

Will test both HOST and GADGET mode as per your suggestion and update you.

-- 
Thanks and Regards
 Vikas Sajjan
