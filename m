From: Daniel Mack <zonque@gmail.com>
Subject: Re: v3.11-rc1 USB regressions
Date: Wed, 24 Jul 2013 21:04:28 +0200
Message-ID: <51F0253C.7090205@gmail.com>
References: <20130715225647.GE3296@blackmetal.musicnaut.iki.fi> <51E4E922.2040707@gmail.com> <20130716175710.GA14385@blackmetal.musicnaut.iki.fi> <20130724185119.GB26943@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130724185119.GB26943@blackmetal.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Aaro,

On 24.07.2013 20:51, Aaro Koskinen wrote:
> On Tue, Jul 16, 2013 at 08:57:10PM +0300, Aaro Koskinen wrote:

>> Here are full details:
>>
>> Kernel v3.11-rc1 and the following USB fixes:
>> 	ARM: omap2: fix musb usage for n8x0
>> 	musb: omap: Fix: pass all the resources to musb core
> 
> [...]
> 
>> When I revert fe4cb0912f8e737f8e4b8b38b9e692f8062f5423 and
>> 8b125df5b24cfb0ec7fa1971e343cc0badc1827d, it works like before (3.10):
> 
> I'm now running -rc2 with above fixes and reverts (the only way to get
> USB working). I'm seeing an additional issue, the following crash happens
> always on N900 when doing "poweroff":

Yes, with the mentioned patches reverted, musb_to_hcd() will return a
faulty pointer. You can't easily revert them unfortunately.

Your platform needs a real fix, I just have trouble understanding why a
removed usb_add_hcd() would make the gadget code fail.

Sorry for the trouble, but I don't currently have a board with musb in
gadget mode to reproduce this issue.


Thanks,
Daniel
