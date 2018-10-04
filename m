From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Fix impossible .irq < 0
Date: Thu, 4 Oct 2018 07:30:22 -0700
Message-ID: <20181004143021.GC5662@atomide.com>
References: <20181001102453.GA18947@mwanda>
 <20181002094529.30564-1-jmkrzyszt@gmail.com>
 <20181002174745.GG3461@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181002174745.GG3461@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-arm-kernel@lists.infradead.org, Dan Carpenter <dan.carpenter@oracle.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181002 17:52]:
> Hi,
> 
> On Tue, Oct 02, 2018 at 11:45:29AM +0200, Janusz Krzysztofik wrote:
> > Since the very beginning, unsigned int .irq member of struct
> > plat_serial8250_port introduced by commit eff443df679e ("OMAP1:
> > AMS_DELTA: add modem support") was statically initialized to a negative
> > value -EINVAL.  Moreover, commit 0812db943748 ("ARM: OMAP1: ams-delta:
> > assign MODEM IRQ from GPIO descriptor") has introduced some new code
> > which checks for that member carrying a negative value which is
> > impossible.
> > 
> > Use IRQ_NOTCONNECTED instead of -EINVAL. Also, drop the valueless check
> > and let the modem device be registered regardless of .irq value, and
> > the value handled by "serial8250" driver.
> > 
> > Fixes: 0812db943748 ("ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applying into omap-for-v4.20/omap1 thanks.

Regards,

Tony
