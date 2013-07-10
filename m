From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [GIT PULL] remoteproc fixes
Date: Wed, 10 Jul 2013 18:29:44 +0300
Message-ID: <CAK=WgbYHzYdSsuFa0K=q8iUS3ykXy-5=XifxweCx8Uqrg-CYAg@mail.gmail.com>
References: <CAK=WgbbJesp2Yg0mXOyxzhnQxwvoNLdt7GsY5v2yN+SAc2=WZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbbJesp2Yg0mXOyxzhnQxwvoNLdt7GsY5v2yN+SAc2=WZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Suman Anna <s-anna@ti.com>, Thomas Meyer <thomas@m3y3r.de>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

With the lists this time

On Wed, Jul 10, 2013 at 6:17 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> The following changes since commit 9e895ace5d82df8929b16f58e9f515f6d54ab82d:
>
>   Linux 3.10-rc7 (2013-06-22 09:47:31 -1000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
> tags/remoteproc-3.11-fixes
>
> for you to fetch changes up to 95cee62cb4776a65229a6b6d5969be56589d95c1:
>
>   remoteproc: Cocci spatch "memdup.spatch" (2013-07-01 17:23:58 +0300)
>
> ----------------------------------------------------------------
> Trivial remoteproc fixes by Suman Anna, Wei Yongjun and Thomas Meyer.
>
> ----------------------------------------------------------------
> Suman Anna (3):
>       remoteproc: fix checkpatch errors in remoteproc code
>       remoteproc/omap: fix a sparse warning
>       remoteproc: free carveout memories only after unmapping them
>
> Thomas Meyer (1):
>       remoteproc: Cocci spatch "memdup.spatch"
>
> Wei Yongjun (1):
>       remoteproc: fix error return code in rproc_fw_boot()
>
>  drivers/remoteproc/remoteproc_core.c          | 24 ++++++++++++------------
>  drivers/remoteproc/remoteproc_debugfs.c       |  3 +--
>  drivers/remoteproc/remoteproc_internal.h      |  4 ++--
>  include/linux/platform_data/remoteproc-omap.h |  2 +-
>  4 files changed, 16 insertions(+), 17 deletions(-)
