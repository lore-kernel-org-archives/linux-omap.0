From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] can: c_can: use regmap_update_bits() to modify RAMINIT
 register
Date: Mon, 12 Jan 2015 11:57:34 +0200
Message-ID: <54B39A8E.4090006@ti.com>
References: <1420641162-8634-1-git-send-email-rogerq@ti.com> <54AFDCB0.5060908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53769 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbbALJ54 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2015 04:57:56 -0500
In-Reply-To: <54AFDCB0.5060908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org, wsa@the-dreams.de, kernel@pengutronix.de, linux-omap@vger.kernel.org

+Mark,

On 09/01/15 15:50, Tomi Valkeinen wrote:
> On 07/01/15 16:32, Roger Quadros wrote:
>> use of regmap_read() and regmap_write() in c_can_hw_raminit_syscon()
>> is not safe as the RAMINIT register can be shared between different drivers
>> at least for TI SoCs.
>>
>> To make the modification atomic we switch to using regmap_update_bits().
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/net/can/c_can/c_can_platform.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
>> index f363972..364209a 100644
>> --- a/drivers/net/can/c_can/c_can_platform.c
>> +++ b/drivers/net/can/c_can/c_can_platform.c
>> @@ -110,6 +110,10 @@ static void c_can_hw_raminit_syscon(const struct c_can_priv *priv, bool enable)
>>  	 */
>>  	ctrl &= ~(1 << raminit->bits.start);
>>  	ctrl |= 1 << raminit->bits.done;
>> +
>> +	/* we can't use regmap_update_bits here as it will bypass the write
>> +	 * if START is already 0 and DONE is already 1.
>> +	 */
>>  	regmap_write(raminit->syscon, raminit->reg, ctrl);
> 
> Can you first use update_bits to change either bit, so that this update
> will be done?
> 

Initial condition is START=0, DONE=1.

Now setting and clearing START bit initiates the start process and will cause the
DONE bit to be set after a while.
So unfortunately this doesn't work for us.

Mark,

The problem here is we can't use regmap_update_bits() because we need to write a 1 to the DONE bit to clear it and _regmap_update_bits() doesn't allow us to do that because of commit
d91e8db2c3bb regmap: Suppress noop writes in regmap_update_bits()

Is reverting it going to cause other issues? If yes then can we have a flag to specify forced update?

cheers,
-roger
[1] - http://lxr.free-electrons.com/source/drivers/base/regmap/regmap.c#L2332


