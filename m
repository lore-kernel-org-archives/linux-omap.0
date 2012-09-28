From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] usb: phy: add a new driver for usb3 phy
Date: Fri, 28 Sep 2012 15:10:59 +0530
Message-ID: <CAAe_U6J_AGArYEj1-sUmEeVkMmbkhp=WZxOuN-y-L6E5SDJM=Q@mail.gmail.com>
References: <1348754648-8315-1-git-send-email-kishon@ti.com>
 <1348754648-8315-2-git-send-email-kishon@ti.com>
 <20120927141837.GA26268@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120927141837.GA26268-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
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
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Sep 27, 2012 at 7:48 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Thu, Sep 27, 2012 at 07:34:07PM +0530, Kishon Vijay Abraham I wrote:
>> +static int omap5_usb_phy_power(struct omap_usb *phy, bool on)
>> +{
>> +     u32 val;
>> +     unsigned long rate;
>> +     struct clk *sys_clk;
>> +
>> +     sys_clk = clk_get(NULL, "sys_clkin");
>> +     if (IS_ERR(sys_clk)) {
>> +             pr_err("%s: unable to get sys_clkin\n", __func__);
>> +             return -EINVAL;
>> +     }
>> +
>> +     rate = clk_get_rate(sys_clk);
>> +     rate = rate/1000000;
>> +     clk_put(sys_clk);
>
> Actually, you're supposed to hold on to the struct clk all the time your
> driver is making use of that - you're not supposed to drop it.
>
> That has several advantages: if clk_get() fails, then you're failing
> earlier on (when the driver is being probed) and when some event occurs.

Ok. Will post a patch fixing it.

Thanks
Kishon
