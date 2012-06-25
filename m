From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 01/11] ARM: omap: clk: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 11:06:04 +0530
Message-ID: <4FE7F8C4.6050803@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>	<1340372890-10091-2-git-send-email-rnayak@ti.com> <CADTbHxr27_DSrF4amviGicb2_5_=eTx19YecgeAOM5SGrnvscA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54374 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176Ab2FYFg2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 01:36:28 -0400
Received: by dano14 with SMTP id o14so5502450dan.11
        for <linux-omap@vger.kernel.org>; Sun, 24 Jun 2012 22:36:27 -0700 (PDT)
In-Reply-To: <CADTbHxr27_DSrF4amviGicb2_5_=eTx19YecgeAOM5SGrnvscA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pankaj Jangra <jangra.pankaj9@gmail.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 22 June 2012 11:12 PM, Pankaj Jangra wrote:
>> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
>> >  index 5fb47a1..e5f8e48 100644
>> >  --- a/arch/arm/mach-omap2/display.c
>> >  +++ b/arch/arm/mach-omap2/display.c
>> >  @@ -471,7 +471,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
>> >
>> >          for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i>  0; i--, oc++)
>> >                  if (oc->_clk)
>> >  -                       clk_enable(oc->_clk);
>> >  +                       clk_prepare_enable(oc->_clk);
>> >
>> >          dispc_disable_outputs();
>> >
>> >  @@ -498,7 +498,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
>> >
>> >          for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i>  0; i--, oc++)
>> >                  if (oc->_clk)
>> >  -                       clk_disable(oc->_clk);
>> >  +                       clk_disable_unprepare(oc->_clk);
>> >
> Just a doubt. Isn't it the same clocks you are preparing in omap_hwmod.c ?

Yes, but different users can and should prepare and enable clocks
independently, and hence the framework does usecounting to keep track.

>
>> >          r = (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
>> >
> d>  diff --git a/arch/arm/mach-omap2/omap_hwmod.c
> b/arch/arm/mach-omap2/omap_hwmod.c
>> >  index bf86f7e..2746bce 100644
>> >  --- a/arch/arm/mach-omap2/omap_hwmod.c
>> >  +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> >  @@ -608,6 +608,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
>> >                             oh->name, oh->main_clk);
>> >                  return -EINVAL;
>> >          }
>> >  +       clk_prepare(oh->_clk);
>> >
>> >          if (!oh->_clk->clkdm)
>> >                  pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
>> >  @@ -644,6 +645,7 @@ static int _init_interface_clks(struct omap_hwmod *oh)
>> >                                     oh->name, os->clk);
>> >                          ret = -EINVAL;
>> >                  }
>> >  +               clk_prepare(os->_clk);
>> >                  os->_clk = c;
> You should do clk_prepare() after os->_clk = c statement. Otherwise
> you are operating on a uninitialized structure pointer.

yes, that was really stupid of me :(. Thanks for catching this.

>> >          }
>> >
>> >  @@ -671,6 +673,7 @@ static int _init_opt_clks(struct omap_hwmod *oh)
>> >                                     oh->name, oc->clk);
>> >                          ret = -EINVAL;
>> >                  }
>> >  +               clk_prepare(oc->_clk);
> Same here. You are preparing the uninitialized clk structure.

Thanks, will fix.

>

