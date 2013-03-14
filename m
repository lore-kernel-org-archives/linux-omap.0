From: kishon <kishon@ti.com>
Subject: Re: [PATCH v2 0/4] usb: musb/otg: cleanup and fixes
Date: Thu, 14 Mar 2013 20:15:00 +0530
Message-ID: <5141E26C.10700@ti.com>
References: <1363242239-1061-1-git-send-email-kishon@ti.com> <20130314133313.GB26080@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130314133313.GB26080@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, notasas@gmail.com
List-Id: linux-omap@vger.kernel.org

On Thursday 14 March 2013 07:03 PM, Felipe Balbi wrote:
> On Thu, Mar 14, 2013 at 11:53:55AM +0530, Kishon Vijay Abraham I wrote:
>> This series has some misc cleanup and fixes. The fix solves the cold
>> plug issue in omap3 which some have reported. Developed these patches on
>> fixes-for-v3.9-rc3 after applying
>> http://www.spinics.net/lists/linux-usb/msg81563.html
>> (Grazvydas Ignotas patch series)
>>
>> Tested for g_zero enumeration in pandaboard and beagleboard in both
>> cold plug and hot plug case. Any kind of testing for this series is welcome.
>>
>> Changes from v1:
>> * removed *usb: musb: omap: remove the check before calling otg_set_vbus*

er.. removed *usb: musb: omap: always glue have the correct vbus/id 
status* since a patch similar to it is already merged.
>
> it's still on your list of patches :-p
>
>> a similar patch is already merged.
>>
>> Kishon Vijay Abraham I (4):
>>    usb: musb: omap: remove the check before calling otg_set_vbus
>
> see ^^
>
> please fix it up and when resending add Grazvydas' Tested-by since he
> has tested this patchset

Ok.

Thanks
Kishon
