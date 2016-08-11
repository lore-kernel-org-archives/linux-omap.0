From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Letux-kernel] [PATCH v2] musb: omap2430: do not assume balanced
 enable()/disable()
Date: Thu, 11 Aug 2016 11:25:06 -0700
Message-ID: <20160811182506.GN28140@atomide.com>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
 <FFDA9A63-599B-44CA-B244-C8860D9E01D9@goldelico.com>
 <20160804142919.GG28140@atomide.com>
 <20160804183129.2e0cac71@aktux>
 <20160804184402.73963e8a@aktux>
 <20160805135501.GJ28140@atomide.com>
 <20160805172039.6dac0aeb@aktux>
 <20160806062134.GK28140@atomide.com>
 <20160809073559.287d0a59@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160809073559.287d0a59@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap <linux-omap@vger.kernel.org>, Bin Liu <b-liu@ti.com>
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [160808 22:36]:
> Calls to musb_platform_enable() occur at only 1 place.
> musb_platform_disable() is called at 4 places.
> 
> about balancing:
> There is musb_start() and musb_stop(). They are called from
> musb_gadget_start/stop()
> These call musb_platform_enable() and musb_platform_disable().
> Looks ok.
> 
> There is musb_suspend() and musb_resume():
> 
> musb_suspend() calls musb_platform_disable()
> musb_resume() calls musb_plaform_enable() via musb_start()
> looks balanced but why don't we use musb_stop() in musb_suspend()?

Hmm let's try adding musb_stop() to musb_suspend() too.

> Now the odd things:
> musb_platform_disable() in musb_remove() called upon module removal
> musb_platform_disable() in musb_init_controller() called from
> musb_probe()
> 
> This looks clearly unbalanced.

Sure would be nice to get those balanced. I think the only
reason why musb_platform_disable() is called is to disable
interrupts.

Care to post a patch and let's see what happens? I can now
easily test the PM with musb.

Regards,

TOny
