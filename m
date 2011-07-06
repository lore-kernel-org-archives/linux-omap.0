From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: hwmod: add kernel cmdline flag to avoid
	resetting IP blocks during init
Date: Tue, 5 Jul 2011 23:41:16 -0700
Message-ID: <20110706064116.GH5783@atomide.com>
References: <20110703010204.19046.85186.stgit@dusk>
	<20110703010206.19046.85293.stgit@dusk>
	<20110704085503.GQ23145@atomide.com>
	<alpine.DEB.2.00.1107051936250.4217@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107051936250.4217@utopia.booyaka.com>
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
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>, Michael Buesch <mb@bu3sch.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [110705 18:37]:
> cc'ing Aaro
> 
> On Mon, 4 Jul 2011, Tony Lindgren wrote:
> 
> > Also related is the gptimer12 on secure omaps as reported by Aaro.
> 
> This problem is actually worse.  In this case it's not just preventing 
> reset; we must prevent the kernel from using the device at all. My 
> understanding is also that it's the X-Loader or bootloader -- or more 
> broadly, secure mode code -- that actually chooses which devices are 
> protected in this way.  In other words, we can't make any automatic 
> decisions that are based on knowing that a chip is a high-security chip -- 
> it will need to be defined by the board file :-(
> 
> For this case, we probably need some board file function to tell the hwmod 
> code to disregard a device completely, to tell the kernel to pretend that 
> the device does not exist.

Yeah that should be done in a generic way. Some shared devices can also
be used by a coprocessor like the DSP instead.

So basically we want to tell the following from the board file or board
specific .dts file:

- Device is being used on the board and can be reset and configured.
  This is the usual case.

- Device is being used on the board but can't be reset. This is the
  case for booting Linux from other operating systems initially where
  you want to keep the LCD on for debug console.

- Device is not being used on the board but can be reset for decent PM.
  This is often needed in cases where the bootloader just enables all the
  clocks.

- Device is reserved by secure mode or a coprocessor. In this case
  the device can't be reset.

So I guess that makes the flags noreset, disabled and unavailable?

For the devices with no special flags we would then reset the device.

Regards,

Tony
