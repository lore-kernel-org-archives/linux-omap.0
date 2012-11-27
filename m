From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 03/10] ARM: OMAP: AM33xx hwmod: Add parent-child
 relationship for PWM subsystem
Date: Tue, 27 Nov 2012 06:24:03 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9EFFAC@DBDE01.ent.ti.com>
References: <1353387831-31538-1-git-send-email-avinashphilip@ti.com>
 <1353387831-31538-4-git-send-email-avinashphilip@ti.com>
 <518397C60809E147AF5323E0420B992E3E9EEA8C@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC4C0FA@DBDE01.ent.ti.com>
 <50B33043.2020700@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC4D5C7@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC4D5C7-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "Bedia, Vaibhav" <vaibhav.bedia-l0cyMroinI0@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hebbar,
 Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 26, 2012 at 16:37:36, Bedia, Vaibhav wrote:
> Hi Benoit,
> 
> On Mon, Nov 26, 2012 at 14:32:59, Cousson, Benoit wrote:
> > Hi Vaibhav,
> > 
> > On 11/26/2012 06:19 AM, Bedia, Vaibhav wrote:
> > > On Fri, Nov 23, 2012 at 16:36:06, Philip, Avinash wrote:
> > >> On Tue, Nov 20, 2012 at 10:33:44, Philip, Avinash wrote:
> > >>> As part of PWM subsystem integration, PWM subsystem are sharing
> > >>> resources like clock across submodules (ECAP, EQEP & EHRPWM).
> > >>> To handle resource sharing & IP integration
> > >>> 1. Rework on parent child relation between PWMSS and
> > >>>    ECAP, EQEP & EHRPWM child devices to support runtime PM.
> > >>> 2. Add support for opt_clks in EHRPWM HWMOD entry to handle additional
> > >>>    clock gating from control module.
> > >>> 3. Add HWMOD entries for EQEP PWM submodule.
> > >>>
> > >>
> > >> Is there any review on this patch?
> > >> This patch depends on ECAP & EHRPWM to work in am335x.
> > > 
> > > First of all, I think you should break up this patch as per the 3 points
> > > that you mentioned above.

I will split the patches into 2.
1. One for correcting hwmod entries  plus adding EQEP HWMOD entry
2. Adding parent child relation in hwmod entry.

> > > 
> > > The usage of opt_clks for this does not look right to me. Based on your
> > > description this clock is necessary and not optional on AM335x and on 
> > > Davinci platforms this clock does not exist.
> 
> I checked the DA830 TRM and looks like TBCLK for eHRPWM is an always on clock
> there. So, the only difference in AM335x is an additional enable bit.
> 
> Instead of adding this as opt_clk in hwmod, we could add an always on clock node
> in Davinci clock data and have the driver always do a clk_enable() on the tbclk
> as part of the probe sequence. On AM335x, with the right clock node this will enable
> the clock in hardware and on DA830 it turns into a NOP. This way we can avoid adding
> the opt_clk entry in hwmod of eHRPWM.

I will remove opt_clk in HWMOD and made tbclk is a mandatory clock in EHRPWM driver.

Thanks
Avinash
