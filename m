From: David Brownell <david-b@pacbell.net>
Subject: Re: 1710 and USB host
Date: Tue, 2 May 2006 22:11:04 -0700
Message-ID: <200605022211.05662.david-b@pacbell.net>
References: <44564B38.9020802@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <44564B38.9020802@mvista.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 01 May 2006 10:54 am, Kevin Hilman wrote:
> Anyone else having success using the 1710 in USB host mode? 

Last time I tried it was on a platform where the transceiver wasn't
wired up usably, so it was kind of pointless.  I expect that's not
what you're finding ...


> Using the latest  
> git kernel, I'm getting the boot messages below.  I have a USB key plugged in 
> and it's lighting up, so presumably it's getting powered properly.
> 
> Maybe the jumpers aren't set quite right, I don't quite grok the comments 
> around the 'hmc_mode' value in. board-h3.c.  In any case, my SW1501 settings 
> are 1=on, and the rest are off.

I have no H3, so I can't say whether any of this is sane or not.
As I recall, there are two transceivers on that board:  OTG, and non-OTG.
Ideally both should work.  I seem to recall positive reports about using
the OTG transciever.

> Thanks for any pointers,
> 
> Kevin
> 
> isp1301_omap 0-002d: chiprev 2.00, driver 24 August 2004
> MUX: initialized N21_1710_GPIO14
> usbmon: debugfs is not available
> isp1301_omap 0-002d: A-Host sessions ok
> ohci ohci: OMAP OHCI
> ohci ohci: new USB bus registered, assigned bus number 1
> ohci ohci: irq 38, io mem 0xfffba000
> ohci ohci: init err (00000000 0000)

That "init err" means the controlle wasn't responding to basic stuff.
Like maybe it wasn't clocked correctly ... you could turn on USB_DEBUG
in Kconfig and see if the register dump looks even vaguely sane (like,
it should report three ports etc).

- Dave


> ohci ohci: can't start
> ohci ohci: startup error -75
> ohci ohci: USB bus 1 deregistered
> ohci: probe of ohci failed with error -75
> 
