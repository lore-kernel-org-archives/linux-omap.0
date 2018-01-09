From: qhou <qi.hou@windriver.com>
Subject: Re: [PATCH] arm: omap2: timer: fix a kmemleak caused in
 omap_get_timer_dt
Date: Tue, 9 Jan 2018 09:42:02 +0800
Message-ID: <674f9bda-01b5-2336-12e8-d1aa03413324@windriver.com>
References: <1515373733-3658-1-git-send-email-qi.hou@windriver.com>
 <201801090643.8ChygjAc%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201801090643.8ChygjAc%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, tony@atomide.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 2018年01月09日 07:13, kbuild test robot wrote:
> Hi Qi,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on omap/for-next]
> [also build test WARNING on v4.15-rc7 next-20180108]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Qi-Hou/arm-omap2-timer-fix-a-kmemleak-caused-in-omap_get_timer_dt/20180109-033316
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git for-next
> config: arm-omap2plus_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
>
> All warnings (new ones prefixed by >>):
>
>     arch/arm/mach-omap2/timer.c: In function 'omap_get_timer_dt':
> >> arch/arm/mach-omap2/timer.c:205:12: warning: return makes pointer from integer without a cast [-Wint-conversion]
>          return -ENOMEM;

Yes, it's problem.

I will correct it to "return NULL;".

As omap_get_timer_dt() is called in early time during booting up kernel, 
that allocating a little size of memory should

always be alright. Return NULL just in case that it fails.

--
best regards,
Qi Hou
>                 ^
>
> vim +205 arch/arm/mach-omap2/timer.c
>
>     170	
>     171	/**
>     172	 * omap_get_timer_dt - get a timer using device-tree
>     173	 * @match	- device-tree match structure for matching a device type
>     174	 * @property	- optional timer property to match
>     175	 *
>     176	 * Helper function to get a timer during early boot using device-tree for use
>     177	 * as kernel system timer. Optionally, the property argument can be used to
>     178	 * select a timer with a specific property. Once a timer is found then mark
>     179	 * the timer node in device-tree as disabled, to prevent the kernel from
>     180	 * registering this timer as a platform device and so no one else can use it.
>     181	 */
>     182	static struct device_node * __init omap_get_timer_dt(const struct of_device_id *match,
>     183							     const char *property)
>     184	{
>     185		struct device_node *np;
>     186	
>     187		for_each_matching_node(np, match) {
>     188			if (!of_device_is_available(np))
>     189				continue;
>     190	
>     191			if (property && !of_get_property(np, property, NULL))
>     192				continue;
>     193	
>     194			if (!property && (of_get_property(np, "ti,timer-alwon", NULL) ||
>     195					  of_get_property(np, "ti,timer-dsp", NULL) ||
>     196					  of_get_property(np, "ti,timer-pwm", NULL) ||
>     197					  of_get_property(np, "ti,timer-secure", NULL)))
>     198				continue;
>     199	
>     200			if (!of_device_is_compatible(np, "ti,omap-counter32k")) {
>     201				struct property *prop;
>     202	
>     203				prop = kzalloc(sizeof(*prop), GFP_KERNEL);
>     204				if (!prop)
>   > 205					return -ENOMEM;

Correct "return -ENOMEM" to "return NULL;" in case that it fails to 
allocate a new memory block.

--
Qi Hou
>     206				prop->name = "status";
>     207				prop->length = sizeof("disabled");
>     208				prop->value = "disabled";
>     209				of_add_property(np, prop);
>     210			}
>     211			return np;
>     212		}
>     213	
>     214		return NULL;
>     215	}
>     216	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
Best regards,
Qi Hou
Phone number: +86-10-8477-8608
Address: Floor 15, Building B, Wangjing Plaza, No.9 Zhong-Huan Nanlu, Chaoyang District
