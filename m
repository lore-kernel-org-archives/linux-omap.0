From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/10] omap: Move dmtimer defines to dmtimer.h
Date: Mon, 20 Jun 2011 03:17:19 -0700
Message-ID: <20110620101718.GI23145@atomide.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092334.357.3701.stgit@kaulin>
	<20110620095603.GC2082@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110620095603.GC2082@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110620 02:51]:
> On Mon, Jun 20, 2011 at 02:23:34AM -0700, Tony Lindgren wrote:
> > These will be needed when dmtimer platform init code gets split
> > for omap1 and omap2+. These will also be needed for separate
> > sys_timer init and driver init for the rest of the hardware timers
> > in the following patches. No functional changes.
> 
> If dmtimer.c is the only user of these definitions, then its quite correct
> for them to be in there.  If not, they should be in dmtimer.h in the local
> directory - they're private definitions to the .c file and so should not
> be exported outside of that .c file.

There will be more patches coming to make the rest of the dmtimer
code be just a regular device driver. These inline functions will
be used by sys_timer related code, and dmtimer device driver.

This way we can make the dmtimer a loadable module and don't need
to initialize any of that early.

Tony
