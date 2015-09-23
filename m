From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] clk: ti: fix dual-registration of uart4_ick
Date: Wed, 23 Sep 2015 08:15:38 -0700
Message-ID: <20150923151538.GA20172@kroah.com>
References: <1443019714-12926-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443019714-12926-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: stable-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@lists.codethink.co.uk, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 23, 2015 at 03:48:34PM +0100, Ben Dooks wrote:
> On the OMAP AM3517 platform the uart4_ick gets registered
> twice, causing any power managment to /dev/ttyO3 to fail
> when trying to wake the device up.
> 
> This solves the following oops:
> 
> [] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa09e008
> [] PC is at serial_omap_pm+0x48/0x15c
> [] LR is at _raw_spin_unlock_irqrestore+0x30/0x5c
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/clk/ti/clk-3xxx.c | 1 -
>  1 file changed, 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
