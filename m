From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod: first set of patches for v3.20
Date: Wed, 21 Jan 2015 16:54:26 -0800
Message-ID: <20150122005426.GV7718@atomide.com>
References: <alpine.DEB.2.02.1501212338100.5450@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1501212338100.5450@utopia.booyaka.com>
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

* Paul Walmsley <paul@pwsan.com> [150121 15:42]:
> Hi Tony
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.20/omap-hwmod-a
> 
> for you to fetch changes up to 1c7e36bfc3e2fb2df5e2d1989a4b6fb9055a0f9b:
> 
>   ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL enabled on UART3 (2015-01-20 18:12:17 -0700)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: hwmod: first set of patches for v3.20
> 
> First set of OMAP2+ hwmod patches for Linux v3.20.  These are mostly
> fixes for warnings, although there's one DRA7xx patch that fixes
> CONFIG_DEBUG_LL for AM572x/DRA7xx SoCs that use UART3 for console,
> such as the BeagleBoard-X15.
> 
> These patches entered Linux-next starting with the next-20150121 tag.
> 
> Basic build, boot, and PM test results can be found here:
> 
> http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v3.20/20150121142621/

Thanks pulling into omap-for-v3.20/fixes-not-urgent.

Tony
