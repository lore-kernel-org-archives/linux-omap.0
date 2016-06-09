From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 03/14] usb: hcd.h: Add OTG to HCD interface
Date: Thu, 9 Jun 2016 13:16:44 +0300
Message-ID: <5201761f-4efa-f941-b05f-e4a2b91c75c0@cogentembedded.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-4-git-send-email-rogerq@ti.com>
 <5bc321c0-fb36-7a4a-d054-ee73b12822d4@cogentembedded.com>
 <575809E9.7010409@ti.com>
 <f5f068ae-c46a-5bad-45e1-f0f9cb5f8592@cogentembedded.com>
 <57591B5E.3050602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57591B5E.3050602@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, peter.chen@freescale.com
Cc: balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 6/9/2016 10:31 AM, Roger Quadros wrote:

>>>>> The OTG core will use struct otg_hcd_ops to interface
>>>>> with the HCD controller.
>>>>
>>>>    Host controller driver (HCD) controller? Maybe just HC? :-)
>>>
>>> OK.
>>
>>    OTOH, my googling has shown that HCD may stand for both HC driver and HC device... The host controller device sounds a bit tautological however...
>
> Yeah I always meant it to be Host Controller Device :).

    The question here is more what was meant by the previous Linux USB 
authors. :-)

> --
> cheers,
> -roger

MBR, Sergei
