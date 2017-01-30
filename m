From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/5] non-urgent omap fixes for v4.11 merge window
Date: Sun, 29 Jan 2017 17:15:00 -0800
Message-ID: <20170130011500.GV3133@localhost>
References: <58879773.4111630a.b973d.9b1cSMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <58879773.4111630a.b973d.9b1cSMTPIN_ADDED_BROKEN@mx.google.com>
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

On Tue, Jan 24, 2017 at 10:05:14AM -0800, Tony Lindgren wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/fixes-not-urgent-signed
> 
> for you to fetch changes up to 631af44c10f9430163296626c6134db16a4f51fb:
> 
>   ARM: OMAP3: Fix SoC detection of OMAP36/37 Family (2017-01-20 10:13:06 -0800)
> 
> ----------------------------------------------------------------
> Non-urgent fixes for omaps for v4.11 merge window. These all are
> fixes for things that have never worked or have been broken for
> a long time and nobody noticed:
> 
> - Fix omap3 off mode pull defines
> 
> - Allow multiple pdata quirks instead of just one
> 
> - Fix am335x and dm814x scm syscon to probe children too
> 
> - Fix compatible for ti81xx to allow use with 8250_omap as well
> 
> - Fix 8250_omap on omap5 by adding HWMOD_SWSUP_SIDLE_ACT flag
> 
> - Fix SoC detection for omap36/37 SoCs

Merged, thanks!

-Olof
