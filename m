From: Vignesh R <vigneshr@ti.com>
Subject: Re: [RFC PATCH] i2c: busses: i2c-omap: Increase timeout for i2c interrupt
Date: Fri, 10 Jul 2015 19:14:23 +0530
Message-ID: <559FCC37.10201@ti.com>
References: <1436504994-31137-1-git-send-email-vigneshr@ti.com> <559F8670.2060305@nokia.com> <20150710090909.GF1528@katana> <559FC5D7.3000108@ti.com> <559FC7E9.1060003@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <559FC7E9.1060003@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>, Wolfram Sang <wsa@the-dreams.de>, Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 07/10/2015 06:56 PM, Alexander Sverdlin wrote:
> Hi!
> 
> On 10/07/15 15:17, ext Vignesh R wrote:
>>>> I would propose you to throw away spinlocks. Convert threaded IRQ to
>>>>>> just one hardirq handler. And continue debugging. You will reduce the
>>>>>> load of the system with the above measures, maybe it will not happen
>>>>>> any more, maybe you'll figure out that problem is somewhere else.
>>>>
>>>> Or this.
>> I am not convinced with moving entire code at hardirq context. I believe
>> its better to keep hardirq as small as possible.
> 
> How deep is the controller's FIFO? 1 byte? 2 bytes? 

As per AM57x TRM[1] section 24.1.4.8 max FIFO depth can be 64bytes.

[1] http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf
-- 
Regards
Vignesh
