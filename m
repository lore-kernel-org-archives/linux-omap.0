From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 09/33] CLK: omap: add omap4 clock init file
Date: Thu, 1 Aug 2013 09:40:01 -0500
Message-ID: <51FA7341.7040303@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-10-git-send-email-t-kristo@ti.com>
 <51F81516.3050302@ti.com> <51F924CA.6000803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F924CA.6000803@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, tony@atomide.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/31/2013 09:52 AM, Tero Kristo wrote:
> On 07/30/2013 10:33 PM, Nishanth Menon wrote:
[...]

>>
>>> +    DT_CLK(NULL,    "cpufreq_ck",    "dpll_mpu_ck"),
>> please remove cpufreq.
>
> Hmm why?
>
> Because cpufreq is completely broken now and your current work on it? :)

cpufreq fixing can be done separately and has abillity to pick up clock 
nodes by describing clocks=<&dpll_mpu_ck> in cpu0 node. absolutely no 
need to carry on this hack - See my comment on [1]

yes, I know I will have to redo my cpufreq series, but thanks to your 
work, it is a 10 min job to enable them back online :) dont worry about 
the broken cpufreq, we will fix it properly and it is not even needed 
for basic boot to shell (example omap2plus_defconfig does not even 
enable CONFIG_CPU_FREQ).


>>
>>> +    abe_dpll_ref = clk_get_sys(NULL, "abe_dpll_refclk_mux_ck");
>>> +    sys_32k_ck = clk_get_sys(NULL, "sys_32k_ck");
>>> +    rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
>>> +    abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
>>> +    if (!rc)
>>> +        rc = clk_set_rate(abe_dpll, OMAP4_DPLL_ABE_DEFFREQ);
>>> +    if (rc)
>>> +        pr_err("%s: failed to configure ABE DPLL!\n", __func__);
>>> +
>>> +    /*
>>> +     * Lock USB DPLL on OMAP4 devices so that the L3INIT power
>>> +     * domain can transition to retention state when not in use.
>>> +     */
>>> +    usb_dpll = clk_get_sys(NULL, "dpll_usb_ck");
>>> +    rc = clk_set_rate(usb_dpll, OMAP4_DPLL_USB_DEFFREQ);
>>> +    if (rc)
>>> +        pr_err("%s: failed to configure USB DPLL!\n", __func__);
>>
>> ^^^^ why cant we have a generic property that does this "automagically"
>> from dts property to the node?
>> a) be able to select a parent
>> b) be able to set a frequency.
>> c) how do we ensure that CLK_SET_RATE_PARENT are setup for the clock
>> nodes defined by dt?
>
> This is probably for Mike to answer, currently such mechanism does not
> exist.

I think you already dealt with (c). in the same vein, we can do (a) and 
(b). Dont think anyone else has gone about this to the extent we are 
attempting to do till date, so as pioneers, we might as well suggest 
with a patch :D ?

[1] http://marc.info/?l=linux-omap&m=137536714605620&w=2
-- 
Regards,
Nishanth Menon
