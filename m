From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 00/11] USB: OTG/DRD Core functionality
Date: Wed, 15 Jul 2015 16:07:18 +0300
Message-ID: <55A65B06.1010907@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com> <20150710075854.GA14729@shlinux2> <55A391C5.4010701@ti.com> <20150713130446.GA20931@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150713130446.GA20931@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Jun <b47624@freescale.com>
Cc: Joao.Pinto@synopsys.com, stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 13/07/15 16:04, Li Jun wrote:
> On Mon, Jul 13, 2015 at 01:24:05PM +0300, Roger Quadros wrote:
>> Hi,
>>
>> On 10/07/15 10:58, Li Jun wrote:
>>> On Wed, Jul 08, 2015 at 01:19:26PM +0300, Roger Quadros wrote:
>>>> Hi,
>>>>
>>>> This series centralizes OTG/Dual-role functionality in the kernel.
>>>> As of now I've got Dual-role functionality working pretty reliably on
>>>> dra7-evm and am437x-gp-evm. xhci side of things for OTG/DRD use are already
>>>> in v4.2
>>>
>>> Do you have any plan to implement OTG(HNP) on some of your platforms based on
>>> this OTG core?
>>
>> Not yet but Joao Pinto was interested to implement full OTG for dwc3
>> controllers.
>>
>> Would you be interested to try out one of your platforms so that we can
>> address any issues early?
>>
>> cheers,
>> -roger
>>
> 
> Yes, I am considering to try out OTG on chipidea driver for FSL i.mx6x platform
> , which will based on your OTG core and my previous gadget update patchset.

Great :)
> 
> I will comment your patchset if find any issues. Since there is still much work
> to do to complete OTG HNP/SRP, so I assume this will not be done in a short time.

Yes. My plan was to first get DRD working reliably and then add missing HNP/SRP stuff.
The first user of HNP/SRP will know what issues are and what needs to be added.

cheers,
-roger
