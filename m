From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] Fix OMAP4430 SDP Ethernet startup
Date: Fri, 7 Dec 2018 13:57:51 +0000
Message-ID: <20181207135751.GZ6920@n2100.armlinux.org.uk>
References: <20181207125224.GW6920@n2100.armlinux.org.uk>
 <8b8e05e6-f8a1-2dfe-0967-27e5303a2a07@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <8b8e05e6-f8a1-2dfe-0967-27e5303a2a07@ti.com>
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

On Fri, Dec 07, 2018 at 03:40:13PM +0200, Peter Ujfalusi wrote:
> Russell,
> 
> On 07/12/2018 14.52, Russell King - ARM Linux wrote:
> > It was noticed that unbinding and rebinding the KSZ8851 ethernet
> > resulted in the driver reporting "failed to read device ID" at probe.
> > Probing the reset line with a 'scope while repeatedly attempting to
> > bind the driver in a shell loop revealed that the KSZ8851 RSTN pin is
> > constantly held at zero, meaning the device is held in reset, and
> > does not respond on the SPI bus.
> > 
> > Experimentation with the startup delay on the regulator set to 50ms
> > shows that the reset is positively released after 20ms.
> > 
> > Schematics for this board are not available, and the traces are buried
> > in the inner layers of the board which makes tracing where the RSTN pin
> > extremely difficult.  We can only guess that the RSTN pin is wired to a
> > reset generator chip driven off the ethernet supply, which fits the
> > observed behaviour.
> 
> Based on the schematics of the Blaze device (which should be very close
> to SDP4430):
> 
> TPS22902YFPR is used as the regulator switch (gpio48 controlled)
> The VOUT is routed to  TPS3808G01DBV (SCH Note: Threshold set at 90%.
> Vsense: 0.405V).
> 
> According to the TPS3808 data sheet the RESET delay time when Ct is open
> (this is the case in the schema): MIN/TYP/MAX: 12/20/28 ms.
> 
> The 20ms you are seeing confirms this setup.

Thanks for the confirmation and information.  The Blaze schematics
are also unavailable afaics.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
