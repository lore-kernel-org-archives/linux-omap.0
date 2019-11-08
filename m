From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: Enable addition power management
Date: Fri, 8 Nov 2019 13:03:04 -0800
Message-ID: <20191108210304.GQ5610@atomide.com>
References: <20191108200501.29864-1-aford173@gmail.com>
 <20191108204531.GN5610@atomide.com>
 <20191108205050.GO5610@atomide.com>
 <CAHCN7xLVWf252Q44vtdBemNF8WXLZ61mfBO9Oc+WFGgVj60cFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xLVWf252Q44vtdBemNF8WXLZ61mfBO9Oc+WFGgVj60cFg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Adam Ford <adam.ford@logicpd.com>, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [191108 20:58]:
> On Fri, Nov 8, 2019 at 2:50 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Tony Lindgren <tony@atomide.com> [191108 20:46]:
> > > Also, you may want to check if the driver needs to
> > > save and restore it's context in the notifier as that
> > > might get lost during the off mode depending what
> > > domain it's at.
> >
> > Oh never mind, looks like you already took care of
> > saving and restoring the context in the notifier,
> > I just missed it.
> 
> Great!
> 
> Is there any testing you can do and think we need on the OMAP4/5+ or
> am33xx?  I don't have any of that hardware.

I can test oswr idle (open switch retention) on droid4
which means save and restore of context is needed like
it is for off mode.

> I'm readying a patch without the RFC shortly.

OK will give it a try and reply when done.

Regards,

Tony
