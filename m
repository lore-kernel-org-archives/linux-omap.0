From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] i2c: busses: i2c-omap: Increase timeout for i2c
 interrupt
Date: Fri, 10 Jul 2015 15:26:01 +0200
Message-ID: <559FC7E9.1060003@nokia.com>
References: <1436504994-31137-1-git-send-email-vigneshr@ti.com>
 <559F8670.2060305@nokia.com> <20150710090909.GF1528@katana>
 <559FC5D7.3000108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <559FC5D7.3000108-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi!

On 10/07/15 15:17, ext Vignesh R wrote:
>>> I would propose you to throw away spinlocks. Convert threaded IRQ to
>>> >> just one hardirq handler. And continue debugging. You will reduce the
>>> >> load of the system with the above measures, maybe it will not happen
>>> >> any more, maybe you'll figure out that problem is somewhere else.
>> > 
>> > Or this.
> I am not convinced with moving entire code at hardirq context. I believe
> its better to keep hardirq as small as possible.

How deep is the controller's FIFO? 1 byte? 2 bytes? Other drivers can perfectly fill
next byte in hardirq handler. If you need to do 10 opcodes more in hardirq handler,
it's much better for the whole system than to trigger scheduler and thread and and and
just because of these 10 opcodes.

-- 
Best regards,
Alexander Sverdlin.
