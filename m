From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal:  Enable addition power
 management
Date: Fri, 8 Nov 2019 12:50:50 -0800
Message-ID: <20191108205050.GO5610@atomide.com>
References: <20191108200501.29864-1-aford173@gmail.com>
 <20191108204531.GN5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191108204531.GN5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, hns@goldelico.com, adam.ford@logicpd.com, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191108 20:46]:
> Also, you may want to check if the driver needs to
> save and restore it's context in the notifier as that
> might get lost during the off mode depending what
> domain it's at.

Oh never mind, looks like you already took care of
saving and restoring the context in the notifier,
I just missed it.

Thanks,

Tony
