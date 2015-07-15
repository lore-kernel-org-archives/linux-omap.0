From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes against v4.2-rc2
Date: Wed, 15 Jul 2015 10:01:05 -0400
Message-ID: <20150715140105.GA6469@localhost>
References: <20150715105053.GC17550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150715105053.GC17550@atomide.com>
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

On Wed, Jul 15, 2015 at 03:50:53AM -0700, Tony Lindgren wrote:
> The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:
> 
>   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/fixes-rc2-v2
> 
> for you to fetch changes up to 9908ac3daa3da2d236b5406b95d0865ddb8b29c4:
> 
>   ARM: dts: Correct audio input route & set mic bias for am335x-pepper (2015-07-15 03:03:01 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps, all dts changes except for one:
> 
> - Fix up LCD panel name for overo boards
> 
> - Three fixes for pepper board for regulators, freqeuncy
>   scaling and audio input. Note that there is still one
>   issue being worked on for booting with multi_v7_defconfig
> 
> - Add missing #iommu-cells for omap4 and 5
> 
> - Add missing HAVE_ARM_SCU for am43xx

Merged, thanks.


-Olof
