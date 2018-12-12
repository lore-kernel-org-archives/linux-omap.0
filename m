From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] Fix OMAP4430 SDP Ethernet startup
Date: Wed, 12 Dec 2018 14:04:36 +0000
Message-ID: <20181212140436.GI9507@n2100.armlinux.org.uk>
References: <20181207125224.GW6920@n2100.armlinux.org.uk>
 <8b8e05e6-f8a1-2dfe-0967-27e5303a2a07@ti.com>
 <20181207135751.GZ6920@n2100.armlinux.org.uk>
 <539f3dd5-93b7-e902-247b-93c6461e121f@ti.com>
 <20181212125011.GH9507@n2100.armlinux.org.uk>
 <dfe405c5-ae7a-5511-9cd5-7bed6470b0c8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <dfe405c5-ae7a-5511-9cd5-7bed6470b0c8@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 12, 2018 at 03:44:08PM +0200, Peter Ujfalusi wrote:
> 
> On 12/12/2018 14.50, Russell King - ARM Linux wrote:
> >> Even with the delay I can not get the ethernet working on Blaze. It
> >> supposed to be mostly the same HW as sdp (we load the same omap4-sdp.dtb).
> >>
> >> [    2.576599] ks8851 spi0.0: spi0.0 supply vdd-io not found, using
> >> dummy regulator
> >> [    2.584045] ks8851 spi0.0: Linked as a consumer to regulator.0
> >> [    2.584136] ks8851 spi0.0: Linked as a consumer to regulator.4
> >> [    2.595916] ks8851 spi0.0: message enable is 0
> >> [    2.602661] ks8851 spi0.0: failed to read device ID
> >> [    2.607604] ks8851 spi0.0: Dropping the link to regulator.4
> >> [    2.607604] ks8851 spi0.0: Dropping the link to regulator.0
> >>
> >> I can not recall when was the last time it worked, could be years ago.
> > 
> > It's always been detected at boot without problem for me.  E.g.:
> > 
> > http://www.armlinux.org.uk/developer/build/result.php?type=boot&idx=11716
> 
> Thanks for the log. It looks like you have u-boot with ks8851 support,
> but it is not working with mainline u-boot (eth is not supported afaik).

Yep - I think it's a uboot/spl/mlo that came from TI, rather than
mainline.  Since eth is fundamental to the platform being part of
the automated boot farm, the lack of eth support in mainline
u-boot is a very good reason for me to avoid that.

Manually loading kernels onto SD cards doesn't work for automated
testing (unless you have a robot to remove the SD card from the
platform, plug it into a PC, and then transfer it back!)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
