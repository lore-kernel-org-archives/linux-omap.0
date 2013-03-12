From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] cpufreq: cpufreq-cpu0: provide compatibility string
 for DT matchup
Date: Tue, 12 Mar 2013 16:31:07 +0100
Message-ID: <513F4A3B.7080806@ti.com>
References: <1363043130-30270-1-git-send-email-nm@ti.com>
 <1363043130-30270-3-git-send-email-nm@ti.com> <513EB7FE.1070000@ti.com>
 <513F3B98.6050909@ti.com> <20130312144334.GB21599@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130312144334.GB21599@kahuna>
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
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael
 J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/12/2013 03:43 PM, Nishanth Menon wrote:
> On 15:28-20130312, Benoit Cousson wrote:
>> On 03/12/2013 06:07 AM, Santosh Shilimkar wrote:
>>> On Tuesday 12 March 2013 04:35 AM, Nishanth Menon wrote:
>>>> commit 5553f9e (cpufreq: instantiate cpufreq-cpu0 as a platform_driver)
>>>> now forces platform device to be registered for allowing cpufreq-cpu0
>>>> to be used by SoCs. example: drivers/cpufreq/highbank-cpufreq.c
>>>>
>>>> However, for SoCs that wish to link up using device tree, instead
>>>> of platform device, provide compatibility string match:
>>>> compatible = "cpufreq,cpu0";
>>
>> You cannot add a non-HW relative binding... DT is supposed to represent
>> the pure HW.
>> AFAIK, cpufreq has nothing to do with the HW definition.
> Ref:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/highbank-cpufreq.c#n61
> there is a need for a device of some sort.  in the example above, we
> register a dummy device for linking up with cpufreq-cpu0 driver.
> what we do in this patch is to indicate that SoC CPUs are managed by
> cpufreq-cpu0 driver.
> 
> I am a bit curious to see how else would we represent drivers to manage
> real h/w devices like CPU? Is the highbank style the recommended way to do
> things?

Yep, I don't think this is a very elegant way to do that, but until we
do have a generic DVFS layer, I'm not sure we have any other approach.
But maybe not.

The CPU is the real device, but AFAIK, nobody beside OMAP is
representing the CPU as the device.
But I'd rather use a CPU device than a fake CPUFREQ device.

Regards,
Benoit
