From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract regulator_init_data
Date: Mon, 17 Oct 2011 09:47:17 +0530
Message-ID: <4E9BAC4D.3010402@ti.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com> <1318263578-7407-4-git-send-email-rnayak@ti.com> <20111016145536.GA29885@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111016145536.GA29885@S2100-06.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


> I do not see that of_get_regulation_constraints() covers the following
> fields.  We do not support them for DT probe?

I left these out as I wasn't sure how such (if at all) Linux specific 
params should be passed through dt, and I am still not quite sure :(

>
> struct regulation_constraints {
>
>          char *name;
>
> 	...
>
>          /* regulator suspend states for global PMIC STANDBY/HIBERNATE */
>          struct regulator_state state_disk;
>          struct regulator_state state_mem;
>          struct regulator_state state_standby;
>          suspend_state_t initial_state; /* suspend state to set at init */
>
>          /* mode to set on startup */
>          unsigned int initial_mode;
>
>          /* constraint flags */
> 	...
>          unsigned apply_uV:1;    /* apply uV constraint if min == max */
> };
>
