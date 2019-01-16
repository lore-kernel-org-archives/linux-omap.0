From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] wlcore: sdio: Fixup power on/off sequence
Date: Wed, 16 Jan 2019 07:40:29 -0800
Message-ID: <20190116154029.GO5544@atomide.com>
References: <20190115150433.12558-1-ulf.hansson@linaro.org>
 <20190115185509.GJ5544@atomide.com>
 <CAPDyKFpBY-urtSGpZtxmS79wgitgA46oFmeNk4w7tOjYW2PDLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpBY-urtSGpZtxmS79wgitgA46oFmeNk4w7tOjYW2PDLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>, linux-wireless@vger.kernel.org, Ricardo Salveti <rsalveti@rsalveti.net>, Kishon Vijay Abraham I <kishon@ti.com>, Anders Roxell <anders.roxell@linaro.org>, John Stultz <john.stultz@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [190116 11:44]:
> On Tue, 15 Jan 2019 at 19:55, Tony Lindgren <tony@atomide.com> wrote:
> > # while [ 1 ]; do ifconfig wlan0 down; usleep 20000; \
> >   ifconfig wlan0 up; done
> >
> > Otherwise I get the following on warning pandaboard-es:
> >
> > WARNING: CPU: 0 PID: 1770 at drivers/bus/omap_l3_noc.c:147
> > l3_interrupt_handler+0x2f8/0x388
> > 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Read):
> > Data Access in User mode during Functional access
> >
> > Meaning that we access registers while not clocked
> > somewhere. I think that warning is different from the
> > earlier errors though :) And we could add a msleep(50)
> > to the end to mostly avoid it until we have a better
> > fix available?
> 
> Well, that would paper over the problem, let's see if we can avoid it.
> 
> I realized that I have not invoked mmc_hw_reset() with the sdio host
> claimed. This could be the reason and is fixed in a v2, please try and
> see if that solves the "new" problem. If id doesn't, you could also
> convert the pm_runtime_put() to a pm_runtime_put_sync() in
> wl12xx_sdio_power_off() and see if that makes a difference.

Yes you're right v2 works for me no problem. I'll go ack
it there.

Tony
