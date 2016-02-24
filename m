From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes against v4.5-rc5, fixes more onenand
 corruption
Date: Wed, 24 Feb 2016 00:10:14 -0800
Message-ID: <20160224081014.GG30231@localhost>
References: <20160222213427.GU13417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160222213427.GU13417@atomide.com>
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

On Mon, Feb 22, 2016 at 01:34:28PM -0800, Tony Lindgren wrote:
> The following changes since commit cf26f1137333251f3515dea31f95775b99df0fd5:
> 
>   ARM: OMAP2+: Fix omap_device for module reload on PM runtime forbid (2016-02-12 08:56:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/fixes-rc5
> 
> for you to fetch changes up to 3f315c5b850fa7aff73f50de8e316b98f611a32b:
> 
>   ARM: OMAP2+: Fix onenand initialization to avoid filesystem corruption (2016-02-22 09:24:10 -0800)
> 
> ----------------------------------------------------------------
> Two omap fixes for omaps against v4.5-rc5:
> 
> - Yet another fix for n900 onenand to avoid corruption. This time to
>   fix the issue of mounting onenand back and forth between the original
>   maemo kernel and mainline Linux kernel. And it also seems there will
>   be two more fixes coming via the MTD tree as issues were discovered
>   also in the onenand driver during testing.
> 
> - Revert tps65217 regulator clean up as it breaks MMC for am335x
>   variants. The proper way to clean this up is just to rename the
>   tps65217.dtsi file into tps65217-am335x.dtsi as a similar setup
>   is used on many am335x boards.

Thanks, merged.


-Olof
