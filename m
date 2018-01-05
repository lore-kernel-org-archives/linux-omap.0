From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/4] soc changes for omaps for v4.16, part 2
Date: Thu, 4 Jan 2018 22:59:16 -0800
Message-ID: <20180105065916.snklnojvp5tshpvl@localhost>
References: <pull-1513966338-859035@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1513966338-859035@atomide.com>
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

On Fri, Dec 22, 2017 at 10:14:24AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit fdf3632938a646c13f7407f2f8c33ff81eed9c76:
> 
>   Merge branch '4.15-rc1-clkctrl-mach-omap2' of https://github.com/t-kristo/linux-pm into omap-for-v4.16/soc (2017-12-11 07:46:40 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/soc-pt2-signed
> 
> for you to fetch changes up to 234c91d4a350835df8362f6bc968ccf052c60d58:
> 
>   ARM: OMAP2+: dra762: Register package specific hwmod (2017-12-21 07:05:15 -0800)
> 
> ----------------------------------------------------------------
> Second set of SoC changes for omaps for v4.16 merge window
> 
> We can now drop some more of legacy platform data for omap3 as
> it's been booting in device tree only mode for quite a while now.
> This clock related data is coming from device tree configured
> clocks now.
> 
> The other changes add support for detecting new dra762 SoC variant.
> 
> ----------------------------------------------------------------
> Lokesh Vutla (2):
>       ARM: OMAP2+: dra762: Add support for device package identification
>       ARM: OMAP2+: dra762: Register package specific hwmod
> 
> Tony Lindgren (1):
>       ARM: OMAP2+: Drop unused legacy data for prcm_reg_id and module_bit

Nice cleanup. Merged. It had a conflict with an earlier fixes branch, please
double-check my resolution.


-Olof
