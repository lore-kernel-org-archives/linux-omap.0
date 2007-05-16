From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] TWL4030 Keypad driver - incorporated review comments
Date: Wed, 16 May 2007 15:04:51 -0700
Message-ID: <20070516220450.GE15281@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47E26872@dlee13.ent.ti.com>
	<4643C033.3020209@gmail.com>
	<782515bb0705111750k20d59341r7ddda0c68e520b99@mail.gmail.com>
	<20070516161319.GE20297@atomide.com> <464B3D19.4080703@gmail.com>
	<9C23CDD79DA20A479D4615857B2E2C470810AC@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C470810AC@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070516 10:33]:
> 
> >while testing the TWL4030 keypad driver I found that it causes I2C errors,
> >but Nishant's  "FIFO Handling support and broken hw workaround" patch fixes
> >the problem. So, the problem is not in the keypad driver itself
> >but it's in i2c-omap driver. Tony, consider pushing the I2C fix too.
> 
> Yes, it does fix I2C issues as it adds FIFO support to existing I2C driver. Tony please consider this patch.
> 
> Let me know if you have any comments, I can fix them along with TWLKEYPAD patch.

Pushing today.

Tony
