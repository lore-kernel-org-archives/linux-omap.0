From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
Date: Fri, 26 Oct 2012 23:01:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210262251020.11258@utopia.booyaka.com>
References: <1351155648-20429-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351155648-20429-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe

just two quick comments

On Thu, 25 Oct 2012, Felipe Balbi wrote:

> if we allow compiler reorder our writes, we could
> fall into a situation where dev->buf_len is reset
> for no apparent reason.
> 
> This bug was found with a simple script which would
> transfer data to an i2c client from 1 to 1024 bytes
> (a simple for loop), when we got to transfer sizes
> bigger than the fifo size, dev->buf_len was reset
> to zero before we had an oportunity to handle XDR
> Interrupt. Because dev->buf_len was zero, we entered
> omap_i2c_transmit_data() to transfer zero bytes,
> which would mean we would just silently exit
> omap_i2c_transmit_data() without actually writing
> anything to DATA register. That would cause XDR
> IRQ to trigger forever and we would never transfer
> the remaining bytes.
> 
> After adding the memory barrier, we also drop resetting
> dev->buf_len to zero in omap_i2c_xfer_msg() because
> both omap_i2c_transmit_data() and omap_i2c_receive_data()
> will act until dev->buf_len reaches zero, rendering the
> other write in omap_i2c_xfer_msg() redundant.
> 
> This patch has been tested with pandaboard for a few
> iterations of the script mentioned above.
> 
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
> 
> This bug has been there forever, but it's quite annoying.
> I think it deserves being pushed upstream during this -rc
> cycle, but if Wolfram decides to wait until v3.8, I don't
> mind.
> 
>  drivers/i2c/busses/i2c-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..1ec4e6e 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -521,6 +521,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
>  	dev->buf = msg->buf;
>  	dev->buf_len = msg->len;
> +	wmb();
>  
>  	omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);
>  

Would suggest moving the wmb() immediately before the point at which the 
interrupt can occur.  Looks to me that's when the OMAP_I2C_CON_REG write 
occurs.

Also would suggest adding a comment to clarify what the wmb() is intended 
to do.  Maybe something like 'Prevent the compiler from moving earlier 
changes to dev->buf and dev->buf_len after the write to CON_REG.  This 
write enables interrupts and those variables are used in the interrupt 
handler'.

checkpatch is supposed to flag uncommented barriers, but maybe that's only 
with --strict.

# check for memory barriers without a comment.
		if ($line =~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/) {
			if (!ctx_has_comment($first_line, $linenr)) {
				CHK("MEMORY_BARRIER",
				    "memory barrier without comment\n" . 
$herecurr);
			}
		}


- Paul
