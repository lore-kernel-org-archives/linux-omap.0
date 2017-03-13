From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes v4.11-rc cycle
Date: Mon, 13 Mar 2017 15:14:21 -0700
Message-ID: <20170313221421.GE13064@localhost>
References: <58bd927a.c5ae540a.8be25.bcd3SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <58bd927a.c5ae540a.8be25.bcd3SMTPIN_ADDED_BROKEN@mx.google.com>
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

On Mon, Mar 06, 2017 at 08:46:42AM -0800, Tony Lindgren wrote:
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/fixes-rc1-v2
> 
> for you to fetch changes up to e24bce8fb4c26bd0d8eca74cbbee1ad049246be3:
> 
>   Merge tag 'v4.11-rc1' into omap-for-v4.11/fixes (2017-03-06 08:37:53 -0800)
> 
> ----------------------------------------------------------------
> Fixes for omaps for v4.11-rc cycle:
> 
> - Fix smartreflex platform data regression where I accidentally
>   removed legacy platform data still in use
> 
> - Fix hypervisor mode for thumb2 kernel
> 
> - Fix misplaced tpic2810 to move it to right bus
> 
> - Enable INPUT_MOUSEDEV as a loadable module have mice working
> 
> - Fix use of gpio-key,wakeup and use wakeup-source instead as
>   this accidentally sneaked in during the merge window
> 
> - Fix error handling for onenand to properly return error
> 
> - Remove legacy gpmc-nand.c that's now dead code, this
>   also removes dependency to the MTD tree for further driver
>   changes
> 
> - Fix device node reference count errors for omap3 and
>   related to it also release device nodes after no longer
>   needed


Merged.

-Olof
