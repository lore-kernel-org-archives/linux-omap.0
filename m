From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/2] omap fixes for v4.7 merge window
Date: Fri, 3 Jun 2016 12:28:53 -0700
Message-ID: <20160603192853.GJ3761@localhost>
References: <57360add.8803430a.9585b.ffffa6d9SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <57360add.8803430a.9585b.ffffa6d9SMTPIN_ADDED_BROKEN@mx.google.com>
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

On Fri, May 13, 2016 at 10:11:40AM -0700, Tony Lindgren wrote:
> The following changes since commit 7472931f7f1e9d91f761dce30107ae345b61a5c3:
> 
>   ARM: dts: omap5: fix range of permitted wakeup pinmux registers (2016-04-26 10:16:12 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7/fixes-v2
> 
> for you to fetch changes up to 65db875d110b8e517f81fa71c57a65fc6d0019ac:
> 
>   ARM: OMAP2+: AM43XX: Enable fixes for Cortex-A9 errata (2016-05-12 13:47:51 -0700)
> 
> ----------------------------------------------------------------
> Two fixes for omaps for v4.7 merge window, one to enable
> ARM errata for am437x, and the other to add ARM errtum
> workaround for dra7.
> 
> AFAIK these both can wait for v4.7, we can then request them
> for stable kernels as needed.

Merged to fixes.


-Olof
