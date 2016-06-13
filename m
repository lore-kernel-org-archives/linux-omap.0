From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v7 2/4] usb: dwc3: add dual-role support
Date: Mon, 13 Jun 2016 10:09:21 +0300
Message-ID: <575E5C21.8040103@ti.com>
References: <1465564650-27516-1-git-send-email-rogerq@ti.com>
 <1465564650-27516-3-git-send-email-rogerq@ti.com>
 <20160612091137.GE22054@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160612091137.GE22054@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: balbi@kernel.org, tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Peter,

On 12/06/16 12:11, Peter Chen wrote:
> On Fri, Jun 10, 2016 at 04:17:28PM +0300, Roger Quadros wrote:
>> Register with the USB OTG/DRD core. Since we don't support
>> OTG yet we just work as a dual-role device even
>> if device tree says "otg".
>>
>> Get ID and VBUS information from the OTG controller
>> and kick the OTG state machine.
>>
> 
> Hi Roger,
> 
> I can't apply it after rebase usb-next rc1 and felipe's testing/next.
> How to apply it?

You just need to apply the series on Felipe's testing/next + this one patch
http://article.gmane.org/gmane.linux.kernel/2240761
