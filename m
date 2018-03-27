From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/3] omap dts changes for v4.17, part 2
Date: Tue, 27 Mar 2018 15:00:13 +0200
Message-ID: <CAK8P3a2GapVk1PeiyFt59hhAZV28vLYd3q-SZrVJfDhct9nKdQ@mail.gmail.com>
References: <pull-1521736966-849602@atomide.com>
 <pull-1521736966-849602@atomide.com-2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1521736966-849602@atomide.com-2>
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

On Thu, Mar 22, 2018 at 5:43 PM, Tony Lindgren <tony@atomide.com> wrote:
> Second set of dts changes for omap variants for v4.17
>
> This series of patches configures few new drivers and adds
> omap5 specific nodes:
>
> - Enable USB OTG mode for xhci on am437x
>
> - A series of changes to configure aux control module instance
>   on omap5 mostly to get the audio clocks configured
>
> - A series of changes to update droid4 for MDM6600 modem USB PHY
>   and UART1 pinctrl

Pulled into next/dt, thanks!

        Arnd
