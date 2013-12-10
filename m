From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] arm: omap2: Export devconf1 bypass and acbias.
Date: Tue, 10 Dec 2013 14:46:59 -0800
Message-ID: <20131210224659.GY13171@atomide.com>
References: <1381784555-18344-1-git-send-email-marek@goldelico.com>
 <1381784555-18344-2-git-send-email-marek@goldelico.com>
 <20131111164917.GN15154@atomide.com>
 <CAAfyv37LRb_Q=UZVgtKdOAz_r6_qThewAU90W7nrqHdB5fDA_g@mail.gmail.com>
 <20131111233152.GR15154@atomide.com>
 <CAAfyv36MaVqrmQxpqDu-ciO9GNJK3pJkFZohEvd1BOLOWWEOhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAAfyv36MaVqrmQxpqDu-ciO9GNJK3pJkFZohEvd1BOLOWWEOhw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, NeilBrown <neilb@suse.de>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, LKML <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Belisko Marek <marek.belisko@gmail.com> [131210 14:13]:
> On Tue, Nov 12, 2013 at 12:31 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > It would be best to set it up as omap-ctrl.c driver under drivers
> > somewhere with few functions exported for DSS and MMC drivers.
>
> I create small dummy driver based on phy-omap-control which can be
> used but before sending patch (with more updates) I would like to get
> some feedback if my direction is correct.

Cool thanks. Yeah what you have can easily be combined with the patches
Balaji has posted to make HSMMC use drivers/mfd/syscon.c via regmap
for the SCM register access. Maybe take a look at the work in progress
patches in thread:

[PATCH v4 0/7] mmc: omap_hsmmc: pbias dt and cleanup

And also see my comments regarding using the SCM GENERAL register area
as base for the syscon.c driver. That should work for your driver too,
right? And then you can access the SYSCON1 register that way from your
consumer driver ;)

Regards,

Tony
