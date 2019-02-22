From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] deprecate old cpsw driver phy mode for v5.1
Date: Fri, 22 Feb 2019 22:11:46 +0100
Message-ID: <CAK8P3a24M=ACfyLWfOHQ8qfen=L+xAAGb0JsPf-Q9sXmyS7APA@mail.gmail.com>
References: <pull-1550848332-146231@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1550848332-146231@atomide.com>
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
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>, "David S . Miller" <davem@davemloft.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 22, 2019 at 4:15 PM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit bae2bf97939aebd74dfd8f0b76b4902a19e63eef:
>
>   dt-bindings: net: ti: deprecate cpsw-phy-sel bindings (2019-02-20 08:14:04 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/cpsw-signed
>
> for you to fetch changes up to dba235fa70cbedf7dd64d5763299451be4b9de16:
>
>   net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver (2019-02-21 07:33:51 -0800)
>
> ----------------------------------------------------------------
> One change to deprecate old CPSW Ethernet PHY mode selection driver
>
> With the device tree changes configuring CPSW with a proper PHY driver,
> we want to deprecate the old driver to avoid new users for it.
>
> Note that this driver is based on the related dts changes.
>

I've added this to the arm/late branch, which seems to be the best
way to deal with the dependency on the DT changes. I expect that
we can send this in the second week after the merge window, together
with any fixes that have come in until then.

      Arnd
