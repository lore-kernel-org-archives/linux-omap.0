From: Kishon Vijay Abraham I <kishon@TI.COM>
Subject: Re: [PATCH v2 0/3] PCI: designware/dra7xx: misc fixes and cleanups
Date: Thu, 12 Jan 2017 19:10:01 +0530
Message-ID: <58778731.8060700@ti.com>
References: <1483091774-8332-1-git-send-email-kishon@ti.com>
 <20170111212135.GN14532@bhelgaas-glaptop.roam.corp.google.com>
 <587712B0.2030806@ti.com>
 <20170112131552.GA23045@bhelgaas-glaptop.roam.corp.google.com>
 <5877835D.80508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5877835D.80508@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@TI.COM
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 12 January 2017 06:53 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Thursday 12 January 2017 06:45 PM, Bjorn Helgaas wrote:
>> On Thu, Jan 12, 2017 at 10:52:56AM +0530, Kishon Vijay Abraham I wrote:
>>> Hi Bjorn,
>>>
>>> On Thursday 12 January 2017 02:51 AM, Bjorn Helgaas wrote:
>>>> On Fri, Dec 30, 2016 at 03:26:11PM +0530, Kishon Vijay Abraham I wrote:
>>>>> This series contains
>>>>>         *) a patch to cleanup dra7xx probe
>>>>>         *) a patch to force DRA7xx controller to work in GEN1 mode
>>>>>         *) a patch to fix dra7xx driver so that even if CONFIG_PCI_MSI
>>>>>            is enabled, dra7xx driver can service legacy interrupts
>>>>>            (provided the device support only legacy interrupts).
>>>>>
>>>>> Changes from v1:
>>>>> *) rebased to 4.10-rc1 (and [1])
>>>>> *) use existing dt property "max-link-speed" instead of creating a new
>>>>>    TI specific dt property.
>>>>>
>>>>> [1] -> https://lkml.org/lkml/2016/12/28/34
>>>>>
>>>>> Kishon Vijay Abraham I (3):
>>>>>   PCI: dra7xx: simplify the probe code
>>>>>   PCI: dra7xx: Add support to force RC to work in GEN1 mode
>>>>>   PCI: dra7xx: Enable MSI and legacy interrupts simultaneously
>>>>>
>>>>>  drivers/pci/controller/pci-dra7xx.c |   81 ++++++++++++++++++++---------------
>>>>>  1 file changed, 47 insertions(+), 34 deletions(-)
>>>>
>>>> Applied to pci/host-dra7xx for v4.11.  I haven't applied the directory
>>>> rename yet, so I'll fix that up as necessary.
>>>
>>> I'd have liked that to be merged as well. Is that because Arnd hasn't Acked
>>> that one yet?
>>
>> Nope, I expect to do the rename in some form.  I'm just trying to
>> clear out the easy stuff first before moving on to the harder patches
>> in the queue.
> 
> cool, thanks. Let me know if I have to resend the patches based on one of your
> branches (i.e after you apply the easy stuff).

Btw, I had sent a new patch series [1] which had a couple of additional patches
(that was after creating drivers/pci/dwc/). Consider merging that too or I can
resend the missing patches.

Thanks
Kishon

[1] -> https://lkml.org/lkml/2017/1/11/238
> 
> Thanks
> Kishon
> 
