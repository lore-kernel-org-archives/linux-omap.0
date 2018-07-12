From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3] Add DT support for Octavo Systems OSD3358-SM-RED
 based on TI AM335x
Date: Thu, 12 Jul 2018 08:53:25 +0100
Message-ID: <20180712075325.GH6920@n2100.armlinux.org.uk>
References: <20180711145822.1090-1-neeraj.dantu@octavosystems.com>
 <20180712053155.GP99251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180712053155.GP99251@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Jason Kridner <jkridner@gmail.com>, Neeraj Dantu <dantuguf14105@gmail.com>, Neeraj Dantu <neeraj.dantu@octavosystems.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 11, 2018 at 10:31:55PM -0700, Tony Lindgren wrote:
> Hi,
> 
> * Neeraj Dantu <dantuguf14105@gmail.com> [180711 15:13]:
> > OSD3358-SM-RED is a dev board for OSD335x System-in-Package(SiP) devices from
> > Octavo Systems.
> ...
> > - Fix HDMI encoder node name
> 
> I think you got this the wrong way around :) See below.
> 
> > +&i2c0 {
> > +	hdmiencoder: tda19988 {
> > +		compatible = "nxp,tda998x";
> 
> 	tda19988: hdmiencoder {
> 		...
> 	};
> 
> So the generic type for the node. Please check the
> other devices for that too.

In the binding doc, we use "hdmi-encoder" for the node name.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
