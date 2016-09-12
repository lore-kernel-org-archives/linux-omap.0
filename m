From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: Re: [PATCH v5] rtc: omap: Support ext_wakeup configuration
Date: Mon, 12 Sep 2016 11:01:05 +0200
Message-ID: <4512fa0b-890b-0f10-00dd-188fcc98fb5c@grinn-global.com>
References: <201609082240.a4dMqCnB%fengguang.wu@intel.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <rtc-linux+bncBD7N3SEV2QCRBXW53G7AKGQE6QR3LQA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <201609082240.a4dMqCnB%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

I guess we are missing PINCTRL in Kconfig. I didn't add that before,
because I thought that there is a dependency chain GENERIC_PINCONF ->
PINCONF -> PINCTRL.

So to resolve this issue:
1) Should we add "select" or "depends on" for PINCTRL?
2) Should this option be somehow related to COMPILE_TEST?

On 08.09.2016 16:20, kbuild test robot wrote:
> Hi Marcin,
>
> [auto build test ERROR on abelloni/rtc-next]
> [also build test ERROR on v4.8-rc5]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
>
> url:    https://github.com/0day-ci/linux/commits/Marcin-Niestroj/rtc-omap-Support-ext_wakeup-configuration/20160908-190900
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 4.9.0
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64
>
> All error/warnings (new ones prefixed by >>):
>
>>> drivers/rtc/rtc-omap.c:535:38: error: array type has incomplete element type
>     static const struct pinctrl_pin_desc rtc_pins_desc[] = {
>                                          ^
>>> drivers/rtc/rtc-omap.c:536:2: error: implicit declaration of function 'PINCTRL_PIN' [-Werror=implicit-function-declaration]
>      PINCTRL_PIN(0, "ext_wakeup0"),
>      ^
>>> drivers/rtc/rtc-omap.c:553:21: error: variable 'rtc_pinctrl_ops' has initializer but incomplete type
>     static const struct pinctrl_ops rtc_pinctrl_ops = {
>                         ^
>>> drivers/rtc/rtc-omap.c:554:2: error: unknown field 'get_groups_count' specified in initializer
>      .get_groups_count = rtc_pinctrl_get_groups_count,
>      ^
>>> drivers/rtc/rtc-omap.c:554:2: warning: excess elements in struct initializer
>    drivers/rtc/rtc-omap.c:554:2: warning: (near initialization for 'rtc_pinctrl_ops')
>>> drivers/rtc/rtc-omap.c:555:2: error: unknown field 'get_group_name' specified in initializer
>      .get_group_name = rtc_pinctrl_get_group_name,
>      ^
>    drivers/rtc/rtc-omap.c:555:2: warning: excess elements in struct initializer
>    drivers/rtc/rtc-omap.c:555:2: warning: (near initialization for 'rtc_pinctrl_ops')
>>> drivers/rtc/rtc-omap.c:556:2: error: unknown field 'dt_node_to_map' specified in initializer
>      .dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
>      ^
>    drivers/rtc/rtc-omap.c:556:2: warning: excess elements in struct initializer
>    drivers/rtc/rtc-omap.c:556:2: warning: (near initialization for 'rtc_pinctrl_ops')
>>> drivers/rtc/rtc-omap.c:557:2: error: unknown field 'dt_free_map' specified in initializer
>      .dt_free_map = pinconf_generic_dt_free_map,
>      ^
>    drivers/rtc/rtc-omap.c:557:2: warning: excess elements in struct initializer
>    drivers/rtc/rtc-omap.c:557:2: warning: (near initialization for 'rtc_pinctrl_ops')
>    drivers/rtc/rtc-omap.c: In function 'rtc_pinconf_get':
>>> drivers/rtc/rtc-omap.c:577:9: error: implicit declaration of function 'pinctrl_dev_get_drvdata' [-Werror=implicit-function-declaration]
>      struct omap_rtc *rtc = pinctrl_dev_get_drvdata(pctldev);
>             ^
>>> drivers/rtc/rtc-omap.c:577:25: warning: initialization makes pointer from integer without a cast
>      struct omap_rtc *rtc = pinctrl_dev_get_drvdata(pctldev);
>                             ^
>    drivers/rtc/rtc-omap.c: In function 'rtc_pinconf_set':
>    drivers/rtc/rtc-omap.c:608:25: warning: initialization makes pointer from integer without a cast
>      struct omap_rtc *rtc = pinctrl_dev_get_drvdata(pctldev);
>                             ^
>    drivers/rtc/rtc-omap.c: At top level:
>>> drivers/rtc/rtc-omap.c:649:21: error: variable 'rtc_pinconf_ops' has initializer but incomplete type
>     static const struct pinconf_ops rtc_pinconf_ops = {
>                         ^
>>> drivers/rtc/rtc-omap.c:650:2: error: unknown field 'is_generic' specified in initializer
>      .is_generic = true,
>      ^
>    drivers/rtc/rtc-omap.c:650:2: warning: excess elements in struct initializer
>    drivers/rtc/rtc-omap.c:650:2: warning: (near initialization for 'rtc_pinconf_ops')
>>> drivers/rtc/rtc-omap.c:651:2: error: unknown field 'pin_config_get' specified in initializer
>      .pin_config_get = rtc_pinconf_get,
>      ^
>    drivers/rtc/rtc-omap.c:651:2: warning: excess elements in struct initializer
>    drivers/rtc/rtc-omap.c:651:2: warning: (near initialization for 'rtc_pinconf_ops')
>>> drivers/rtc/rtc-omap.c:652:2: error: unknown field 'pin_config_set' specified in initializer
>      .pin_config_set = rtc_pinconf_set,
>      ^
>    drivers/rtc/rtc-omap.c:652:2: warning: excess elements in struct initializer
>    drivers/rtc/rtc-omap.c:652:2: warning: (near initialization for 'rtc_pinconf_ops')
>>> drivers/rtc/rtc-omap.c:655:15: error: variable 'rtc_pinctrl_desc' has initializer but incomplete type
>     static struct pinctrl_desc rtc_pinctrl_desc = {
>                   ^
>>> drivers/rtc/rtc-omap.c:656:2: error: unknown field 'pins' specified in initializer
>      .pins = rtc_pins_desc,
>      ^
>    drivers/rtc/rtc-omap.c:656:2: warning: excess elements in struct initializer
>    drivers/rtc/rtc-omap.c:656:2: warning: (near initialization for 'rtc_pinctrl_desc')
>>> drivers/rtc/rtc-omap.c:657:2: error: unknown field 'npins' specified in initializer
>      .npins = ARRAY_SIZE(rtc_pins_desc),
>      ^
>    In file included from include/linux/debug_locks.h:6:0,
>                     from include/linux/mutex-debug.h:6,
>                     from include/linux/mutex.h:82,
>                     from include/linux/notifier.h:13,
>                     from include/linux/clk.h:17,
>                     from drivers/rtc/rtc-omap.c:18:
>    include/linux/bug.h:34:45: error: bit-field '<anonymous>' width not an integer constant
>     #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
>                                                 ^
>    include/linux/compiler-gcc.h:64:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>     #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>                                ^
>    include/linux/kernel.h:53:59: note: in expansion of macro '__must_be_array'
>     #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>                                                               ^
>>> drivers/rtc/rtc-omap.c:657:11: note: in expansion of macro 'ARRAY_SIZE'
>      .npins = ARRAY_SIZE(rtc_pins_desc),
>               ^
>    include/linux/bug.h:34:45: warning: excess elements in struct initializer
>     #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
>                                                 ^
>    include/linux/compiler-gcc.h:64:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>     #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>                                ^
>    include/linux/kernel.h:53:59: note: in expansion of macro '__must_be_array'
>     #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>                                                               ^
>>> drivers/rtc/rtc-omap.c:657:11: note: in expansion of macro 'ARRAY_SIZE'
>      .npins = ARRAY_SIZE(rtc_pins_desc),
>               ^
>    include/linux/bug.h:34:45: warning: (near initialization for 'rtc_pinctrl_desc')
>     #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
>                                                 ^
>    include/linux/compiler-gcc.h:64:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>     #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>                                ^
>    include/linux/kernel.h:53:59: note: in expansion of macro '__must_be_array'
>     #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>                                                               ^
>>> drivers/rtc/rtc-omap.c:657:11: note: in expansion of macro 'ARRAY_SIZE'
>      .npins = ARRAY_SIZE(rtc_pins_desc),
>               ^
>
> vim +535 drivers/rtc/rtc-omap.c
>
>    529		}, {
>    530			/* sentinel */
>    531		}
>    532	};
>    533	MODULE_DEVICE_TABLE(of, omap_rtc_of_match);
>    534	
>  > 535	static const struct pinctrl_pin_desc rtc_pins_desc[] = {
>  > 536		PINCTRL_PIN(0, "ext_wakeup0"),
>    537		PINCTRL_PIN(1, "ext_wakeup1"),
>    538		PINCTRL_PIN(2, "ext_wakeup2"),
>    539		PINCTRL_PIN(3, "ext_wakeup3"),
>    540	};
>    541	
>    542	static int rtc_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
>    543	{
>    544		return 0;
>    545	}
>    546	
>    547	static const char *rtc_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
>    548						unsigned int group)
>    549	{
>    550		return NULL;
>    551	}
>    552	
>  > 553	static const struct pinctrl_ops rtc_pinctrl_ops = {
>  > 554		.get_groups_count = rtc_pinctrl_get_groups_count,
>  > 555		.get_group_name = rtc_pinctrl_get_group_name,
>  > 556		.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
>  > 557		.dt_free_map = pinconf_generic_dt_free_map,
>    558	};
>    559	
>    560	enum rtc_pin_config_param {
>    561		PIN_CONFIG_ACTIVE_HIGH = PIN_CONFIG_END + 1,
>    562	};
>    563	
>    564	static const struct pinconf_generic_params rtc_params[] = {
>    565		{"ti,active-high", PIN_CONFIG_ACTIVE_HIGH, 0},
>    566	};
>    567	
>    568	#ifdef CONFIG_DEBUG_FS
>    569	static const struct pin_config_item rtc_conf_items[ARRAY_SIZE(rtc_params)] = {
>    570		PCONFDUMP(PIN_CONFIG_ACTIVE_HIGH, "input active high", NULL, false),
>    571	};
>    572	#endif
>    573	
>    574	static int rtc_pinconf_get(struct pinctrl_dev *pctldev,
>    575				unsigned int pin, unsigned long *config)
>    576	{
>  > 577		struct omap_rtc *rtc = pinctrl_dev_get_drvdata(pctldev);
>    578		unsigned int param = pinconf_to_config_param(*config);
>    579		u32 val;
>    580		u16 arg = 0;
>    581	
>    582		rtc->type->unlock(rtc);
>    583		val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>    584		rtc->type->lock(rtc);
>    585	
>    586		switch (param) {
>    587		case PIN_CONFIG_INPUT_ENABLE:
>    588			if (!(val & OMAP_RTC_PMIC_EXT_WKUP_EN(pin)))
>    589				return -EINVAL;
>    590			break;
>    591		case PIN_CONFIG_ACTIVE_HIGH:
>    592			if (val & OMAP_RTC_PMIC_EXT_WKUP_POL(pin))
>    593				return -EINVAL;
>    594			break;
>    595		default:
>    596			return -ENOTSUPP;
>    597		};
>    598	
>    599		*config = pinconf_to_config_packed(param, arg);
>    600	
>    601		return 0;
>    602	}
>    603	
>    604	static int rtc_pinconf_set(struct pinctrl_dev *pctldev,
>    605				unsigned int pin, unsigned long *configs,
>    606				unsigned int num_configs)
>    607	{
>  > 608		struct omap_rtc *rtc = pinctrl_dev_get_drvdata(pctldev);
>    609		u32 val;
>    610		unsigned int param;
>    611		u16 param_val;
>    612		int i;
>    613	
>    614		rtc->type->unlock(rtc);
>    615		val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>    616		rtc->type->lock(rtc);
>    617	
>    618		/* active low by default */
>    619		val |= OMAP_RTC_PMIC_EXT_WKUP_POL(pin);
>    620	
>    621		for (i = 0; i < num_configs; i++) {
>    622			param = pinconf_to_config_param(configs[i]);
>    623			param_val = pinconf_to_config_argument(configs[i]);
>    624	
>    625			switch (param) {
>    626			case PIN_CONFIG_INPUT_ENABLE:
>    627				if (param_val)
>    628					val |= OMAP_RTC_PMIC_EXT_WKUP_EN(pin);
>    629				else
>    630					val &= ~OMAP_RTC_PMIC_EXT_WKUP_EN(pin);
>    631				break;
>    632			case PIN_CONFIG_ACTIVE_HIGH:
>    633				val &= ~OMAP_RTC_PMIC_EXT_WKUP_POL(pin);
>    634				break;
>    635			default:
>    636				dev_err(&rtc->rtc->dev, "Property %u not supported\n",
>    637					param);
>    638				return -ENOTSUPP;
>    639			}
>    640		}
>    641	
>    642		rtc->type->unlock(rtc);
>    643		rtc_writel(rtc, OMAP_RTC_PMIC_REG, val);
>    644		rtc->type->lock(rtc);
>    645	
>    646		return 0;
>    647	}
>    648	
>  > 649	static const struct pinconf_ops rtc_pinconf_ops = {
>  > 650		.is_generic = true,
>  > 651		.pin_config_get = rtc_pinconf_get,
>  > 652		.pin_config_set = rtc_pinconf_set,
>    653	};
>    654	
>  > 655	static struct pinctrl_desc rtc_pinctrl_desc = {
>  > 656		.pins = rtc_pins_desc,
>  > 657		.npins = ARRAY_SIZE(rtc_pins_desc),
>  > 658		.pctlops = &rtc_pinctrl_ops,
>  > 659		.confops = &rtc_pinconf_ops,
>  > 660		.custom_params = rtc_params,
>  > 661		.num_custom_params = ARRAY_SIZE(rtc_params),
>    662	#ifdef CONFIG_DEBUG_FS
>  > 663		.custom_conf_items = rtc_conf_items,
>    664	#endif
>  > 665		.owner = THIS_MODULE,
>    666	};
>    667	
>    668	static int omap_rtc_probe(struct platform_device *pdev)
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>

-- 
Marcin Niestroj

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
