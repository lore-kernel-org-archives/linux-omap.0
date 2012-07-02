From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH v2 05/17] i2c: omap: split out [XR]DR and [XR]RDY
Date: Mon, 02 Jul 2012 17:21:08 +0530
Message-ID: <4FF18B2C.8080102@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com> <1339691067-919-6-git-send-email-balbi@ti.com> <4FE991DA.5070301@ti.com> <20120702113314.GA2730@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120702113314.GA2730@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: ben-linux@fluff.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, w.sang@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On Monday 02 July 2012 05:03 PM, Felipe Balbi wrote:
>>> +				num_bytes = dev->fifo_size;
>> > In case of a draining interrupt. The byte count may not be the fifo size.
>> > Do you agree?
> hmm... indeed, that should be dev->buf_len... can you fix that up or
> want me to resend ?
Nope I can fix that up.
Thanks,
