From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/8] I2C patches for v3.8 merge window
Date: Mon, 22 Oct 2012 19:36:31 +0530
Message-ID: <CAM=Q2ctS3hxngk5efcvScAdv-2GtH2pHRZoxRhRTiOWmQA-AXw@mail.gmail.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
	<20121022133023.GC14033@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121022133023.GC14033-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 22, 2012 at 7:00 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Mon, Oct 22, 2012 at 12:46:50PM +0300, Felipe Balbi wrote:
>> Hi guys,
>>
>> here's another series for OMAP I2C driver. There are a few cleanups
>> and one very nice new feature: we can now report how many bytes
>> we transferred until NACK.
>>
>> Note that the implemementation for OMAP-I2C turned out to be a
>> little more complex then I expected, mainly because of the way
>> I2C_CNT register behaves and because of the very buggy register
>> usage on that driver.
>>
>> I have boot tested all patches on beagle xM (3630) and pandaboard
>> rev A3 (4430), will send boot-logs if anyone wants to see.

tested the below branch on omap4430sdp , panda , omap3430sdp.

Doing simple i2ctools
.

Tested-by : Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

>>
>> All patches are available at [1] if anyone wants an easy way to
>> test the patches.
>>
>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git i2c-transferred-bytes-on-NACK
>
> forgot to mention, with [1] I could veridy suspend to ram with boards
> mentioned above.
>
> [1] http://marc.info/?l=linux-arm-kernel&m=135090724817604&w=2
>
>> Felipe Balbi (7):
>>   i2c: omap: no need to access platform_device
>>   i2c: omap: reorder exit path of omap_i2c_xfer_msg()
>>   i2c: omap: fix error checking
>>   i2c: omap: also complete() when stat becomes zero
>>   i2c: omap: introduce and use OMAP_I2C_IP_VERSION_3
>>   i2c: omap: wait for transfer completion before sending STP bit
>>   i2c: omap: implement handling for 'transferred' bytes
>>
>> Shubhrajyoti D (1):
>>   i2c: add 'transferred' field to struct i2c_msg
>>
>>  arch/arm/mach-omap2/i2c.c                  |   3 +-
>>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   2 +-
>>  drivers/i2c/busses/i2c-omap.c              | 156 ++++++++++++++++-------------
>>  include/linux/i2c-omap.h                   |   1 +
>>  include/uapi/linux/i2c.h                   |   1 +
>>  5 files changed, 89 insertions(+), 74 deletions(-)
>>
>> --
>> 1.8.0.rc0
>>
>
> --
> balbi
