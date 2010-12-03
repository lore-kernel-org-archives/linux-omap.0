From: <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] i2c-omap: Set latency requirements only once for
	several messages
Date: Fri, 3 Dec 2010 06:43:37 +0000
Message-ID: <90C2C3D80A94B8448891D39FF568E87605D718DD@008-AM1MPN1-012.mgdnok.nokia.com>
References: <1290074660-2640-1-git-send-email-samu.p.onkalo@nokia.com>
 <20101203023751.GF20097@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101203023751.GF20097-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


>-----Original Message-----
>From: ext Ben Dooks [mailto:ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org]
>Sent: 03 December, 2010 04:38
>To: Onkalo Samu.P (Nokia-MS/Tampere)
>Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org; paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: Re: [PATCH] i2c-omap: Set latency requirements only once for
>several messages
>
>On Thu, Nov 18, 2010 at 12:04:20PM +0200, Samu Onkalo wrote:
>> Ordinary I2C read consist of two messages. First a write operation
>> to tell register address and then read operation to get data.
>> CPU wake up latency is set and removed twice in read case.
>> Set latency requirement before the message processing loop
>> and remove the requirement after the loop to remove latency
>> adjustment operations between the messages.
>>
>> Signed-off-by: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>> Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>> Acked-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>
>I'll queue this for -rc unless it is going in via the omap list
>or it should wait for merge window?
>
Hi Ben,

I first sent this to omap-list and I got instructions to send this to you.
So I assume that you should queue this. Kevin, Paul, is -rc ok for you?

-Samu
