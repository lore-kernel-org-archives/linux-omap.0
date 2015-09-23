From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
Date: Wed, 23 Sep 2015 14:06:41 -0700
Message-ID: <20150923210641.GM23801@atomide.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-3-git-send-email-tony@atomide.com>
 <CABxcv=mGNmoVu3TDvd1888TiJ_vg0FJF6qz0p4XTu5T776sJ2Q@mail.gmail.com>
 <20150918174836.GG8020@atomide.com>
 <20150918202718.GH8020@atomide.com>
 <CABxcv=nUuqHSJmP=z3X7F=ukeaFi+9cYTYW-wRwuv+mA8Jw2HQ@mail.gmail.com>
 <20150921141018.GC23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150921141018.GC23801@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Sourav Poddar <sourav.poddar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150921 07:16]:
> * Javier Martinez Canillas <javier@dowhile0.org> [150921 02:17]:
> > > Then getting the 32k clock from palmas is not working either, it
> > > seems some better deferred probe handling is needed there if
> > > omap_hsmmc is built-in and palmas-clk is a loadable module.
> > >
> > 
> > IIUC from another email, you already solved this.
> 
> That deferred probe fix did not solve this one, need to debug further.

FYI, found the MMC pwrseq clock issue, I had a typo in my dts
file with "ext_clk" instead of "ext_clock" :)

Will send v2 of $subject patch after some more testing using
both a GPIO regulator-fixed and mmc pwrseq for the clock.

Regards,

Tony
