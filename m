From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/2] omap soc changes for v4.3
Date: Mon, 27 Jul 2015 14:47:38 +0200
Message-ID: <20150727124738.GI14224@localhost>
References: <55b22a40.4b226b0a.bc37c.ffffce3aSMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <55b22a40.4b226b0a.bc37c.ffffce3aSMTPIN_ADDED_BROKEN@mx.google.com>
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

On Fri, Jul 24, 2015 at 05:06:10AM -0700, Tony Lindgren wrote:
> The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:
> 
>   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/soc-signed
> 
> for you to fetch changes up to 24da741c678f865de3182194604dbddcc7fc7f3c:
> 
>   Merge branch 'dm814x-soc' into omap-for-v4.3/soc (2015-07-23 21:59:18 -0700)
> 
> ----------------------------------------------------------------
> SoC changes for omaps for v4.3 merge window:
> 
> - Clean-up omap4_local_timer_init to drop deal legacy code
> 
> - Provide proper IO map table for dra7
> 
> - Clean-up IOMMU layer init code as it now uses IOMMU framework
> 
> - A series of changes to fix up dm814x support that's been in a broken
>   half-merged state for quite some time
> 
> - A series of PRCM and hwmod changes via Paul Walmsley <paul@pwsan.com>:
> 
>   - I/O wakeup support for AM43xx
>   - register lock and unlock support to the hwmod code (needed for the RTC
>     IP blocks on some chips)
>   - several fixes for sparse warnings and an unnecessary null pointer test
>   - a DRA7xx clockdomain configuration workaround, to deal with some hardware
>     bugs

Merged, thanks!

-Olof
