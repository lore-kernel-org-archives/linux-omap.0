From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 3/8] ARM: OMAP: AM33xx hwmod: Add parent-child
 relationship for PWM subsystem
Date: Tue, 6 Nov 2012 10:09:11 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC049D9@DBDE01.ent.ti.com>
References: <1352106749-9437-1-git-send-email-avinashphilip@ti.com>
 <1352106749-9437-4-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352106749-9437-4-git-send-email-avinashphilip@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>, "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "AnilKumar, Chimata" <anilkumar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 05, 2012 at 14:42:24, Philip, Avinash wrote:
[...]

> +
> +static struct omap_hwmod_ocp_if am33xx_epwmss0__ecap0 = {
> +	.master		= &am33xx_epwmss0_hwmod,
> +	.slave		= &am33xx_ecap0_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.addr		= am33xx_ecap0_addr_space,
> +	.user		= OCP_USER_MPU,
> +};

Noticed this in another patch which is quite similar so commenting here
again. Is the user field required if you are just creating a parent-child
relationship here?

Regards,
Vaibhav 
