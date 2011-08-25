From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: How to handle named resources with DT?
Date: Thu, 25 Aug 2011 11:28:24 +0100
Message-ID: <20110825102824.GB10405@n2100.arm.linux.org.uk>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<20110812030218.GP30552@yookeroo.fritz.box>
	<20110812084106.GC19467@legolas.emea.dhcp.ti.com>
	<201108121635.42953.arnd@arndb.de> <4E45422D.4050708@ti.com>
	<CACxGe6s-2EAuvSqzn6yzDvCyVXa8vVVqG2X=1XFrUBnB=jsdxQ@mail.gmail.com>
	<87r54a1v0o.fsf@ti.com>
	<20110824231613.GC19890@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110824231613.GC19890-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "G,
	Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 25, 2011 at 02:16:14AM +0300, Felipe Balbi wrote:
> on top of all that, for IPs which are used on many SoCs (such as MUSB)
> it's quite silly to force all users to provide resources in a certain
> order. It sounds to me that this will be prone to error in many ways
> until everything is synced up and on the correct order.
> 
> Ditching _byname is a very bad idea.

I continue to disagree.  The current _byname is an abonimation and hack
to try to "fix" this problem.

_byname should have been implemented differently - rather than overriding
the resources name field (which is _normally_ specified to be the device
or driver name), a new field should have been introduced in struct resource
to carry the resource sub-name (which is really what it is.)

That would have avoided making /proc/iomem completely illegible with
multiple devices using this feature.
