From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Shouldn't DT preserve pdev name and id to allow platform_match
	to work?
Date: Sat, 6 Aug 2011 22:13:30 -0600
Message-ID: <20110807041330.GG7667@ponder.secretlab.ca>
References: <4E396361.3060307@ti.com>
	<CACxGe6vg5NTyiDZqqztjtFEfb7si+-=Y7nEy1Y+YMgA5PVXScw@mail.gmail.com>
	<CAGsJ_4x7LWRGWXsWzMG1FxZPaFYiKSUpSac2PdwH=d6vqFWRfw@mail.gmail.com>
	<4E3BE294.2020404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4E3BE294.2020404-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "G,
	Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 05, 2011 at 02:31:16PM +0200, Cousson, Benoit wrote:
> On 8/5/2011 12:02 PM, Barry Song wrote:
> >>auxdata passes platform_data and overrides the device name when there
> >>is no way easy way to make the driver work without it.  It handles the
> >>the current implementation of clocks and regulators which aren't yet
> >>populated from the device tree.  It will go away when clock&
> >>regulator bindings are implemented.
> >Yes. As OF_DEV_AUXDATA_ID still requires hardware information like
> >0x48000100 as below, it seems it is not
> >consistent with the origin purpose of ARM DT.
> >OF_DEV_AUXDATA_ID("ti,omap-i2c", 0x48000100, "omap-i2c.1", 1,&i2c_pdata)
> >And the information 0x48000100 is something that doesn't want to be in
> >kernel codes.it should be only in dts.
> 
> FWIW, I do not care about the physical address at all. This is just
> used by the of_dev_lookup function to get the proper instance for a
> device compatible type.
> That's the only way for the OF_DEV_AUXDATA to work, but in theory
> you could do the same as soon as you provide the id. So
> OF_DEV_AUXDATA_ID could avoid it.
> 
> Since OF_DEV_AUXDATA_ID seems to be already dead before it even
> reaches the mainline, let's forget about that.

Actually, I'm planning to merge OF_DEV_AUXDATA_ID().  I was hoping to
avoid it but there was enough hard-to-solve-quickly problems that I've
relented.

Adding the match table is not hard-to-solve though, so I'm not
relenting on that point.  :-)

g.
