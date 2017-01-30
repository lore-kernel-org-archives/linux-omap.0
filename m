From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 3/5] omap wkup_m3_ipc driver changes for v4.11 merge
 window
Date: Sun, 29 Jan 2017 17:16:26 -0800
Message-ID: <20170130011626.GX3133@localhost>
References: <pull-1485274191-192300>
 <58879775.06c9620a.ef45c.5d29SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <58879775.06c9620a.ef45c.5d29SMTPIN_ADDED_BROKEN@mx.google.com>
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

On Tue, Jan 24, 2017 at 10:05:16AM -0800, Tony Lindgren wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/drivers-signed
> 
> for you to fetch changes up to 36cc9fd9ce0fd0e4654890aa347d258616aef5fa:
> 
>   soc: ti: wkup_m3_ipc: Drop wait from wkup_m3_rproc_boot_thread (2017-01-06 08:37:39 -0800)
> 
> ----------------------------------------------------------------
> Just a single wkup_m3_ipc clean-up for v4.11 merge window.
> We don't currently have anything else for drivers/soc to
> merge, but I'd expect that to change as soon as we can start
> moving PM code into drivers with the recently posted SRAM
> changes. Anyways, sent as a separate pull request to make
> it easy to group the ARM SoC pull requests.
> 
> ----------------------------------------------------------------
> Sarangdhar Joshi (1):
>       soc: ti: wkup_m3_ipc: Drop wait from wkup_m3_rproc_boot_thread
> 
>  drivers/soc/ti/wkup_m3_ipc.c | 2 --
>  1 file changed, 2 deletions(-)

Merged, thanks!


-Olof
