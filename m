From: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Subject: Re: [PATCH] Revert "ARM: OMAP: convert I2C driver to PM QoS for MPU
 latency constraints"
Date: Wed, 14 Nov 2012 12:00:39 +0100
Message-ID: <CAORVsuUAmnX1ZBrO+a0HqUVAFtsRfwCx1Vro7ERYBnJgPo095g@mail.gmail.com>
References: <alpine.DEB.2.00.1211061619461.20573@utopia.booyaka.com>
	<20121114105102.GD5954@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121114105102.GD5954-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Wolfram,

On Wed, Nov 14, 2012 at 11:51 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Tue, Nov 06, 2012 at 04:31:32PM +0000, Paul Walmsley wrote:
>>
>> This reverts commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc.
>
> Here giving the patch name in parens would have really made sense.
> Will fix that.
The title is "ARM: OMAP: convert I2C driver to PM QoS for MPU latency
constraints".

>
>> This commit causes I2C timeouts to appear on several OMAP3430/3530-based
>> boards:
>>
>>   http://marc.info/?l=linux-arm-kernel&m=135071372426971&w=2
>>   http://marc.info/?l=linux-arm-kernel&m=135067558415214&w=2
>>   http://marc.info/?l=linux-arm-kernel&m=135216013608196&w=2
There is no formal piecof evidence that the commit is the cause of it.

>>
>> and appears to have been sent for merging before one of its prerequisites
>> was merged:
However this is correct. My fault ;-|

>>
>>   http://marc.info/?l=linux-arm-kernel&m=135219411617621&w=2
>
> Hmm, any ideas how to avoid such things in the future?
The only way is to figure out the dependencies with other features. In
this case I overlooked them and assumed some other features were
already merged in. Will take care next time.

>
>> Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>
> Applied to for-current, thanks!

Thanks!
Jean

>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
