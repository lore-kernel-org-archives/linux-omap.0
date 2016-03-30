From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: first hwmod fix for v4.6-rc
Date: Wed, 30 Mar 2016 10:39:02 -0700
Message-ID: <20160330173901.GV9329@atomide.com>
References: <alpine.DEB.2.02.1603290647170.20409@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1603290647170.20409@utopia.booyaka.com>
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

* Paul Walmsley <paul@pwsan.com> [160328 23:49]:
> Hi Tony
> 
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.6-rc/omap-fixes-a
> 
> for you to fetch changes up to 3ca4a238106dedc285193ee47f494a6584b6fd2f:
> 
>   ARM: OMAP2+: hwmod: Fix updating of sysconfig register (2016-03-26 23:08:55 -0600)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: first hwmod fix for v4.6-rc
> 
> Fix a longstanding bug in the hwmod code that could cause
> hardware SYSCONFIG register values to not match the kernel's
> idea of what they should be, and that could result in lower
> performance during IP block idle entry.

Pulling into omap-for-v4.6/fixes thanks.

Tony
