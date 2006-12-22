From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix ethernet IRQF_TRIGGER flag for apollon
Date: Fri, 22 Dec 2006 12:26:16 -0800
Message-ID: <20061222202616.GJ2449@atomide.com>
References: <17512019.399221166767051091.JavaMail.weblogic@ep_ml29>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <17512019.399221166767051091.JavaMail.weblogic@ep_ml29>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [061221 21:57]:
> 
> > Yeah, I believe the omap level gpios should work fine too. Kyungmin,
> > do you have some special interrupt routing for your smc91x? Or do you
> > see this only with the RT patches applied?
> 
> Yes It's problem on only RT environment.
> But I think it's safe to set IRQF_TRIGGER_RISING instead of IRQF_TRIGGER_HIGH. even though it is level-sensive.

OK, let's patch it and try to figure out later why GPIO level interrupts
don't work prorperly with RT patches.

Tony
