From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/7] ARM: OMAP1: ams-delta: convert latches to
 basic_mmio_gpio
Date: Mon, 19 Dec 2011 18:13:31 -0800
Message-ID: <20111220021331.GB6464@atomide.com>
References: <cover.1324331816.git.jkrzyszt@tis.icnet.pl>
 <201112200159.36558.jkrzyszt@tis.icnet.pl>
 <20111220010446.GA6464@atomide.com>
 <201112200218.03283.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201112200218.03283.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111219 16:46]:
> On Tuesday 20 of December 2011 at 02:04:46, Tony Lindgren wrote:
> > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111219 16:28]:
> > > On Tuesday 20 of December 2011 at 01:06:00, Tony Lindgren wrote:
> > > > 
> > > > This part especially looks like it really should be just a regular
> > > > device driver under drivers/ somewhere. 
> > > 
> > > I really don't understand what kind of a driver you might mean here.
> > > 
> > > The latch_gpios[] table is initially filled with all latch1 and latch2 
> > > GPIO pins in order to register and initialize them from the board file 
> > > until they are handled by respective existing device drivers (leds, 
> > > nand, lcd, serio, serial8250, asoc) instead of those drivers accessing 
> > > the latches with those old ams_delta_latch[12]_write() functions. That 
> > > table will get almost empty after the transision process is completed, 
> > > holding only pins not used by any drivers / connected to unsued devices, 
> > > in order to initialize them from the board file for power saving 
> > > purposes. A separate driver for the purpose of initializing a few GPIO 
> > > pins seems an overkill.
> > 
> > OK maybe update the comments a bit to describe how that table will
> > mostly disappear? It's not obvious from glancing over this patch
> > series :)
> 
> To be sure, do you mean in-line comments? Or the changelog message?

Just the changelog.

Tony
