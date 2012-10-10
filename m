From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc: Fix kernel BUG for DT boot mode
Date: Wed, 10 Oct 2012 10:37:42 -0400
Message-ID: <20121010143742.GE13724@beef>
References: <1349773040-8204-1-git-send-email-hvaibhav@ti.com>
 <20121010140027.GB13724@beef>
 <79CD15C6BA57404B839C016229A409A83EB3B573@DBDE01.ent.ti.com>
 <20121010143501.GC13724@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121010143501.GC13724@beef>
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
To: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Cc: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 10, 2012 at 10:35:01AM -0400, Matt Porter wrote:
> On Wed, Oct 10, 2012 at 02:19:40PM +0000, Vaibhav Hiremath wrote:
> > On Wed, Oct 10, 2012 at 19:30:27, Porter, Matt wrote:
> > > On Tue, Oct 09, 2012 at 02:27:20PM +0530, Vaibhav Hiremath wrote:
> > > > With recent changes in omap gpmc driver code, in case of DT
> > > > boot mode, where bootloader does not configure gpmc cs space
> > > > will result into kernel BUG() inside gpmc_mem_init() function,
> > > > as gpmc cs0 gpmc_config7[0].csvalid bit is set to '1' and
> > > > gpmc_config7[0].baseaddress is set to '0' on reset.
> > > > 
> > > > This use-case is applicable for any board/EVM which doesn't have
> > > > any peripheral connected to gpmc cs0, for example BeagleXM and
> > > > BeagleBone, so DT boot mode fails.
> > > > 
> > > > This patch adds of_have_populated_dt() check before creating
> > > > device, so that for DT boot mode, gpmc probe will not be called
> > > > which is expected behavior, as gpmc is not supported yet from DT.
> > > > 
> > > > Signed-off-by: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
> > > > Cc: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
> > > > Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > > > Cc Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> > > > ---
> > > > This should go in for rc1, as this breaks AM33xx boot.
> > > 
> > > Fixes BeagleBone on mainline.
> > > 
> > > Tested-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> > > 
> > 
> > Thanks Matt and Afzal,
> > 
> > Tony can this be picked up for rc1?? I know you have already sent pull 
> > request for rc1, but by any chance you are planning to send another request?
> 
> I also found a separate problem with the mcasp clock data that's needed
> for rc1. I just posted a patch for that as I need both this patch and the
> clock data fix to boot from current mainline.

Disregard now that you got me pointed to the pull request with this :)

-Matt
