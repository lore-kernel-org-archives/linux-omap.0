From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 4/6] ti-sysc changes for v4.17
Date: Wed, 7 Mar 2018 16:27:14 +0100
Message-ID: <CAK8P3a225rS_2Y6=6As8rYkbE_6P-XTvDkFZw4tsVpuxCOXPPA@mail.gmail.com>
References: <pull-1520273005-304551@atomide.com>
 <pull-1520273005-304551@atomide.com-4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1520273005-304551@atomide.com-4>
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

On Mon, Mar 5, 2018 at 7:11 PM, Tony Lindgren <tony@atomide.com> wrote:

> ----------------------------------------------------------------
> Driver changes for ti-sysc for v4.17
>
> This series of changes enables the use device tree based sysconfig
> data for ti-sysc driver. As we already have SmartReflex data configured,
> we use that as the first driver to enable. To do that in a way where
> SmartReflex is not probed twice, we need to prepare the SmartReflex
> driver before flipping dts data on for it in the last patch of the
> series.
>
> To avoid regressions, we are checking the passed dts data against
> existing platform data since we still have it available. Then after the
> dts files are converted, we can simply drop the related platform data
> at some point in the future.

Pulled into next/soc, thanks!

        Arnd
