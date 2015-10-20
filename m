From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: dts: Add basic support for isee igepv5
Date: Tue, 20 Oct 2015 09:01:03 -0700
Message-ID: <20151020160103.GC3078@atomide.com>
References: <1444756728-11185-1-git-send-email-tony@atomide.com>
 <1444756728-11185-3-git-send-email-tony@atomide.com>
 <CAFqH_52T8rPJp-8+Bb7Tjv-kcACU8FJGtqFWOhj02DzQ2yc7nw@mail.gmail.com>
 <20151016145707.GU10113@atomide.com>
 <CAMVEqEkoXoE1wgT8p5BNW7TAjz5Xtcvx7gXvk7rbdQXg8bXpzg@mail.gmail.com>
 <20151019145052.GB21839@atomide.com>
 <CAMVEqEmDoQvnVfQXF9QvtyjPe2RRGe1wf=6=VifGPcSOKLcnbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMVEqEmDoQvnVfQXF9QvtyjPe2RRGe1wf=6=VifGPcSOKLcnbg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pau Pajuel <ppajuel@gmail.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, Enric Balletbo Serra <eballetbo@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, =?utf-8?Q?Agust=C3=AD?= Fontquerni i Gorchs <afontquerni@iseebcn.com>, egavin@iseebcn.com, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Pau Pajuel <ppajuel@gmail.com> [151020 03:34]:
> 2015-10-19 16:50 GMT+02:00 Tony Lindgren <tony@atomide.com>:
> >
> > My guess is that you need to play with initrd_high etc, try doing something
> > like this in u-boot:
> >
> > setenv fdtaddr 80a00000
> > setenv loadaddr 80c00000
> > setenv rdaddr 81400000
> > setenv fdt_high 8c000000
> > setenv initrd_high ffffffff
>
> Setting the above environment variables works for me

OK good to hear. Applying this series into omap-for-v4.4/dt then.

Thanks,

Tony
