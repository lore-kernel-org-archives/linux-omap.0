From: Arun MURTHY <arun.murthy@stericsson.com>
Subject: RE: [PATCH 3/7] leds: pwm: add a new element 'name' to platform data
Date: Tue, 28 Sep 2010 12:48:12 +0200
Message-ID: <F45880696056844FA6A73F415B568C69532DC2FC97@EXDCVYMBSTM006.EQ1STM.local>
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
 <1285670134-18063-4-git-send-email-arun.murthy@stericsson.com>
 <4CA1C6C4.20504@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CA1C6C4.20504@mvista.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>, "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>, "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-omap@vger.kernel.org

> > @@ -16,6 +16,7 @@ struct led_pwm {
> >   struct led_pwm_platform_data {
> >   	int			num_leds;
> >   	struct led_pwm	*leds;
> > +	char *name;
> >   };
> 
>     Shouldn't '*name'be aligned, at least with '*leds'?
Sure, will take care of this in the v2 patch.

Thanks and Regards,
Arun R Murthy
-------------
