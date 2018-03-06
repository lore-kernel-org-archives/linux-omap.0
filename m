From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Regulator regression in next-20180305
Date: Tue, 6 Mar 2018 19:10:01 -0300
Message-ID: <CAOMZO5BPyY3WUYUhV76HGdb_NbCv9riFdtEFaku2k4dd9-A_FQ@mail.gmail.com>
References: <20180305231246.GB5799@atomide.com> <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk> <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
 <20180306191218.GF13586@sirena.org.uk> <CAOMZO5BfEfXN6OgxXswm8qFDbxDJKdUJmhDZGr_DBOh8fbtodA@mail.gmail.com>
 <20180306213350.GH13586@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180306213350.GH13586@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Maciej Purski <m.purski@samsung.com>, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 6, 2018 at 6:33 PM, Mark Brown <broonie@kernel.org> wrote:

> No, unfortunately, apart from the generic kernel ones (like lockdep).
> I'll try to have a poke at adding some tomorrow, though I'm also
> considering just dropping the series for now.

Ok, lockdep is already enabled by default in the defconfig I am using
(imx_v6_v7_defconfig).

Yesterday I spent a few hours trying to understand this locking issue,
but didn't get any success on this task.

Thanks
