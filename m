From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [GIT PULL] ARM part of USB patches
Date: Tue, 5 Feb 2013 10:19:47 -0800
Message-ID: <20130205181947.GI25185@atomide.com>
References: <51112418.5020000@ti.com> <51112495.4060908@ti.com>
 <20130205172724.GA1601@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130205172724.GA1601-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
To: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> [130205 09:28]:
> On Tue, Feb 05, 2013 at 08:56:13PM +0530, kishon wrote:
> > Hi Tony, Greg,
> > 
> > On Tuesday 05 February 2013 08:54 PM, kishon wrote:
> > >Hi Tony,
> > >
> > >As discussed, I'm sending a pull request for the arch/arm part of my USB
> > >patches. These patches are necessary to get MUSB functional in both dt
> > >and non-dt boot. Also added dt data for dwc3 present in OMAP. This patch
> > >series *depends* on some of the patches which are merged in usb-next.
> > 
> > This patch series should go in only after USB. Or else it will break
> > compilation.
> 
> Then it probably should go through the USB tree, right?  We don't want
> to break bisectability.

Looks like this branch needs to be based on at least 01658f0f (usb: phy:
add a new driver for usb part of control module) to compile. Probably
needs other USB patches too to make sense.

This branch has a high likelihood of conflicting with .dts files, so
Kishon, I suggest you do two branches:

1. A branch for Greg based on top of the USB changes

   This branch should contain:

   ARM: OMAP4: remove control module address space from PHY and OTG
   ARM: OMAP: devices: create device for usb part of control module
   ARM: OMAP2: MUSB: Specify omap4 has mailbox
   ARM: OMAP: USB: Add phy binding information

   Naturally please make sure they compile and boot on their own.
   Looks like this will only cause few trivial include merge conflicts
   with what I have queued up.

   You can add my Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> for those.

2. A branch for Benoit based on v3.8-rc6

   That branch should contain all the .dts changes as those will
   most likely cause nasty merge conflicts otherwise with what
   Benoit has queued up.

Regards,

Tony
