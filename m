From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 3/4] omap wakeup-m3 driver for v4.5 merge window
Date: Tue, 22 Dec 2015 14:54:20 -0800
Message-ID: <20151222225420.GJ30172@localhost>
References: <pull-1450731519-787330>
 <567869fb.0295420a.956c9.ffff92e1SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <567869fb.0295420a.956c9.ffff92e1SMTPIN_ADDED_BROKEN@mx.google.com>
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

On Mon, Dec 21, 2015 at 01:06:36PM -0800, Tony Lindgren wrote:
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/wakeup-m3
> 
> for you to fetch changes up to cdd5de500b2c90d5181ebc963826019a0a4234ba:
> 
>   soc: ti: Add wkup_m3_ipc driver (2015-12-03 07:24:29 -0800)
> 
> ----------------------------------------------------------------
> TI wakeup M3 IPC device driver for v4.5 merge window. This driver will
> eventually allow am33xx and am437x to support PM with their Cortex-M3
> power management processor.
> 
> This driver has been waiting to get merged for quite a while but has
> had dependencies to the remoteproc that are now out of the way.

Merged, thanks.


-Olof
