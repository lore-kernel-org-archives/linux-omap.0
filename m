From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] input: Add support for the TSC2003 controller.
Date: Wed, 6 May 2009 08:45:29 +0200
Message-ID: <20090506064529.GA14326@avionic-design.de>
References: <1241006627-22811-1-git-send-email-thierry.reding@avionic-design.de> <5d5443650904290623n3712cd7dja653a139cff2cf6d@mail.gmail.com> <483a38b80904291835p51044741p9bd83d33a40031c@mail.gmail.com> <20090504113751.GA22603@avionic-design.de> <5d5443650905040503n501e3b47qc890dc4c71a85b1c@mail.gmail.com> <20090504145700.GA875@avionic-design.de> <483a38b80905052125r76358182g7ce6b890c921b655@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <483a38b80905052125r76358182g7ce6b890c921b655@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Kwangwoo Lee wrote:
[...]
> Thanks for the patch. It looks good. :)
> The code in the patch is already merged in the main kernel tree.
> 
> @@ -235,7 +245,7 @@ static irqreturn_t tsc2007_irq(int irq, void *handle)
>  	spin_lock_irqsave(&ts->lock, flags);
> 
>  	if (likely(ts->get_pendown_state())) {
> -		disable_irq(ts->irq);
> +		disable_irq_nosync(ts->irq);
>  		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_DELAY),
>  					HRTIMER_MODE_REL);
>  	}

Oh, I hadn't noticed. I diffed against 2.6.30-rc4. Do you want me to send a
new patch or will you just rip that piece out?

Thierry

