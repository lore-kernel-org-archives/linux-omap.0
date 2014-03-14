From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv4 4/7] hwspinlock/core: add common OF helpers
Date: Fri, 14 Mar 2014 15:12:26 +0200
Message-ID: <CAK=WgbYS+eJSTBXF=OeWjuL6iSbH+Y1RYewARKh9yAXHKKZ_cA@mail.gmail.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-5-git-send-email-s-anna@ti.com> <CAJAp7Oi7wD+VsMAd37gT04yZ4TH4ygXFmheDhvmWuanUjpBmVQ@mail.gmail.com>
 <52F92524.3080402@ti.com> <CAK=WgbY0wDtGCm71E8VXi2g5+VcGogHEy8jdekTRg8xtp6-3rQ@mail.gmail.com>
 <CAJAp7Ohf43hbKatCwS5Y1+OfEkJYWOkuhZhW-E_=t_9mfM+UaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJAp7Ohf43hbKatCwS5Y1+OfEkJYWOkuhZhW-E_=t_9mfM+UaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn@kryo.se>
Cc: Suman Anna <s-anna@ti.com>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Kumar Gala <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

On Sun, Mar 2, 2014 at 10:19 PM, Bjorn Andersson <bjorn@kryo.se> wrote:
> When introducing the ability to reference a hwspin lock via a phandle
> in device tree it makes a big difference to be able to differ between
> the case of "initialization failed" or "device not yet probed"; so
> that the client knows if it should fail or retry later.

I'm not convinced.

The only advantage this brings is to avoid retrying in case a fatal
error has occurred. Such fatal errors are extremely rare, and when
they show up - extremely painful, and I suspect that optimizing them
wouldn't be a big win.

OTOH, keeping the code easier to read and less error prone is a big
win. I prefer we keep it simple for now.

Thanks,
Ohad.
