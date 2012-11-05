From: Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving
 omap_devices to mach-omap2)
Date: Mon, 5 Nov 2012 21:40:16 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B708174B7D@039-SN2MPN1-023.039d.mgd.msft.net>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <6932259F391B4F4AB9A0C0DF5FBDE793-725oAoX4OcF2GV6JINhBVAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Deepak Saxena <dsaxena-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 5, 2012 at 2:40 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> Jane is building custom BeagleBone expansion boards called 'capes'. She
> can boot the system with a stock BeagleBoard device tree, but additional
> data is needed before a cape can be used. She could replace the FDT file
> used by U-Boot with one that contains the extra data, but she uses the
> same Linux system image regardless of the cape, and it is inconvenient
> to have to select a different device tree at boot time depending on the
> cape.

What's wrong with having the boot loader detect the presence of the
Cape and update the device tree accordingly?  We do this all the time
in U-Boot.  Doing stuff like reading EEPROMs and testing for the
presence of hardware is easier in U-Boot than in Linux.

For configurations that can be determined by the boot loader, I'm not
sure overlays are practical.

> Nigel is building a real-time video processing system around a MIPS SoC
> and a Virtex FPGA. Video data is streamed through the FPGA for post
> processing operations like motion tracking or compression. The FPGA is
> configured via the SPI bus, and is also connected to GPIO lines and the
> memory mapped peripheral bus. Nigel has designed several FPGA
> configurations for different video processing tasks. The user will
> choose which configuration to load which can even be reprogrammed at
> runtime to switch tasks.

Now this, on the other hand, makes more sense.  If the hardware
configuration is literally user-configurable, then okay.  However, I'm
not sure I see the need to update the device tree.  The device tree is
generally for hardware that cannot be discovered/probed by the device
driver.  If we're loading a configuration from user space, doesn't the
driver already know what the hardware's capabilities are, since it's
the one doing the uploading of a new FPGA code?  Why not skip the
device tree update and just tell the driver what the new capabilities
are?

-- 
Timur Tabi
Linux kernel developer at Freescale
