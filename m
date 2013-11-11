From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] omapdss: venc: Add support for bypass and acbias.
Date: Mon, 11 Nov 2013 08:54:04 -0800
Message-ID: <20131111165404.GO15154@atomide.com>
References: <1381784555-18344-1-git-send-email-marek@goldelico.com>
 <CAAfyv34j+YhEjtHyf7zg5oBoCV5ROEXow8VV0PQNHLTF5uDZJg@mail.gmail.com>
 <5280DBA6.50303@ti.com>
 <FB10035C-B13C-4A03-BE9C-0576806F2577@goldelico.com>
 <5280E617.3000004@ti.com>
 <F97741D2-FC6F-4DBD-A0DD-E35304501993@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <F97741D2-FC6F-4DBD-A0DD-E35304501993@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, NeilBrown <neilb@suse.de>, Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Dr. H. Nikolaus Schaller <hns@goldelico.com> [131111 06:30]:
> Am 11.11.2013 um 15:13 schrieb Tomi Valkeinen:
> > On 2013-11-11 15:57, Dr. H. Nikolaus Schaller wrote:
> >
> > The display.c file is not strictly DSS stuff, but DSS related "glue" for
> > the SoC. For example, the muxing of the DSI pads is also done on the
> > CONTROL module, and it's also in display.c.
> > 
> > The file is getting a bit large, so I'm not against splitting it. But I
> > don't think there's point to add omap3-tvout.c file, which most likely
> > will ever contain only that one function.
> 
> Yes that is very likely true.
> 
> The problem is that there is no other official API to modify the DEFCONF1
> register. Therefore we introduced this (propsal).
> 
> Our first idea was a readDEFCONF1() and writeDEFCONF1() and use the
> constants (bit patterns) you suggested below.

I posted something about accessing the ctrl module regs to the first
patch in the series. It's best to set it up as a separate driver for
now and then maybe handle it with pinctrl-single,bits when DSS is
device tree enabled.

Regards,

Tony
