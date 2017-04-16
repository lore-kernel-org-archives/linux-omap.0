From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap deferred probe regression fix
Date: Sun, 16 Apr 2017 11:54:27 -0700
Message-ID: <20170416185427.GA6930@localhost>
References: <58ebbb9c.8cde540a.c8344.2677SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <58ebbb9c.8cde540a.c8344.2677SMTPIN_ADDED_BROKEN@mx.google.com>
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

On Mon, Apr 10, 2017 at 10:06:27AM -0700, Tony Lindgren wrote:
> The following changes since commit 351b7c490700747d1dba1b0a10fbfe3448d11c35:
> 
>   ARM: omap2+: Revert omap-smp.c changes resetting CPU1 during boot (2017-03-27 10:10:42 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/fixes-rc6-signed
> 
> for you to fetch changes up to 04abaf07f6d5cdf22b7a478a86e706dfeeeef960:
> 
>   ARM: OMAP2+: omap_device: Sync omap_device and pm_runtime after probe defer (2017-04-04 08:49:56 -0700)
> 
> ----------------------------------------------------------------
> Regression fix for omap interconnect code for deferred probe.
> Without this fix we can get PM related warnings for devices that
> use deferred probe. If necessary, this fix can wait for the
> v4.12 merge window no problem.
> 
> ----------------------------------------------------------------
> Dave Gerlach (1):
>       ARM: OMAP2+: omap_device: Sync omap_device and pm_runtime after probe defer

Hmm, looks like there was a handful of other fixes as a base on this branch
that we hadn't yet merged. Done so now, since they came in with this.


-Olof
