From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 0/4] pci-dra7xx: Enable errata i870 workaround for RC
 mode
Date: Mon, 17 Sep 2018 23:42:19 +0530
Message-ID: <d4c7751b-6950-d16b-9435-61935a6f511d@ti.com>
References: <20180724173150.2701-1-vigneshr@ti.com>
 <20180808165700.GB486@e107981-ln.cambridge.arm.com>
 <ba428a15-77bf-e09c-3bd7-b5a0eae7ee13@ti.com>
 <20180907170009.GJ5662@atomide.com>
 <20180917094736.GA7072@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917094736.GA7072@e107981-ln.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tony Lindgren <tony@atomide.com>
Cc: KISHON VIJAY ABRAHAM <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Lorenzo,

On 17-Sep-18 3:17 PM, Lorenzo Pieralisi wrote:
> On Fri, Sep 07, 2018 at 10:00:09AM -0700, Tony Lindgren wrote:
>> * Vignesh R <vigneshr@ti.com> [180810 10:10]:
>>>
[...]
>>>>> Tony,
>>>>>
>>>>> If you are okay with the series, could you pick this via omap tree?
>>>>> All ACKs are in place and Lorenzo is okay with PCIe bits to go along with
>>>>> rest of DTS changes.
>>>>
>>>> I think we have missed the v4.19 merge window by now - 
>>>
>>> Right. I didn't get any response from Tony.
>>
>> Sorry catching up with pending mails.. I try hard to not touch
>> anything except fixes around -rc6 time.
>>
>>>> please let me know if I can drop this series from the PCI patch queue.
>>>>
>>>
>>> Ok, I will resend the patch after 4.19-rc. Thanks!
>>
>> FYI, I'm untagging this thread too. Please post the dts
>> changes separately once the dependencies (if any) have
>> cleared.
> 
> Ok, Vignesh: I shall drop this series from the PCI patches queue,
> waiting for your new version, let me know how you want to handle this
> then please.
> 

Thanks for the response!
I have sent v4 dropping DT changes (will send after driver patches have
made it upstream). If possible, consider the patches for next rc as they
are fixes.

Regards
Vignesh
