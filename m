From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCHv3] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
Date: Tue, 28 Mar 2017 12:36:57 +0100
Message-ID: <20170328113657.GL23750@n2100.armlinux.org.uk>
References: <20170314180555.23597-1-tony@atomide.com>
 <aa5d7ee3-2e54-2c6c-df5d-b5efff4b365e@ti.com>
 <20170327164308.GK10760@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170327164308.GK10760@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, "Andrew F. Davis" <afd@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 27, 2017 at 09:43:09AM -0700, Tony Lindgren wrote:
> Yes problems still remains. I think the immediate fix there is to
> disable kexec during runtime based on some criteria for your use
> case rather than BUG() though. Somehow kexec needs to know if CPU1
> reset is acceptable, then reset CPU1 before kexec.

The only acceptable way to do that is to make the decision when loading
the image(s), and refuse to load the image(s) if kexec is not possible.
(As is already done when dealing with whether we can CPU hot-unplug the
secondary CPUs.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
