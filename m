From: kishon <kishon@ti.com>
Subject: Re: [PATCH 0/5] usb: musb/otg: cleanup and fixes
Date: Wed, 20 Mar 2013 20:52:36 +0530
Message-ID: <5149D43C.3060506@ti.com>
References: <1363164430-19118-1-git-send-email-kishon@ti.com> <20130320131240.GA15157@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130320131240.GA15157@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, notasas@gmail.com
List-Id: linux-omap@vger.kernel.org

Felipe,

On Wednesday 20 March 2013 06:42 PM, Felipe Balbi wrote:
> On Wed, Mar 13, 2013 at 02:17:05PM +0530, Kishon Vijay Abraham I wrote:
>> This series has some misc cleanup and fixes. The fix solves the cold
>> plug issue in omap3 which some have reported. Developed these patches on
>> Linux 3.9-rc2 after applying http://www.spinics.net/lists/linux-usb/msg81563.html
>> (Grazvydas Ignotas patch series)
>>
>> Tested for g_zero enumeration in pandaboard and beagleboard in both
>> cold plug and hot plug case. Any kind of testing for this series is welcome.
>>
>> Kishon Vijay Abraham I (5):
>>    usb: musb: omap: remove the check before calling otg_set_vbus
>>    usb: musb: omap: always glue have the correct vbus/id status
>>    usb: otg: twl4030: use devres API for regulator get and request irq
>>    usb: musb: omap: add usb_phy_init in omap2430_musb_init
>>    usb: otg: twl4030: fix cold plug on OMAP3
>>
>>   drivers/usb/musb/omap2430.c   |   22 ++++++++++------------
>>   drivers/usb/otg/twl4030-usb.c |   35 ++++++++++++-----------------------
>>   2 files changed, 22 insertions(+), 35 deletions(-)
>
> this needs to be rebased against my 'next' branch.

The v2 of this series is already in your testing branch. You still want 
it to be rebased to your 'next' branch?

Thanks
Kishon
