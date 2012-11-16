From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
Date: Fri, 16 Nov 2012 06:16:02 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA6D1C4@DBDE01.ent.ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com> <5097F078.50701@ti.com>
 <20121114022341.GM4415@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B043@DBDE01.ent.ti.com>
 <20121114062117.GC7407@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B0AF@DBDE01.ent.ti.com>
 <20121114070046.GE7407@opensource.wolfsonmicro.com>
 <50A36DB1.3010706@ti.com> <20121114102452.GI7407@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121114102452.GI7407-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Content-Language: en-US
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
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org" <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 14, 2012 at 15:54:53, Mark Brown wrote:
> On Wed, Nov 14, 2012 at 11:08:49AM +0100, Benoit Cousson wrote:
> 
> > I was wondering that, because exposing a pin to control the whole PMIC
> > low power mode seems to be something that should be generic enough to be
> > handled by the regulator framework.
> 
> Having something that's controlled by software is really not at all
> generic - suspending a PMIC from a GPIO is generally tied in very
> closely with the CPU power sequencing which means it's typically some
> combination of very hard coded things that we can't control or part of
> much wider control of sequencing.
> 
> > In the current situation we do have a pwr_en pin that can be controlled
> > by a GPIO or whatever signal from the SoC.
> > That's very similar, at PMIC level, to the fixedregulator that allow a
> > GPIO binding to enable it.
> 
> > Don't you think that should deserve a support in the fmwk?
> 
> I'm not seeing a coherent description of a feature here - what exactly
> are you proposing that we do?  When and how would this GPIO be set for
> example?

It would be better if these patches are going in like this till the
framework exists. We can change/move this portion once the framework
is defined for this kind.

Thanks
AnilKumar
