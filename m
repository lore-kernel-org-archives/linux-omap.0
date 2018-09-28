From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/3] soc changes for omaps for v4.20
Date: Fri, 28 Sep 2018 17:58:21 +0200
Message-ID: <CAK8P3a09JadeSoSR+dt0=cKBcx9nmp+EYZ8AYA+02wyMiuyM-Q@mail.gmail.com>
References: <pull-1537983432-167273@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1537983432-167273@atomide.com>
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

On Wed, Sep 26, 2018 at 7:40 PM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/soc-signed
>
> for you to fetch changes up to 6e77137927639fad66e17c06b50fd319d6b59833:
>
>   ARM: OMAP2+: Convert to using %pOFn instead of device_node.name (2018-09-07 10:50:03 -0700)
>
> ----------------------------------------------------------------
> SoC changes for omap variants
>
> These changes improve support for clkctrl clocks to deal with
> split memory ranges for clkctrl providers. And to use %pOFn
> instead of device_node.name.

Pulled into next/soc, thanks!

      Arnd
