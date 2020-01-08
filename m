From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [BUG]: usb: dwc3: gadget: broken on OMAP5432
Date: Wed, 8 Jan 2020 15:02:09 +0100
Message-ID: <8E70227F-28DB-4C38-9EA4-FB5B0260C88F@goldelico.com>
References: <703DD239-8E3B-405C-A531-FF7DEEED38DC@goldelico.com> <7daf64ba-7efb-e2f1-a449-f5f3791a3c8e@synopsys.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7daf64ba-7efb-e2f1-a449-f5f3791a3c8e@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejas Joglekar <Tejas.Joglekar@synopsys.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, "kernel@pyra-handheld.com" <kernel@pyra-handheld.com>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 08.01.2020 um 10:06 schrieb Tejas Joglekar <Tejas.Joglekar@synopsys.com>:
> 
> Hi,
> On 1/8/2020 2:29 PM, H. Nikolaus Schaller wrote:
>> Hi,
>> I noticed that the usb ethernet gadget driver is broken since v5.5-rc2
>> and 5.4.4, but only for our OMAP5 board. Our OMAP3 boards work with
>> the same tree, kernel binary and user-space (Debian Stretch).
>> 
>> The symptom is that I can see the interface on the host PC being
>> enumerated and IP addresses etc. are set up. But a ping in either
>> direction fails/times out.
>> 
>> After inspecting diffs I found some changes in dwc3:gadget
>> and indeed omap3/twl4030 uses musb and omap5 uses dwc3.
>> 
>> Reverting
>> 
>> a7f7e61270f1 ("usb: dwc3: gadget: Fix logical condition");
>> 
>> on v5.5-rc makes it work again.
>> 
>> BTW: v4.19.90 works although it includes this logical condition fix.
>> So the real difference between v4.19 and v5.5 may be elsewhere in
>> newer kernels and only be revealed by the patch.
>> 
>> If important: my setup is running with USB2 cable and speed
>> only.
>> 
>> So please check this and other recent dwc3 patches for introducing
>> a stall of communication.
>> 
> Another gadget driver issue was reported by Thinh after my fix, and he has submitted a patch for the same. You can refer the discussion https://patchwork.kernel.org/patch/11292087/.
> Can you check if that patch works for you ?

Yes, it does!

So you can add my

Tested-By: H. Nikolaus Schaller <hns@goldelico.com>

if possible (I can't reply to the original discussion).

Would be nice if you can get it into 5.5-rc series and 5.4.y asap.
 
BR and thanks for the quick response and solution,
Nikolaus Schaller
