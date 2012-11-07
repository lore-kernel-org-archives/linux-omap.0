From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/8] PWMSS: Add PWM Subsystem driver for parent<->child
 relationship
Date: Wed, 7 Nov 2012 15:20:26 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9DE3A0@DBDE01.ent.ti.com>
References: <1352106749-9437-1-git-send-email-avinashphilip@ti.com>
 <1352106749-9437-2-git-send-email-avinashphilip@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC0444A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC0444A-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "Bedia, Vaibhav" <vaibhav.bedia-l0cyMroinI0@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hebbar,
 Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 06, 2012 at 12:05:24, Bedia, Vaibhav wrote:
> On Mon, Nov 05, 2012 at 14:42:22, Philip, Avinash wrote:
> [...]
> > +pwmss0: pwmss@48300000 {
> > +	compatible = "ti,am33xx-pwmss";
> > +	reg = <0x48300000 0x10
> > +		0x48300100 0x80
> > +		0x48300180 0x80
> > +		0x48300200 0x80>;
> Do you really need the 4 address ranges here? You eventually do add in
> child nodes with other address ranges so isn't the first entry sufficient?
> I haven't really looked at the DT details so it is enforced by that let me
> know.

This is required to define child nodes ranges so that childs reg space
entries are defined in the range.

> 
> [...]
> > +
> > +#define PWMSS_CLKCONFIG		8
> > +
> 
> This #def can use a comment.

Ok I will add.

> 
> > +void pwmss_submodule_state_change(struct device *dev, int pos, bool enable)
> > +{
> > +	struct pwmss_info *info = dev_get_drvdata(dev);
> > +	u16 val;
> > +
> > +	val = readw(info->mmio_base + PWMSS_CLKCONFIG);
> > +	if (enable)
> > +		val |= 1 << pos;
> > +	else
> > +		val &= ~(1 << pos);
> > +	mutex_lock(&info->pwmss_lock);
> > +	writew(val , info->mmio_base + PWMSS_CLKCONFIG);
> > +	mutex_unlock(&info->pwmss_lock);
> > +}
> > +EXPORT_SYMBOL(pwmss_submodule_state_change);
> 
> I see a clk_en_ack field in the clock status register. You should be checking that.

Ok. I will add for check & return status from pwmss_submodule_state_change().

> 
> [...]
> 
> > +
> > +MODULE_DESCRIPTION("pwmss driver");
> > +MODULE_AUTHOR("Texas Instruments");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/pwm/tipwmss.h b/drivers/pwm/tipwmss.h
> > new file mode 100644
> > index 0000000..83fdc29
> > --- /dev/null
> > +++ b/drivers/pwm/tipwmss.h
> > @@ -0,0 +1,8 @@
> 
> License text?

Ok I will add.

Thanks
Avinash
>  
> > +#ifdef CONFIG_PWM_TIPWMSS
> > +extern void pwmss_submodule_state_change(struct device *dev, int pos,
> > +		bool enable);
> > +#else
> > +static inline void pwmss_submodule_state_change(struct device *dev, int pos,
> > +		bool enable)
> > +{}
> > +#endif
> 
> Regards,
> Vaibhav
> 
