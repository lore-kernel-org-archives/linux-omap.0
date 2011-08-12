From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: How to handle named resources with DT?
Date: Fri, 12 Aug 2011 16:35:42 +0200
Message-ID: <201108121635.42953.arnd@arndb.de>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<20110812030218.GP30552@yookeroo.fritz.box>
	<20110812084106.GC19467@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110812084106.GC19467-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
Cc: "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "Cousson,
	Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Friday 12 August 2011, Felipe Balbi wrote:
> On Fri, Aug 12, 2011 at 01:02:18PM +1000, David Gibson wrote:
> 
> the whole point of using *byname() is for the driver to not care about
> the order of the resources. So if driver has to provided an ordered list
> of names, what's the benefit ? Sounds really stupid to provide an
> ordered list of names to an ordered list of resources, just to use
> *byname() instead of just assuming the list of resources is already
> ordered.

It only make sense for drivers that support both device tree probing
and legacy probing of static platform devices.

Note how almost all drivers use only platform_get_resource and not
platform_get_resource_byname:

arnd@ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource | wc -l
565
arnd@ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource_byname | wc -l
41
arnd@ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource_byname | xargs grep -wL platform_get_resource | wc -l # both
28
arnd@ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource_byname | xargs grep -wl platform_get_resource  | wc -l # only _byname
13

I think it's much easier to change the existing users of _byname over
to fixed indexes than to come up with a new scheme that is better.

	Arnd
