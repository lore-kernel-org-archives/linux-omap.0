From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP display kconfig options changing
Date: Fri, 18 Dec 2015 08:05:14 -0800
Message-ID: <20151218160514.GK23396@atomide.com>
References: <5673CA0D.4000706@ti.com> <20151218135342.GF23396@atomide.com>
 <56741FA9.3080607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56741FA9.3080607@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [151218 07:01]:
> 
> 
> On 18/12/15 15:53, Tony Lindgren wrote:
> > Hi,
> > 
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [151218 00:55]:
> >> Hi Tony,
> >>
> >> I've just pushed a patch series to fbdev for-next branch which makes the
> >> OMAP DRM and FB drivers independent of each other. This requires
> >> changing the related Kconfig options.
> > 
> > OK
> 
> Note that nothing has changed with omapfb and omapdrm as such. The only
> (visible) change is the needed Kconfig options.

OK

> >> What should I do with omap2plus_defconfig?
> >>
> >> At the moment omap2plus_defconfig enables the omapfb driver and panels
> >> as modules. Should I change it to do the same with the new code? Or
> >> should I change it to use omapdrm, which is the better maintained and
> >> developed driver (although no one has probably tried omapdrm on omap2)?
> > 
> > I'm all for changing omap2plus_defconfnig to use omapdrm.
> > 
> > Do you have a link to a page we can point people to for instructions
> > for what needs to be changed to get things working with omapdrm?
> 
> Are you referring to Kconfig options? Or userspace?

Well sounds like both need updating :)

> But no, I don't have links to either.

So change the Kconfig options and then deal with the flood
of angry emails? :) I think we need instructions..

> For the Kconfig options, it's pretty similar to omapfb. After the
> patches I'm pushing, one needs to enable DRM, DRM_OMAP, and then the
> individual panel/encoder drivers (as for omapfb).
> 
> > For omap2, I can try to peek into my rack for n800.
> 
> There were a few fixes sent a few days ago which are needed for OMAP2/3.
> I think both are now in Linus' tree.

OK I guess we have to wait your patches then to give it
a try.

Regards,

Tony
