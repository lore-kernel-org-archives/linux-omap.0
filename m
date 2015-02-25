From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] gpio: omap: use raw locks for locking
Date: Wed, 25 Feb 2015 10:44:27 +0100
Message-ID: <54ED997B.7080403@linutronix.de>
References: <1423757436-18986-1-git-send-email-bigeasy@linutronix.de> <CABxcv=mikHw7Tp+9e+=4xbjNqKKAoN=CkszPEzKo0jBWz+wenQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CABxcv=mikHw7Tp+9e+=4xbjNqKKAoN=CkszPEzKo0jBWz+wenQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 02/16/2015 09:54 AM, Javier Martinez Canillas wrote:
> Hello Sebastian,

Hello Javier,

> Right, those are bugs regardless of PREEMPT_RT or not as you said.
> I'll add it to my TODO list, thanks for finding those.

Thanks.

> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> 
> Best regards,
> Javier

Sebastian

