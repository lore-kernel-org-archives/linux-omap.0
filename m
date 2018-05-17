From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix packet leaking in dual_mac
 mode
Date: Thu, 17 May 2018 21:10:37 +0200
Message-ID: <20180517191037.GE504@kroah.com>
References: <20180501174122.11323-1-grygorii.strashko@ti.com>
 <20180502.110841.378324128079268584.davem@davemloft.net>
 <CA+G9fYv5yXD4_hyUSxWra+gxux1NFv+sD2HgB7LyJ4E78bgh+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+G9fYv5yXD4_hyUSxWra+gxux1NFv+sD2HgB7LyJ4E78bgh+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: David Miller <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org, nsekhar@ti.com, open list <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 17, 2018 at 11:18:16PM +0530, Naresh Kamboju wrote:
> On 2 May 2018 at 20:38, David Miller <davem@davemloft.net> wrote:
> > From: Grygorii Strashko <grygorii.strashko@ti.com>
> > Date: Tue, 1 May 2018 12:41:22 -0500
> <trim>
> >> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >
> > Applied and queued up for -stable, thank you.
> 
> 4.4 stable-rc build failed for arm32.
> MACHINE=am57xx-evm
> 
> Build error log:
> --------------------
> drivers/net/ethernet/ti/cpsw.c:
>  In function 'cpsw_add_dual_emac_def_ale_entries':
> drivers/net/ethernet/ti/cpsw.c:1112:23:
>  error: 'cpsw' undeclared (first use in this function)
>    cpsw_ale_control_set(cpsw->ale, slave_port,
>                         ^~~~
> drivers/net/ethernet/ti/cpsw.c:1112:23: note:
>  each undeclared identifier is reported only once for each function it appears
>  in
> scripts/Makefile.build:269: recipe for target 'drivers/net/ethernet/ti/cpsw.o'
>  failed
>  make[6]: *** [drivers/net/ethernet/ti/cpsw.o] Error 1
> scripts/Makefile.build:476: recipe for target 'drivers/net/ethernet/ti' failed
>  make[5]: *** [drivers/net/ethernet/ti] Error 2
> 

Now dropped, it's nice to see I got 3 reports about this :)

greg k-h
