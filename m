From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: ti-qspi: improve ->remove() callback
Date: Mon, 2 Nov 2015 17:43:14 +0200
Message-ID: <56378492.702@ti.com>
References: <1446127050-5957-1-git-send-email-balbi@ti.com>
 <563778B8.9060109@ti.com> <87bnbcctsk.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87bnbcctsk.fsf-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/02/2015 05:20 PM, Felipe Balbi wrote:
> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
> 
>> On 10/29/2015 03:57 PM, Felipe Balbi wrote:
>>> there's no need to call pm_runtime_get_sync()
>>> followed by pm_runtime_put(). We should, instead,
>>> just call pm_runtime_put_sync() and pm_runtime_disable().
>>
>> Sry, but why do we need to call pm_runtime_put[_sync]() here?
>>
>> My be just pm_runtime_disable() will be ok?
> 
> and disable with unbalanced pm_runtime_get() ?
> 

Which one is unbalanced pm_runtime_get()?
There are no  pm_runtime_get() in probe, so there you are
going to introduce unbalanced pm_runtime_put_sync() actually :(

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
