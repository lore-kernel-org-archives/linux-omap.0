From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2 06/19] bus: omap_l3_noc: un-obfuscate l3_targ address
 computation
Date: Mon, 21 Apr 2014 08:08:43 -0500
Message-ID: <5355185B.70003@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com> <1397767775-10965-1-git-send-email-nm@ti.com> <1397767775-10965-7-git-send-email-nm@ti.com> <20140417220036.GE8504@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140417220036.GE8504-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/17/2014 05:00 PM, Felipe Balbi wrote:
> On Thu, Apr 17, 2014 at 03:49:22PM -0500, Nishanth Menon wrote:
>> just simplify derefencing that is equivalent.
>>
>> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>> ---
>> V2: just ordering change
>> V1: https://patchwork.kernel.org/patch/3984201/
>>  drivers/bus/omap_l3_noc.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
>> index c8facb0..f7d3bf4 100644
>> --- a/drivers/bus/omap_l3_noc.c
>> +++ b/drivers/bus/omap_l3_noc.c
>> @@ -76,7 +76,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
>>  			err_src = __ffs(err_reg);
>>  
>>  			/* Read the stderrlog_main_source from clk domain */
>> -			l3_targ_base = base + *(l3_targ[i] + err_src);
>> +			l3_targ_base = base + l3_targ[i][err_src];
> 
> hmmm, wasn't it so that pointer arithmetic was slightly faster than
> array indexing ? In that case would it be best to:
> 
> l3_targ_base = base + *(l3_targ + i + err_src);
> 
Yes, if this was a hot path (example: interrupt handler that gets
invoked very often), I would probably have preferred optimization at
this point.

However, the patch is just a step away from patches that converts the
target information into a structure under flagmux structure allowing
us to get rid of multiple array operations.

This patch just makes the further changes a bit readable.

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
