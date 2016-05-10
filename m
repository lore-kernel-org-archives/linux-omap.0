From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v7 3/5] usb: dwc3: omap: Don't set POWERPRESENT
Date: Tue, 10 May 2016 13:23:41 +0300
Message-ID: <5731B6AD.9070108@ti.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com>
 <1462873919-20532-4-git-send-email-rogerq@ti.com>
 <87futqi6gs.fsf@linux.intel.com> <5731B118.1010705@ti.com>
 <874ma6i5zi.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <874ma6i5zi.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/05/16 13:04, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>> On 10/05/16 12:54, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Roger Quadros <rogerq@ti.com> writes:
>>>> TRM [1] recommends that POWERPRESENT bit must not be
>>>> set and left at it's default value of 0.
>>>>
>>>> [1] OMAP542x TRM - http://www.ti.com/lit/pdf/swpu249
>>>> Section 23.11.4.5.1 Mailbox VBUS/ID Management
>>>>
>>>> "Because PIPE powerpresent has a different meaning in host and in device mode,
>>>> and because of the redundancy with the UTMI signals, the controller ORes
>>>> together the appropriate PIPE and UTMI inputs to create its internal
>>>> VBUS status. For that reason, it is recommended to leave field
>>>> USBOTGSS_UTMI_OTG_STATUS[9] POWERPRESENT at its default value (=0), and only to
>>>> fill in the USB2 VBUS status fields in the same register."
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>
>>> to make sure we avoid regressions, do you mind sharing on which
>>> platforms you tested this patch ?
>>>
>> I tested this on omap5-uevm and dra7-evm.
>> My am437x board stopped working so couldn't test on that one.
> 
> would you have a colleague or perhaps an automated test-farm which could
> run the test for you ? :-)
> 
> I can take the patch, no problem, but if there are any regressions don't
> blame me :-)
> 
Don't worry, blame is on the TRM then :).

cheers,
-roger
