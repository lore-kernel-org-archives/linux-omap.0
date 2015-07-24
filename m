From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PRCM and hwmod changes for v4.3
Date: Thu, 23 Jul 2015 21:15:52 -0700
Message-ID: <20150724041552.GE16878@atomide.com>
References: <alpine.DEB.2.02.1507231456540.29543@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1507231456540.29543@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [150723 08:01]:
> Hi Tony,
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.3/omap-hwmod-prcm-a
> 
> for you to fetch changes up to 3b86616e3058462c340710dc7a5ac34ec8453944:
> 
>   Merge branch 'prcm-a-for-v4.3' into hwmod-prcm-for-v4.3 (2015-07-23 08:49:57 -0600)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: PRCM and hwmod changes for v4.3
> 
> This series adds:
> 
> - I/O wakeup support for AM43xx
> - register lock and unlock support to the hwmod code (needed for the RTC
>   IP blocks on some chips)
> - several fixes for sparse warnings and an unnecessary null pointer test
> - a DRA7xx clockdomain configuration workaround, to deal with some hardware
>   bugs
> 
> Basic build, boot, and PM tests are here:
> 
> http://www.pwsan.com/omap/testlogs/hwmod-prcm-for-v4.3/20150723080012/
> 
> Since I do not have an AM43xx or DRA7xx device, I can't test on those
> platforms.

Thanks pulling into omap-for-v4.3/soc.

Regards,

Tony
