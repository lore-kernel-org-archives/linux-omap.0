From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/4] rtc: OMAP: Add system pm_power_off to rtc driver
Date: Wed, 14 Nov 2012 05:50:46 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA6AFB4@DBDE01.ent.ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-3-git-send-email-anilkumar@ti.com>
 <5097ECAD.9010101@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA64F14@DBDE01.ent.ti.com>
 <50994156.4080305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
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
To: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org" <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 14, 2012 at 10:31:42, AnilKumar, Chimata wrote:
> +Mark
> 
> On Mon, Nov 12, 2012 at 15:17:13, AnilKumar, Chimata wrote:
> > On Tue, Nov 06, 2012 at 22:26:54, Cousson, Benoit wrote:
> > > Hi Anil,
> > > 
> > > On 11/06/2012 06:07 AM, AnilKumar, Chimata wrote:
> > > > On Mon, Nov 05, 2012 at 22:13:25, Cousson, Benoit wrote:
> > > >> Hi Anil / Colin,
> > > >>
> > > >> On 11/05/2012 10:42 AM, AnilKumar Ch wrote:
> > > >>> From: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
> > > >>>
> > > >>> Add system power off control to rtc driver which is the in-charge
> > > >>> of controlling the BeagleBone system power. The power_off routine
> > > >>> can be hooked up to "pm_power_off" system call.
> > > >>>
> > > >>> System power off sequence:-
> > > >>> * Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
> > > >>> * Enable PMIC_POWER_EN in rtc module
> > > >>> * Set rtc ALARM2 time
> > > >>> * Enable ALARM2 interrupt
> > > >>>
> > > >>> Added while (1); after the above steps to make sure that no other
> > > >>> process acquire cpu. Otherwise we might see an unexpected behaviour
> > > >>> because we are shutting down all the power rails of SoC except RTC.
> > > >>>
> > > >>> Signed-off-by: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
> > > >>> [anilkumar-l0cyMroinI0@public.gmane.org: move poweroff additions to rtc driver]
> > > >>> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> > > >>> ---
> > > >>>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
> > > >>>  drivers/rtc/rtc-omap.c                             |   79 +++++++++++++++++++-
> > > >>>  2 files changed, 83 insertions(+), 1 deletion(-)
> > > >>>
> > > >>> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> > > >>> index b47aa41..8d9f4f9 100644
> > > >>> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> > > >>> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> > > >>> @@ -6,6 +6,10 @@ Required properties:
> > > >>>  - interrupts: rtc timer, alarm interrupts in order
> > > >>>  - interrupt-parent: phandle for the interrupt controller
> > > >>>  
> > > >>> +Optional properties:
> > > >>> +- ti,system-power-controller: Telling whether or not rtc is controlling
> > > >>> +  the system power.
> > > >>
> > > >> I don't know how it is connected at board level, but I'm not sure the
> > > >> binding is the proper one.
> > > > 
> > > > Hi Benoit,
> > > >  ________________________________
> > > > |   ______          _______      |
> > > > |  |      |        |       |     |
> > > > |  |RTC   |        |       |     |
> > > > |  |PMIC  |  Line  |       |     |
> > > > |  |PWR_EN|=======>|PWR_EN |     |
> > > > |  |______|        |_______|     |
> > > > |  AM335x SoC       TPS65217     |
> > > > |                                |
> > > > |________________________________|
> > > >           BeagleBone
> > > > 
> > > > This is how RTC PMIC_PWR_EN is connected to PWR_EN of TPS65217 PMIC. Only when
> > > > RTC pull low in PMIC_PWR_EN then PMIC will go to power off state provided TPS65217
> > > > status should be changed to STATUS_OFF.
> > > > 
> > > > ALARM2 event should be trigger to configure PMIC_PWR_EN properly then the "Line"
> > > > driven low so that PMIC will go to shutdown mode.

Mark,

Details regarding how PMIC PWR_EN is connected to RTC module

Thanks
AnilKumar

> > > 
> > > Thanks for the nice diagram :-)
> > 
> > I missed this mail thread so delayed in response
> > 
> > > 
> > > I'm wondering if we cannot abuse the gpio binding to describe that
> > > connection instead of creating two custom attributes (PMIC + RTC).
> > > 
> > > Ideally we should do that without having to change the RTC to use the
> > > gpiolib at all.
> > > 
> > > 
> > > rtc: rtc@44e3e000 {
> > > 	compatible = "ti,da830-rtc";
> > > 	reg = <0x44e3e000 0x1000>;
> > > 	interrupts = <75, 76>;
> > > 	ti,hwmods = "rtc";
> > > 
> > > 	/* expose the PWR_EN functionality of this RTC*/
> > > 	gpio-controller;
> > > 	#gpio-cells = <0>; /* assuming we can use 0 ??? */
> > > };
> > > 
> > > ...
> > > 
> > > tps: tps@24 {
> > >  	compatible = "ti,tps65217";
> > > 	/*
> > >          * Enable the power enable feature from
> > >          * the input line if that attribute is there.
> > >          */
> > > 	gpio-power-en = <&rtc>; /* PWR_EN */
> > > 
> > > 	...
> > > }	
> > > 
> > > Any thought?
> > 
> > No, these two are independent controllers. PMIC can go to power
> > off mode if we pull PWR_EN to low. We can pull down that line
> > by any means like PRCM or GPIO or some other. So these two flags
> > should be independent from each other.
> > 
> > Thanks
> > AnilKumar
> > 
> 
> 
