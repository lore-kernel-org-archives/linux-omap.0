From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes for v4.11-rc cycle
Date: Thu, 30 Mar 2017 10:37:04 +0200
Message-ID: <CAK8P3a007Hik3fLZH+Me0GcJ15VFgWZTeqn4wx+NwJgh-T3mrw@mail.gmail.com>
References: <8286423674296161545@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8286423674296161545@unknownmsgid>
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
Cc: linux-omap@vger.kernel.org, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 29, 2017 at 7:07 PM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit e24bce8fb4c26bd0d8eca74cbbee1ad049246be3:
>
>   Merge tag 'v4.11-rc1' into omap-for-v4.11/fixes (2017-03-06 08:37:53 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/fixes-rc4
>
> for you to fetch changes up to 351b7c490700747d1dba1b0a10fbfe3448d11c35:
>
>   ARM: omap2+: Revert omap-smp.c changes resetting CPU1 during boot (2017-03-27 10:10:42 -0700)
>
> ----------------------------------------------------------------
> Fixes for omaps for v4.11-rc cycle. The biggest fix is to stop doing
> unconditional reset of CPU1 as that caused a regression for cases with
> custom bootloader loaded code running on CPU1. The rest are just minor
> fixes for devices and one warning fix.

Pulled into fixes, thanks!

      Arnd
