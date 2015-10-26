From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap soc clean-up for v4.4 merge window
Date: Mon, 26 Oct 2015 14:36:59 +0900
Message-ID: <20151026053659.GC4216@localhost>
References: <20151024204209.GB892@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151024204209.GB892@atomide.com>
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

On Sat, Oct 24, 2015 at 01:42:10PM -0700, Tony Lindgren wrote:
> The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:
> 
>   Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.4/soc-clean-up
> 
> for you to fetch changes up to ef4da0c1c8f3ca3e9dcf6936bf687a32cd62f293:
> 
>   Merge tag 'for-v4.4/omap-hwmod-cleanup-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v4.4/soc (2015-10-23 18:13:38 -0700)
> 
> ----------------------------------------------------------------
> Minimal omap SoC changes for v4.4 merge window. As we've spent quite a
> bit of time sorting out regressions for v4.3 and are very late with
> these, I've kept the changes down to minimum:
> 
> - A series of timer changes from Felipe Balbi to get us closer to
>   moving the remaining timer code into drivers
> 
> - A series of hwmod clean-up changes queued by Paul Walmsley
> 
> - SoC detection clean-up to use soc_is instead of cpu_is as CPU is
>   within the SoC and is confusing naming. The rest we can now change
>   along with the other clean-up

This is arriving a bit late, but I've merged it anyway since it's cleanup.
Hopefully we won't see much regressions from it during the -rc cycle.


-Olof
