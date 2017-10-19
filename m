From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/2] non-urgent device tree fixes for omaps for v4.15
 merge window
Date: Fri, 20 Oct 2017 00:36:02 +0200
Message-ID: <CAK8P3a2fDBZeuQOfucMcx0_eFiyMLoT2YdqOZmzaGV8DkBvoCg@mail.gmail.com>
References: <pull-1508450284-272943@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1508450284-272943@atomide.com>
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

On Thu, Oct 19, 2017 at 11:59 PM, Tony Lindgren <tony@atomide.com> wrote:
> Non-urgent device tree fixes for omaps that can all wait for v4.15
> merge window.
>
> Turns out that we have many devices working just because we have
> the legacy platform data still around. This is mostly an issue
> for omap4, other SoCs just have minimal fixes needed.
>
> As many of the missing device tree nodes and properties are for
> devices that have no drivers in the mainline kernel, such as
> slimbus, iss, mcasp, aess, fdif and gpu, we might as well start
> using the new "ti,sysc" interconnect target module binding for
> them so we can get the devices with no child device drivers idled.
>
> This also makes it possible to drop unnecessary platform data
> in later patches.

Pulled into next/dt, thanks!

        Arnd
