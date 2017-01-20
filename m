From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP5: Add HWMOD_SWSUP_SIDLE_ACT flag for UART
Date: Fri, 20 Jan 2017 10:11:10 -0800
Message-ID: <20170120181110.GB7403@atomide.com>
References: <20170118114807.9543-1-vigneshr@ti.com>
 <e84cd7c8-89bc-b2ef-e57d-6c0a37b0b51e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <e84cd7c8-89bc-b2ef-e57d-6c0a37b0b51e@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [170119 01:08]:
> 
> 
> On Wednesday 18 January 2017 05:18 PM, Vignesh R wrote:
> > According to the commit ca43ea345de9 ("ARM: OMAP2+: hwmod: Add a new
> > flag to handle SIDLE in SWSUP only in active"), UART IP needs the sidle
> > mode to be controlled in SW only while they are active. Once inactive,
> > the IP needs to be put back in HW control so they are also wakeup
> > capable. The flag HWMOD_SWSUP_SIDLE takes care of this. So add this flag
> > to all instances of UART.
> > 
> > With this change, 8250 UART now gives out proper RX Timeout interrupts
> > and is usable as console.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks yeah this fixes the issue. As this is not a regression fix, applying
into omapf-rov-4.11/fixes-not-urgent.

Regards,

Tony
