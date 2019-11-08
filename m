From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: Enable addition power management
Date: Fri, 8 Nov 2019 14:57:36 -0600
Message-ID: <CAHCN7xLVWf252Q44vtdBemNF8WXLZ61mfBO9Oc+WFGgVj60cFg@mail.gmail.com>
References: <20191108200501.29864-1-aford173@gmail.com> <20191108204531.GN5610@atomide.com>
 <20191108205050.GO5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191108205050.GO5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Adam Ford <adam.ford@logicpd.com>, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 8, 2019 at 2:50 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Tony Lindgren <tony@atomide.com> [191108 20:46]:
> > Also, you may want to check if the driver needs to
> > save and restore it's context in the notifier as that
> > might get lost during the off mode depending what
> > domain it's at.
>
> Oh never mind, looks like you already took care of
> saving and restoring the context in the notifier,
> I just missed it.

Great!

Is there any testing you can do and think we need on the OMAP4/5+ or
am33xx?  I don't have any of that hardware.

I'm readying a patch without the RFC shortly.

adam
>
> Thanks,
>
> Tony
