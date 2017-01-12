From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 0/3] PCI: designware/dra7xx: misc fixes and cleanups
Date: Thu, 12 Jan 2017 10:52:56 +0530
Message-ID: <587712B0.2030806@ti.com>
References: <1483091774-8332-1-git-send-email-kishon@ti.com>
 <20170111212135.GN14532@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170111212135.GN14532@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Bjorn,

On Thursday 12 January 2017 02:51 AM, Bjorn Helgaas wrote:
> On Fri, Dec 30, 2016 at 03:26:11PM +0530, Kishon Vijay Abraham I wrote:
>> This series contains
>>         *) a patch to cleanup dra7xx probe
>>         *) a patch to force DRA7xx controller to work in GEN1 mode
>>         *) a patch to fix dra7xx driver so that even if CONFIG_PCI_MSI
>>            is enabled, dra7xx driver can service legacy interrupts
>>            (provided the device support only legacy interrupts).
>>
>> Changes from v1:
>> *) rebased to 4.10-rc1 (and [1])
>> *) use existing dt property "max-link-speed" instead of creating a new
>>    TI specific dt property.
>>
>> [1] -> https://lkml.org/lkml/2016/12/28/34
>>
>> Kishon Vijay Abraham I (3):
>>   PCI: dra7xx: simplify the probe code
>>   PCI: dra7xx: Add support to force RC to work in GEN1 mode
>>   PCI: dra7xx: Enable MSI and legacy interrupts simultaneously
>>
>>  drivers/pci/controller/pci-dra7xx.c |   81 ++++++++++++++++++++---------------
>>  1 file changed, 47 insertions(+), 34 deletions(-)
> 
> Applied to pci/host-dra7xx for v4.11.  I haven't applied the directory
> rename yet, so I'll fix that up as necessary.

I'd have liked that to be merged as well. Is that because Arnd hasn't Acked
that one yet?

Thanks
Kishon
