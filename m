From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/2] omap dts fixes for v4.7 merge window
Date: Fri, 3 Jun 2016 12:28:44 -0700
Message-ID: <20160603192844.GI3761@localhost>
References: <pull-1463159315-251654>
 <57360ade.0416420a.fbf40.ffffd226SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <57360ade.0416420a.fbf40.ffffd226SMTPIN_ADDED_BROKEN@mx.google.com>
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

On Fri, May 13, 2016 at 10:11:41AM -0700, Tony Lindgren wrote:
> The following changes since commit 5b6042237dc85b7e2dc26806957ebf95d205e864:
> 
>   ARM: dts: am57xx-idk: Include Industrial grade  thermal thresholds (2016-04-28 08:08:48 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7-dts-fixes1
> 
> for you to fetch changes up to a1f6ad14176d466c00e6a687f9c78ec6c7ad6bf8:
> 
>   ARM: dts: igep0020: Add SD card write-protect pin. (2016-05-12 13:52:25 -0700)
> 
> ----------------------------------------------------------------
> DTS fixes for omaps for v4.7 merge window for issues noted
> with patches in Linux next:
> 
> - Fix omap5 and am57xx-idk input voltages to fix micro-sd
>   probing at least for some omap5-uevm configurations
> 
> - Fix unhandled fault for igepv5 audio
> 
> - Fix UART wakeirqs for omap5 by removing WAKUP_EN flags,
>   those are managed by the wakeirq and can currently confuse
>   the wakeirqs as there is no handler necessarily registered
> 
> - Fix LDO7 source for igepv5
> 
> Also included are few minor changes not strictly fixes
> are good to have merged:
> 
> - Fix HP T410 boot time warnings for eMMC and disable the
>   unused MMC interfaces while at it
> 
> - Add dra7 gpmc dma channel
> 
> - Add igep00x0 SD card detect and write protect GPIOs

Looks like this raced with Arnd's pull requests. I've brought this in as fixes
now. Please send to -stable as needed yourself.


-Olof
