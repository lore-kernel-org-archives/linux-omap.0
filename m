From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] non-urgent fixes for omaps for v4.14
Date: Sat, 19 Aug 2017 00:08:53 +0200
Message-ID: <CAK8P3a0WDkzUwLz2ZUQdGrOX0oW+gvGgF3zyktum==OqvCmUpg@mail.gmail.com>
References: <-7291673037985203159@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <-7291673037985203159@unknownmsgid>
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 17, 2017 at 7:50 PM, Tony Lindgren <tony@atomide.com> wrote:
> Non-urgent fixes for omaps for v4.14 merge window. These all
> can wait for the merge window as we have not seemed to hit
> any of these so far:
>
> - Fix error handling in omap_ocp2scp_probe affecting runtime
>   PM error path
>
> - Drop broken RPM status update for omap_device
>
> - Two fixes for of_irq_get() usage that can return 0

Pulled into next/cleanup, thanks!

       Arnd
