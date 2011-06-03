From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v2] arm: omap3: cm-t35: add support for cm-t3730
Date: Fri, 03 Jun 2011 16:37:59 +0300
Message-ID: <4DE8E3B7.5020107@compulab.co.il>
References: <4DC27317.7020206@compulab.co.il> <1304839231-11329-1-git-send-email-grinberg@compulab.co.il> <20110531130447.GK11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:33241
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754773Ab1FCNiC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 09:38:02 -0400
In-Reply-To: <20110531130447.GK11352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,


On 05/31/11 16:04, Tony Lindgren wrote:

> * Igor Grinberg <grinberg@compulab.co.il> [110508 00:17]:
>> cm-t3730 is basically the same board as cm-t35, but has DM3730 SoC
>> assembled and therefore some changes are required.
>> +static void cm_t35_mux_init(void)
>> +{
>> +	int mux_mode = OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT;
>> +
>> +	omap3_mux_init(cm_t35_common_board_mux, OMAP_PACKAGE_CUS);
>> +
>> +	if (cpu_is_omap34xx()) {
>> +		omap_mux_init_signal("gpio_70", mux_mode);
>> +		omap_mux_init_signal("gpio_71", mux_mode);
>> +		omap_mux_init_signal("gpio_72", mux_mode);
>> +		omap_mux_init_signal("gpio_73", mux_mode);
>> +		omap_mux_init_signal("gpio_74", mux_mode);
>> +		omap_mux_init_signal("gpio_75", mux_mode);
>> +	} else if (cpu_is_omap3630()) {
>> +		mux_mode = OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT;
>> +		omap_mux_init_signal("sys_boot0", mux_mode);
>> +		omap_mux_init_signal("sys_boot1", mux_mode);
>> +		omap_mux_init_signal("sys_boot3", mux_mode);
>> +		omap_mux_init_signal("sys_boot4", mux_mode);
>> +		omap_mux_init_signal("sys_boot5", mux_mode);
>> +		omap_mux_init_signal("sys_boot6", mux_mode);
>> +	}
>> +
>> +	omap_mux_init_signal("dss_data18", mux_mode);
>> +	omap_mux_init_signal("dss_data19", mux_mode);
>> +	omap_mux_init_signal("dss_data20", mux_mode);
>> +	omap_mux_init_signal("dss_data21", mux_mode);
>> +	omap_mux_init_signal("dss_data22", mux_mode);
>> +	omap_mux_init_signal("dss_data23", mux_mode);
>> +}
>> +#else
>> +static inline void cm_t35_mux_init(void) {}
>>  #endif
> Should this cpu_is_omap if else done once and then set
> some data based on it? That would be better if you need to
> use it for detection for other things later on as it will
> avoid multiple cpu_is/machine_is if else lines of code.

I'm not sure I understand what are you trying to propose here...
If you look once again on the code, there is currently only one if (cpu_is_..) {} else {}
statement currently present.
(I can remove the "if (cpu_is_omap3630())" - it indeed has no value)

Indeed, there will be some other differences...
Each time I submit a patch, I try to be as optimal as I can,
but again I'm open for suggestions...
(though I think it is optimal, e.g. 33 lines for a new running board...)

-- 
Regards,
Igor.

