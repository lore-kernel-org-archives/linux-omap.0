From: Matt Porter <mporter@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc2
Date: Tue, 23 Oct 2012 09:11:53 -0400
Message-ID: <20121023131153.GE1855@beef>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
 <50857444.9080308@ti.com>
 <alpine.DEB.2.00.1210221829270.13464@utopia.booyaka.com>
 <50859505.5010306@ti.com> <20121023015346.GB1855@beef>
 <alpine.DEB.2.00.1210230311490.31118@utopia.booyaka.com>
 <20121023122436.GC1855@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20121023122436.GC1855@beef>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 23, 2012 at 08:24:36AM -0400, Matt Porter wrote:
> On Tue, Oct 23, 2012 at 03:15:44AM +0000, Paul Walmsley wrote:
> > On Mon, 22 Oct 2012, Matt Porter wrote:
> > 
> > > I've mentioned this a few times in various threads...no need to use
> > > appended DTB on a current U-Boot. Some of us are indeed booting this way
> > > with the DTB properly passed separately from the bootloader and chosen
> > > filled out by the bootloader. And yes, am335x_evm_config applies to all
> > > AM33xx TI EVMs and the BeagleBone board. There's an EEPROM onboard all
> > > that is used to determine what board is present so a single
> > > MLO/u-boot.img can be used.
> > 
> > As Kevin mentioned earlier, this is unfortunately not true for those of us 
> > with earlier BeagleBoards:
> > 
> >    http://marc.info/?l=linux-omap&m=135094296931913&w=2
> 
> Yes, we spoke about this a bit.
>  
> > Do you know what the minimum board revision is that you all are 
> > supporting in U-boot?
> 
> It's not so much a revision as it is getting the right contents in the
> EEPROM. As it's a community board, it's generally only supported over at
> beagleboard@googlegroups.com. Jason Kridner recommends posting support
> questions there (like why isn't my A2 supported in U-Boot?). If there
> isn't some solution suggested there for updating the A2 I would contact
> him directly. I have an A1 Bone here that also doesn't work with
> mainline U-Boot even after configuring the EEPROM. You can try this
> procedure if you want to write the proper contents in, an A2 may work
> but for some reason there's no available history on Bone revisions prior
> to A3. I vaguely recall a lot of chatter around the phy and so forth in
> the A1 to A2 timeframe so it's entirely possible that your A2 will work
> with just the eeprom contents programmed. Without it, it's guaranteed to
> fail as the pin muxing is tied to detecting the board this way. Also,
> you may need to change <offset>.1 in the below example to <offset>.2 for
> your eeprom i/o to work as A2 may require an address length of 2.

Ok, very quick update...no need to mess around with the eeprom. I just
received the official word on what will be supported. Since A2 is
pre-release, simply go to http://beagleboard.org/support/rma and fill
out the form to have it replaced with the current revision (A6).

This applies to *anyone* that received a pre-release A2 board.

-Matt
