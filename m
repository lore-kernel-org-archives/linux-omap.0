From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap-gpmc fixes for v4.8-rc1
Date: Thu, 25 Aug 2016 16:54:41 -0700
Message-ID: <20160825235441.GB6209@localhost>
References: <a4bd1d47-87b1-9ef9-d9d1-6c69be404b9e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <a4bd1d47-87b1-9ef9-d9d1-6c69be404b9e@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, arm@kernel.org, Johan Hovold <johan@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 15, 2016 at 10:53:30AM +0300, Roger Quadros wrote:
> Hi Arnd/Olof,
> 
> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
> 
>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/rogerq/linux.git tags/gpmc-omap-v4.8-rc1
> 
> for you to fetch changes up to 23540d6e2f3193b946c4de43e3f9654fa6d23fe7:
> 
>   memory: omap-gpmc: allow probe of child nodes to fail (2016-08-08 11:18:40 +0300)
> 
> ----------------------------------------------------------------
> OMAP-GPMC: fixes for v4.8-rc1
> 
> * Allow other children of GPMC to probe even if any child fails.
> This fixes problem on Overo boards where networking device child
> doesn't probe due to broken NAND child.

Merged, thanks.


-Olof
