From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: omap: fix NACK and Arbitration Lost irq handling
Date: Sat, 15 Nov 2014 05:48:03 +0300
Message-ID: <514EB645-7DB4-4E47-B692-1461C918BF52@gmail.com>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com> <20141115014336.GB808@saruman> <2159E044-9130-410D-905B-B941408DCDCD@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2159E044-9130-410D-905B-B941408DCDCD-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



> Assuming this is really correct (I haven't tested), you need to add:

To help understanding logic, I'd like to provide event traces (with the patch applied):

See i2c-omap.c dc418f6e6a8f5021ccf9e9c0957eefae3737168d as a reference.
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-omap.c?id=dc418f6e6a8f5021ccf9e9c0957eefae3737168d

Typical event sequence for Arbitration Lost case looks like:
addr: 0x0058, len: 4, flags: 0x1, stop: 1
omap_i2c_xfer_msg:564 (STAT=0x0140; IE=0x601f; CON=0x8200)
omap_i2c_xfer_msg:565 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
omap_i2c_xfer_msg:566 (STAT=0x0140; IE=0x601f; CON=0x8403)
omap_i2c_isr:886 (STAT=0x1141; IE=0x601f; CON=0x8000)
omap_i2c_isr_thread:906 (STAT=0x1141; IE=0x601f; CON=0x8000)
IRQ (ISR = 0x0001)
Arbitration lost

Typical event sequence for NACK case looks like:
addr: 0x0068, len: 4, flags: 0x1, stop: 1
omap_i2c_xfer_msg:564 (STAT=0x0040; IE=0x601f; CON=0x8000)
omap_i2c_xfer_msg:566 (STAT=0x0040; IE=0x601f; CON=0x8403)
omap_i2c_isr:886 (STAT=0x0146; IE=0x601f; CON=0x8000)
omap_i2c_isr_thread:906 (STAT=0x0146; IE=0x601f; CON=0x8000)
IRQ (ISR = 0x0006)
NACK
IRQ (ISR = 0x0004)
ARDY
omap_i2c_isr_thread:1030 (STAT=0x0140; IE=0x601f; CON=0x8000)

> 
> Fixes: 1d7afc9 i2c: omap: ack IRQ in parts
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.7+
> 
> here and resend, so it gets backported to older kernels.
> 

I'll resend. Thanks.
