From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes against v4.4-rc4
Date: Thu, 10 Dec 2015 15:50:05 -0800
Message-ID: <20151210235004.GJ23396@atomide.com>
References: <20151210233907.GI23396@atomide.com> <1892295.pQZqt1gEpo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1892295.pQZqt1gEpo@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [151210 15:46]:
> On Thursday 10 December 2015 15:39:08 Tony Lindgren wrote:
> > Few fixes for omaps for v4.4-rc cycle:
> > 
> > - Fix clock source for ARM TWD and global timers on am437x
> > 
> > - Always select REGULATOR_FIXED_VOLTAGE for omap2+ instead of
> >   when MACH_OMAP3_PANDORA is selected
> > 
> > - Fix SPI DMA handles for dm816x as only some were mapped
> > 
> > - Fix up mbox cells for dm816x to make mailbox usable
> > 
> 
> Just when I had finished pulling in all other fixes and was about
> to go to bed.

Oops sorry I should have sent this earlier today!

> Pulled into fixes, too.

Thanks & good night,

Tony
