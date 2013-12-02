From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/1] mfd: omap-usb-host: Fix USB device detection problems
 on OMAP4 Panda
Date: Mon, 02 Dec 2013 13:01:51 +0100
Message-ID: <529C76AF.10106@linutronix.de>
References: <1385730118-26402-1-git-send-email-rogerq@ti.com>	<1385730118-26402-2-git-send-email-rogerq@ti.com> <CAOf5uwmEkzFd=e3j8m8=qdTCAMkk_-DPw0fTm=7Vzy0PbE2oDQ@mail.gmail.com> <529C55DF.3000808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <529C55DF.3000808@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Felipe Balbi <balbi@ti.com>, lee.jones@linaro.org, sameo@linux.intel.com, tomi.valkeinen@ti.com, Stefan Roese <sr@denx.de>, ljkenny.mailinglists@gmail.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

- stable@vger.kernel.org since they probably don't care about this
  unless the patch is merged.

On 12/02/2013 10:41 AM, Roger Quadros wrote:
> Michael,
> 
> On 11/29/2013 05:32 PM, Michael Trimarchi wrote:
>> Hi Roger
>>
>> On Fri, Nov 29, 2013 at 2:01 PM, Roger Quadros <rogerq@ti.com> wrote:
>>> With u-boot 2013.10, USB devices are sometimes not detected
>>> on OMAP4 Panda. To make us independent of what bootloader does
>>> with the USB Host module, we must RESET it to get it to a known
>>> good state. This patch Soft RESETs the USB Host module.
>>>
>>
>> Do you think that we need something similar of usb musb?
>> I have seen the OTG_SYSCONFIG is touched in uboot and
>> only readed in omap2430.c.
> 
> I'm not sure about musb. Maybe Sebastian/Felipe have better idea.
> In general I believe that all modules must be reset by the kernel.
> 

based on the code at the bottom it touches the first few register(s)
sysconfig. Isn't hwmod actually doing this idle stuff and resting the
device during boot?

> cheers,
> -roger
>>

Sebastian
