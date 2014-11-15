From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: omap: fix "Too much work in one IRQ" irq handling
Date: Sat, 15 Nov 2014 05:37:41 +0300
Message-ID: <7C4EE58D-8956-40C2-B649-775B2F551D2A@gmail.com>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com> <1416014452-6712-2-git-send-email-al.kochet@gmail.com> <20141115014859.GC808@saruman>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141115014859.GC808@saruman>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

Initially you made the change (66b9298878742f08cb6e79b7c7d5632d782fd1e1):
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/i2c/busses/i2c-omap.c?id=66b9298878742f08cb6e79b7c7d5632d782fd1e1

 		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);

 		if (count++ == 100) {
 			dev_warn(dev->dev, "Too much work in one IRQ\n");
-			break;
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
 		}


Than that change transformed into (4a7ec4eda58269a507501f240955d99312fdfd5f):
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/i2c/busses/i2c-omap.c?id=4a7ec4eda58269a507501f240955d99312fdfd5f

@@ -853,24 +853,21 @@ omap_i2c_isr(int this_irq, void *dev_id)
 		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
 		if (count++ == 100) {
 			dev_warn(dev->dev, "Too much work in one IRQ\n");
-			omap_i2c_complete_cmd(dev, err);
-			return IRQ_HANDLED;
+			goto out;
 		}


+out:
+	omap_i2c_complete_cmd(dev, err);
 	return IRQ_HANDLED;
 }

As a result we have in master:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-omap.c

	do {
		bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
		stat &= bits;
		...

		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
		if (count++ == 100) {
			dev_warn(dev->dev, "Too much work in one IRQ\n");
			break;
		}
                ...

	} while (stat);

	omap_i2c_complete_cmd(dev, err);

out:
	spin_unlock_irqrestore(&dev->lock, flags);

While original code was:

{
	bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
	while ((stat = (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG))) & bits) {
		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
		if (count++ == 100) {
			dev_warn(dev->dev, "Too much work in one IRQ\n");
			break;
		}

		err = 0;
complete:
                ...

		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
					OMAP_I2C_STAT_AL)) {
			...
			omap_i2c_complete_cmd(dev, err);
			return IRQ_HANDLED;
		}
		...
	}
	return count ? IRQ_HANDLED : IRQ_NONE;
}


> how ? This is an interesting bug which deserves further explanation.

Look at the loops above, and at the omap_i2c_complete_cmd:

static inline void
omap_i2c_complete_cmd(struct omap_i2c_dev *dev, u16 err)
{
	dev->cmd_err |= err;
	complete(&dev->cmd_complete);
}

You can see, loop will be aborted if counter reached 100. Final state of transfer depends on
values stored in the 'err' and 'dev->cmd_err'. If 'err' and 'dev->cmd_err' are zero, than transfer
would be aborted with status 0.

> quite frankly, this looks *very* wrong. It creates the possibility for
> us never completing a command which would cause several timeouts.

Pre 66b9298878742f08cb6e79b7c7d5632d782fd1e1 omap-i2c.c version didn't cause deadlocks.

> 
> How have you tested this and how have you figured this was the actual
> bug ? Based on commit log not matching the patch body (which 'original
> logic' are you talking about ?), I have to NAK this patch.

Well, I tried to debug I2C ISR hang issue (thats another question I want to discuss later)
using output to console. I places few dev_warn (not dev_dbg) messages into ISR 
(like got NACK, got ARDY and so on) and got "Too much work  in one IRQ" with incorrect booting.
