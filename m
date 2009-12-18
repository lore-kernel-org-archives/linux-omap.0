From: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] omap i2c: add a timeout to the busy waiting
Date: Fri, 18 Dec 2009 15:33:19 +0200
Message-ID: <4B2B849F.3050802@nokia.com>
References: <1260972144-31593-1-git-send-email-virtuoso@slind.org> <1260972144-31593-2-git-send-email-virtuoso@slind.org> <1260972144-31593-3-git-send-email-virtuoso@slind.org> <4B29A0B7.1020908@ti.com> <20091217133113.GC29059@shisha.kicks-ass.net> <4B2A3926.9090800@ti.com> <CD8CC2B65FEE304DA95744A5472698F202A9A04FC6@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F202A9A04FC6-UmuGNrFEPrGIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>
Cc: "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Sonasath, Moiz wrote:
>> From: Menon, Nishanth
>> Alexander Shishkin said the following on 12/17/2009 07:01 PM:
>>> Well, I could calculate the timeout value based on current operating
>> speed,
>>> I guess. Or a delay. Perhaps OMAP_I2C_TIMEOUT can be used here?
>>>
>> it might be an overkill trying to generate counter based on opp speeds.
>> wondering if this delay is required in the first place..
> 
> The reason why this timeout was not put in place was that if the I2C
> controller is functional, the XUDF has to set after XRDY/XDR are set,
> the only case where it might not be set is when there is a sudden
> NACK | AL condition produced on the bus and the transfer stops
> (thereby the FIFO is not getting empty). The code takes care of this
> error situation so IMHO we can do without a timeout here.

We are able to reproduce an error situation, where none of XUDF|NACK|AL
gets set. In that case the kernel hangs. If we add the timeout, we are
able to recover. If you want to have a robust driver, you cannot have a
loop which is not guaranteed to terminate.

A.
