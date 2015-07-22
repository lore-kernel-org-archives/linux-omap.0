From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/3] drop few more legacy boards for v4.3
Date: Wed, 22 Jul 2015 16:26:59 -0700
Message-ID: <20150722232659.GB2909@localhost>
References: <pull-1437549432-994499>
 <55af65a1.a95c460a.3a00.6dfcSMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <55af65a1.a95c460a.3a00.6dfcSMTPIN_ADDED_BROKEN@mx.google.com>
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

On Wed, Jul 22, 2015 at 02:41:17AM -0700, Tony Lindgren wrote:
> The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:
> 
>   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/legacy-v2-signed
> 
> for you to fetch changes up to 7fcf7e061edd368fac7fe4841a7f9e54c83b3ec8:
> 
>   ARM: OMAP2+: Remove legacy booting support for Pandora (2015-07-16 04:12:32 -0700)
> 
> ----------------------------------------------------------------
> Drop more omap3 legacy board-*.c files for v4.3. This time we're
> dropping the board files for omap3logic and omap3pandora.
> 
> The reason for dropping these now rather than later is that now
> we can simply revert the patches in case of unexpected issues as
> we are not dropping any platform data at this point.
> 
> This leaves us with only the following board-*.c files:
> 
> BOARD                   REASON NEEDED
> board-ldp.c             Still used in RMKs boot test system
> board-rx51-*.c          Needs /proc/atags support for user space
> 
> Once we have the n900 legacy user space issues sorted out for
> /proc/atags and system_rev, we can drop the remaining two
> board-*.c files. And then one merge window after that we can
> drop the legacy booting support assuming no unexpected issues
> are found.

Very cool! Merged this into next/cleanup now.


-Olof
