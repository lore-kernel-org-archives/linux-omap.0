From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: I2C: prepare to use hwmod reset in driver
Date: Fri, 16 Dec 2011 11:50:02 -0800
Message-ID: <20111216195002.GL32251@atomide.com>
References: <alpine.DEB.2.00.1112160254320.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1112160254320.12660@utopia.booyaka.com>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Paul Walmsley <paul@pwsan.com> [111216 01:24]:
> Hi Tony
> 
> The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:
> 
>   Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 i2c_reset_devel_3.3
> 
> Shubhrajyoti D (2):
>       ARM: OMAP: omap_device: add omap_device_reset to reset all the hwmods in the device
>       ARM: OMAP: I2C: Reset support
> 
>  arch/arm/plat-omap/i2c.c                      |    2 ++
>  arch/arm/plat-omap/include/plat/omap_device.h |    1 +
>  arch/arm/plat-omap/omap_device.c              |   22 ++++++++++++++++++++++
>  include/linux/i2c-omap.h                      |    1 +
>  4 files changed, 26 insertions(+), 0 deletions(-)

Can you please update shi to leave out the extra callback
function int (*device_reset) (struct device *dev) as I'd
rather see that happen with pm_runtime calls?

Regards,

Tony
