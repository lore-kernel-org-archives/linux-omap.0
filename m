From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: second set of hwmod changes for v4.6
Date: Tue, 1 Mar 2016 10:00:47 -0800
Message-ID: <20160301180046.GY13417@atomide.com>
References: <alpine.DEB.2.02.1603010958120.14948@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1603010958120.14948@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [160301 01:59]:
> Hi Tony
> 
> The following changes since commit 8fe097a3d99e22355fb8e3bcee59542bf3f46b2d:
> 
>   ARM: DRA7: hwmod: Add reset data for PCIe (2016-02-09 02:18:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.6/omap-hwmod-b
> 
> for you to fetch changes up to 34b4182ce5fd284bff38764f8e73e2160b49d8e9:
> 
>   ARM: DRA7: hwmod: Add data for eDMA tpcc, tptc0, tptc1 (2016-03-01 01:55:59 -0700)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: second set of hwmod changes for v4.6
> 
> These patches add RTC support for the AM43xx, and add support for
> the DRA7xx eDMA controller's TPCC, TPTC0, and TPTC1 IP blocks.
> Also included is a workaround for PRCM hardreset control of the DRA7xx
> PCIe subsystem.
> 
> Note that I do not have a DRA7xx board, and therefore cannot
> test any patches for that SoC family.
> 
> Basic build, boot, and PM test logs can be found here:
> 
> http://www.pwsan.com/omap/testlogs/omap-hwmod-b-for-v4.6/20160301021258/

Thanks pulling into omap-for-v4.6/soc.

Regards,

Tony
