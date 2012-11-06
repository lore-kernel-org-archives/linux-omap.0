From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
Date: Tue, 6 Nov 2012 05:13:23 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA64F94@DBDE01.ent.ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com> <5097F078.50701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5097F078.50701-l0cyMroinI0@public.gmane.org>
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
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org" <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 05, 2012 at 22:29:36, Cousson, Benoit wrote:
> + Mark
> 
> On 11/05/2012 10:42 AM, AnilKumar Ch wrote:
> > From: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
> > 
> > Set tps65217 PMIC status to OFF if power enable toggle is
> > supported. Also adds platform data flag, which should be
> > passed from board init data.
> > 
> > Signed-off-by: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
> > [anilkumar-l0cyMroinI0@public.gmane.org: move the additions to tps65217 MFD driver]
> > Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> > ---
> >  .../devicetree/bindings/regulator/tps65217.txt     |    4 ++++
> >  drivers/mfd/tps65217.c                             |   12 ++++++++++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/regulator/tps65217.txt b/Documentation/devicetree/bindings/regulator/tps65217.txt
> > index d316fb8..4f05d20 100644
> > --- a/Documentation/devicetree/bindings/regulator/tps65217.txt
> > +++ b/Documentation/devicetree/bindings/regulator/tps65217.txt
> > @@ -11,6 +11,9 @@ Required properties:
> >    using the standard binding for regulators found at
> >    Documentation/devicetree/bindings/regulator/regulator.txt.
> >  
> > +Optional properties:
> > +- ti,pmic-shutdown-controller: Telling the PMIC to shutdown on PWR_EN toggle.
> 
> That sounds like a generic functionality to me. Don't we have some more
> generic way to handle that?

But STATUS_OFF should be set only if Board supports it, otherwise
this change doesn't make sense.

> 
> If not, that should probably not be a TI only attribute.
> 
> It looks like a GPIO like kind of interface at PMIC level.

I agree this should be a generic parameter, but in some regulators this STATUS OFF
control might not be available. This is in my mind while name this parameter.

Thanks
AnilKumar
