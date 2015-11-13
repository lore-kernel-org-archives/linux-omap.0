From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [BISECTED] v4.3-rc5: OMAP1 boot hang
Date: Fri, 13 Nov 2015 00:57:22 +0000
Message-ID: <20151113005722.GQ32536@n2100.arm.linux.org.uk>
References: <20151013073046.GB7588@blackmetal.musicnaut.iki.fi>
 <20151111214444.GF2260@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151111214444.GF2260@blackmetal.musicnaut.iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 11, 2015 at 11:44:44PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> Any suggestions how to debug this further? This happens also with v4.3
> final. Is the CPU_SW_DOMAIN_PAN supposed to work with this CPU?
> 
> I tried to disable various drivers (e.g. NAND, USB) and it still
> hangs... And it seems always at the same printk time stamp (roughly at
> 25 seconds).

No idea what so ever, and I have zero knowledge of this ARM925 thing -
never had one, and never seen any specs on it.  The weird thing is
that it's not producing any oops dump - I guess the kernel is totally
dead and unresponsive.  I'd ask if you have a heartbeat LED, but I'd
guess the answer will be that the hardware is too limited.

Any additional information you can give might help, but I wouldn't hold
out any hopes...

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
