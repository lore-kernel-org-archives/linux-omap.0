From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving omap_devices
 to mach-omap2)
Date: Thu, 08 Nov 2012 09:35:51 +1100
Message-ID: <509AE247.3000404@gmail.com>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com> <6AE080B68D46FC4BA2D2769E68D765B708174B7D@039-SN2MPN1-023.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B708174B7D@039-SN2MPN1-023.039d.mgd.msft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Pantelis Antoniou <panto@antoniou-consulting.com>, Rob Herring <robherring2@gmail.com>, Deepak Saxena <dsaxena@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wood Scott-B07421 <B07421@freescale.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Russ Dill <Russ.Dill@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: linux-omap@vger.kernel.org

On 06/11/12 08:40, Tabi Timur-B04825 wrote:
> On Mon, Nov 5, 2012 at 2:40 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> 
>> Jane is building custom BeagleBone expansion boards called 'capes'. She
>> can boot the system with a stock BeagleBoard device tree, but additional
>> data is needed before a cape can be used. She could replace the FDT file
>> used by U-Boot with one that contains the extra data, but she uses the
>> same Linux system image regardless of the cape, and it is inconvenient
>> to have to select a different device tree at boot time depending on the
>> cape.
> 
> What's wrong with having the boot loader detect the presence of the
> Cape and update the device tree accordingly?  We do this all the time
> in U-Boot.  Doing stuff like reading EEPROMs and testing for the
> presence of hardware is easier in U-Boot than in Linux.

This is probably okay for some hardware, but doesn't work in the general
case. Not all hardware is detectable, for example a cape which just adds
a set of LEDs for GPIO pins. Also, some hardware might not easily be
detectable without adding additional complexity to the boot loader.

~Ryan
