From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 3/6] am335x and am437x pm for v4.17
Date: Wed, 7 Mar 2018 16:26:02 +0100
Message-ID: <CAK8P3a3rY8n9893zng4soUee+kp1o3UVZyt2MUE242FMnk2SMw@mail.gmail.com>
References: <pull-1520273005-304551@atomide.com>
 <pull-1520273005-304551@atomide.com-3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1520273005-304551@atomide.com-3>
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
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/am-pm-signed
>
> for you to fetch changes up to afe761f8d3e99155b76833421e76553a3ac69577:
>
>   soc: ti: Add pm33xx driver for basic suspend support (2018-02-27 08:53:46 -0800)
>
> ----------------------------------------------------------------
> Add am335x and am437x PM code for v4.17
>
> This series of changes from Dave Gerlach adds the PM related
> code to allow low-power suspend states. The code consists of
> the SoC specific assembly code and a related PM driver.

Pulled into next/soc, thanks!

        Arnd
