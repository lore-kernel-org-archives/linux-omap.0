From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: hwmod: add kernel cmdline flag to avoid resetting
	IP blocks during init
Date: Wed, 6 Jul 2011 15:01:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107061458460.4217@utopia.booyaka.com>
References: <20110703010204.19046.85186.stgit@dusk>
	<20110703010206.19046.85293.stgit@dusk>
	<20110704085503.GQ23145@atomide.com>
	<alpine.DEB.2.00.1107051936250.4217@utopia.booyaka.com>
	<alpine.DEB.2.00.1107051955450.4217@utopia.booyaka.com>
	<20110706064326.GI5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110706064326.GI5783@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>, Michael Buesch <mb@bu3sch.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 5 Jul 2011, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [110705 18:55]:
> > On Tue, 5 Jul 2011, Paul Walmsley wrote:
> > 
> > > For this case, we probably need some board file function to tell the 
> > > hwmod code to disregard a device completely, to tell the kernel to 
> > > pretend that the device does not exist.
> > 
> > ... and the other problem here is that we currently probe devices via an 
> > arch_initcall(), and the board file init_machine is also an arch_initcall.
> > Either we'll need to be very careful about Makefile ordering, or we should 
> > just call omap2_init_devices() from the board file init_machine directly.
> > The latter makes the most sense to me.
> 
> And that can then be passed the list of devices with the special flags
> for noreset, disabled and reserved. Then the late_initcall can optionally
> reset the rest of the devices.

'disabled' can probably be the default for a device that doesn't have a 
driver associated with it, once the runtime PM conversion is complete.  
That's what the late_initcall would do.  Then if a driver is dynamically 
loaded for one of those devices, the hwmod code would just re-enable it.


- Paul
