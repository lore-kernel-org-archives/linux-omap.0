From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/2] dts changes for ti-sysc driver for v5.2
Date: Sun, 28 Apr 2019 12:34:25 -0700
Message-ID: <20190428193425.v2ee2qeq5kjp4pfk@localhost>
References: <pull-1555343712-332506@atomide.com>
 <pull-1555343712-332506@atomide.com-2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1555343712-332506@atomide.com-2>
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 15, 2019 at 10:00:54AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit d59b60564cbfe77d85c2f51b29941d8ed14984d1:
> 
>   bus: ti-sysc: Add generic enable/disable functions (2019-04-09 08:58:48 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/dt-ti-sysc-signed
> 
> for you to fetch changes up to b2770b2d6f1b4d33e919fc2a9ccf536efedc1e40:
> 
>   ARM: dts: Add l4 abe interconnect hierarchy and ti-sysc data for omap5 (2019-04-09 09:00:54 -0700)
> 
> ----------------------------------------------------------------
> Devicetree changes for omap4 and 5 l4 abe interconnect
> 
> This series of devicetree changes adds the l4 abe interconnect devices
> and moves the devices to their right places in the hierarchy similar
> to what we've already done for most l4 devices earlier. We first add
> a shared omap4-mcpdm.dtsi to make adding omap4-l4-abe.dtsi easier for
> the mcpdm changes. And as earlier, in case of unexpected trouble,
> devices can be probed the old way by moving one device at a time to the
> old place.
> 
> This series of changes depends on the ti-sysc driver changes for handling
> the external optional clocks that the mcpdm relies on, and is based on
> the related ti-sysc driver changes. Note that this series does not depend
> on dropping of the leagcy platform data, but I already had those committed
> along with the ti-sysc driver changes and noticed too late.

Merged, thanks!


-Olof
