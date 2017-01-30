From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/5] omap soc changes for v4.11 merge window
Date: Sun, 29 Jan 2017 17:15:51 -0800
Message-ID: <20170130011551.GW3133@localhost>
References: <pull-1485274191-192300>
 <58879774.9c41620a.96bae.6ba2SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <58879774.9c41620a.96bae.6ba2SMTPIN_ADDED_BROKEN@mx.google.com>
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

On Tue, Jan 24, 2017 at 10:05:15AM -0800, Tony Lindgren wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/soc-signed
> 
> for you to fetch changes up to 8c4bc910633d942b4422e8b264c39a48e230a261:
> 
>   ARM: OMAP: clock: Remove unused mpurate cmdline option (2017-01-24 07:20:02 -0800)
> 
> ----------------------------------------------------------------
> SoC changes for omaps for v4.11 merge window. This adds support
> for keeping the interconnect target module active for uart if
> earlycon is specified. And we're adding Aaro Koskinen as a
> co-maintainer for omap1 to make sure things stay working for
> omap1. The other changes are mostly clean-up of old legacy code:
> 
> - Remove unused omap_display_init()
> 
> - Make omapdss_find_dss_of_node() function static
> 
> - Add support for earlycon
> 
> - Tidy up omap1 usb logging output with pr_cont
> 
> - Make omap_otg_init() static
> 
> - Delete redundant CPU class checks for omap1
> 
> - Remove unused mpurate cmdline option that has not done
>   anything for past 1.5 years at least
> 

Merged, thanks!


-Olof
