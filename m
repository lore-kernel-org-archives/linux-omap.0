From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if
 booted with latest u-boot
Date: Thu, 13 Dec 2018 15:50:54 +0000
Message-ID: <20181213155054.GK9507@n2100.armlinux.org.uk>
References: <20181213135845.3965-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181213135845.3965-1-peter.ujfalusi@ti.com>
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
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 13, 2018 at 03:58:45PM +0200, Peter Ujfalusi wrote:
> The ethernet works in kernel only if we use some binary u-boot from the
> past which have support for KS8851.
> 
> The u-boot sources are not available for this mysterious u-boot image
> people tends to hold on... Mainline u-bott does not have ethernet support
> for sdp4430 and if we use that the ethernet is not working.
> 
> After some debugging I have managed to get the ethernet working with
> mainline u-boot while not breaking the networking with the case when we
> boot with the mysterious binary u-boot.
> 
> Basically we were missing bunch of pinmux settings and the 'magic'
> gpio_138 handling in kernel.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Hi Peter,

Digging up where my u-boot came from, I found:

  https://plus.google.com/103895730806848715870/posts/cCq2CxDogW9

Unfortunately, gitorious no longer exists, but I do still have a clone
of that tree locally, containing:

9f384308319e OMAP4SDP: Add Micrel KS8851 net chip support
ae631b095a87 NET: Add driver for Micrel KS8851
78e43f2a8987 ARMV7: OMAP: Add spi driver for OMAP3/OMAP4
e576c6a9cbc9 omap4_common: config: remove I2C for SPL mode
19d5934c4b3b ARM: OMAP4: Move TEXT_BASE down to non-HS limit

plus some of my own modifications to fix the problems stated in that
post.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
