From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFT/PATCH] serial: omap: prevent resume if device is not
 suspended.
Date: Tue, 18 Sep 2012 22:57:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209182255500.4747@utopia.booyaka.com>
References: <1347972050-3509-1-git-send-email-sourav.poddar@ti.com> <20120918140213.GA27463@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120918140213.GA27463@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, khilman@ti.com
Cc: Sourav Poddar <sourav.poddar@ti.com>, gregkh@linuxfoundation.org, alan@linux.intel.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, 18 Sep 2012, Felipe Balbi wrote:

> On Tue, Sep 18, 2012 at 06:10:50PM +0530, Sourav Poddar wrote:
> > Greg's tty-next is not booting on 2420 based N800. The failure is
> > observed at serial init itself. The reason might be that n800 tries to
> > resume even though it is not suspended before.
> > 
> > Reported-by: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> 
> FWIW:
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> 
> Paul does this fix the issue for you ? Note that it depends on a
> previous patch Sourav sent [1]
> 
> [1] http://marc.info/?l=linux-omap&m=134796819607889&w=2

Yes, thanks - that fixes it,

Tested-by: Paul Walmsley <paul@pwsan.com>

> There's one thing that gets my attention, though, why only n800 would
> fail here ?
> 
> I wonder if we should be using:
> 
> pm_runtime_set_active(dev);
> pm_runtime_get_enable(dev);
> 
> to prevent our runtime_resume() to be called from probe, but Sourav
> tested and it doesn't work on BeagleBoard, but it works on PandaBoard.
> 
> Does it ring any bell ??

Nothing off the top of my head but haven't looked into it -- maybe this 
rings a bell with Kevin?


- Paul
