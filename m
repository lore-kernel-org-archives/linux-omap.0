From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] fixes for omaps for v5.4 merge window
Date: Sun, 29 Sep 2019 10:49:39 -0700
Message-ID: <20190929174939.5sgz6klvqzfcalkp@localhost>
References: <pull-1568819401-72461@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1568819401-72461@atomide.com>
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
Cc: soc@kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 18, 2019 at 08:10:24AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 4a65bbb9109ed7edd4b6ed7168ced48abb8561a2:
> 
>   soc: ti: pm33xx: Make two symbols static (2019-08-13 05:05:38 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-5.4-merge-window
> 
> for you to fetch changes up to a4c8723a162e6244fb01944fbf446750575dba59:
> 
>   bus: ti-sysc: Remove unpaired sysc_clkdm_deny_idle() (2019-09-06 12:57:46 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omap variants
> 
> Few fixes for ti-sysc interconnect target module driver for no-idle
> quirks that caused nfsroot to fail on some dra7 boards.
> 
> And let's fixes to get LCD working again for logicpd board that got
> broken a while back with removal of panel-dpi driver. We need to now
> use generic CONFIG_DRM_PANEL_SIMPLE instead.

Thanks, merged.


-Olof
