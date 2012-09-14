From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/2] ARM: dts: AM33XX: Add lis331dlh device tree data to
 am335x-evm
Date: Fri, 14 Sep 2012 11:16:26 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2F2B1@DBDE01.ent.ti.com>
References: <1347551685-19781-1-git-send-email-anilkumar@ti.com>
 <201209140826.07069.arnd@arndb.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA2F0AB@DBDE01.ent.ti.com>
 <201209141028.38185.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201209141028.38185.arnd-r2nGTMty4D4@public.gmane.org>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org" <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org" <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+Daniel

On Fri, Sep 14, 2012 at 15:58:37, Arnd Bergmann wrote:
> On Friday 14 September 2012, AnilKumar, Chimata wrote:
> >> On Fri, Sep 14, 2012 at 13:56:06, Arnd Bergmann wrote:
> > > On Thursday 13 September 2012, AnilKumar Ch wrote:
> 
> > > 
> > > Why do you put the "reg" property here
> > 
> > Here I specified reg property because lis331dlh I2C slave address is 0x18.
> > 
> > > 
> > > >  		dcan1: d_can@481d0000 {
> > > >  			status = "okay";
> > > >  			pinctrl-names = "default";
> > > > @@ -61,6 +70,39 @@
> > > >  		regulator-max-microvolt = <5000000>;
> > > >  		regulator-boot-on;
> > > >  	};
> > > > +
> > > > +	lis3_reg: fixedregulator@1 {
> > > > +		compatible = "regulator-fixed";
> > > > +		regulator-name = "lis3_reg";
> > > > +		regulator-boot-on;
> > > > +	};
> > > > +};
> > > > +&lis331dlh {
> > > > +	compatible = "st,lis3lv02d-i2c";
> > > 
> > > and all the rest here? At least I would expect the "compatible" property
> > > to be in the same place above.
> > 
> > This data is appended to above one, to make it readable I moved remaining
> > properties to here.
> 
> I don't follow how this is making things more readable.

Basic lis3 parameter is in i2c2 node to tell the hierarchy of
nodes and remaining parameters at the bottom. With this way
we can understand easily what is start & end braces so that
node hierarchy is cleaner. (This is my view)

> 
> Maybe a more logical way to do this would be use the existing i2c2 label
> and write all the additions as
> 
> i2c2: {
> 	status = "okay";
> 	clock-frequency = <400000>;
> 
> 	lis331dlh@18 {
> 		compatible = "st,lis3lv02d";
> 		reg = <0x18>;
> 
> 		vdd-supply = <&lis3_reg>;
> 		vdd-io-supply = <&lis3_reg>;
> 		...
> 	};
> 

If this is better/preferable way then I will change.

> > > Also, I think you should remove the "-i2c" postfix from the name, that
> > > is already implied by the parent bus.
> > 
> > I will remove, but in case of spi the compatible name is lis3lv02d_spi.
> > By mistake I have uses "-i2c" instead of "_i2c".

Then, I will change to 'st,lis3lv02d' in lis3lv02d_i2c driver
and same will added to .dts file.

Small question here, in my v2 version I have specified both
the compatible names lis3lv02d and lis331dlh is it fine or
only one is sufficient?

+static struct of_device_id lis3lv02d_i2c_dt_ids[] = {
+	{ .compatible = "st,lis3lv02d" },
+	{ .compatible = "st,lis331dlh" },
+	{}
+};

> 
> The normal convention is to use '-', not '_', so that part was ok.
> 
> I think naming the other one lis3lv02d_spi was a mistake, it should
> be named 'st,lis3lv02d' independent of the bus IMHO.

Yes, initially I expected the same. I think driver name is used
as a compatible string.

> 
> > Document is already present, 
> > http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commit;h=2f2ff3cc8d930493f9a598b9192706c09403e12e
> > 
> > Some minor changes in docs, in my next version I will update document
> > as well. I will send V3 if there are no comments on v2.
> 

Can you just quickly review v2 series? So that I will send
V3.

Thanks
AnilKumar
