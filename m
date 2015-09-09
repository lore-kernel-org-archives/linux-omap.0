From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [GIT PULL] omap fixes for v4.3 merge window
Date: Wed, 09 Sep 2015 15:53:50 -0700
Message-ID: <7h8u8fkxvl.fsf@deeprootsystems.com>
References: <20150903004113.GX10928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150903004113.GX10928@atomide.com> (Tony Lindgren's message of
 "Wed, 2 Sep 2015 17:41:14 -0700")
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

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 2faf962d90ca4c5ee7ba026b7351b1f74500bcdf:
>
>   Merge tag 'armsoc-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2015-09-01 13:17:43 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/fixes-merge-window
>
> for you to fetch changes up to 21b430d23d233c67e6589ea5054d18392e15a28e:
>
>   ARM: omap2plus_defconfig: Enable MUSB DMA support (2015-09-01 13:59:25 -0700)
>
> ----------------------------------------------------------------
> Few omap bug fixes that have come up recently:
>
> - Fix deferred probe with omap_device idling unused devices
>
> - Fix booting if no timer parent can be set
>
> - Fix always true warning for vc register check
>
> And also two minor changes not strictly fixes:
>
> - Add SoC detection for dra752
>
> - Enable omap related MUSB DMA engines as we can now
>   build them all in finally
>
> ----------------------------------------------------------------

Queuing this into fixes branch for v4.3-rc2.

Thanks,

Kevin
