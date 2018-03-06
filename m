From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Regulator regression in next-20180305
Date: Tue, 6 Mar 2018 17:06:48 -0300
Message-ID: <CAOMZO5BfEfXN6OgxXswm8qFDbxDJKdUJmhDZGr_DBOh8fbtodA@mail.gmail.com>
References: <20180305231246.GB5799@atomide.com> <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk> <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
 <20180306191218.GF13586@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180306191218.GF13586@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Maciej Purski <m.purski@samsung.com>, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Tue, Mar 6, 2018 at 4:12 PM, Mark Brown <broonie@kernel.org> wrote:

> Yeah, that's what I expected.  What we really need to figure out I think
> is what exactly is taking the lock that we end up colliding with, I
> don't seem to be able to reproduce so I'm having to just go on staring
> at the code here.

Any debug options I should turn on in order to help us to understand
more on the lock issue?
