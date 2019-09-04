From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 4/4] sgx soc glue changes for omaps for v5.4
Date: Wed, 4 Sep 2019 17:27:37 +0200
Message-ID: <CAK8P3a1s2go50eYiWQw5DCUEajy2QozKKfs4_Uo6xWUKL3eyrA@mail.gmail.com>
References: <pull-1567016893-318461@atomide.com>
 <pull-1567016893-318461@atomide.com-4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1567016893-318461@atomide.com-4>
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
Cc: SoC Team <soc@kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 28, 2019 at 8:35 PM Tony Lindgren <tony@atomide.com> wrote:
> SoC glue layer changes for SGX on omap variants for v5.4
>
> For a while we've had omap4 sgx glue layer defined in dts and probed
> with ti-sysc driver. This allows idling the sgx module for PM, and
> removes the need for custom platform glue layer code for any further
> driver changes.
>
> We first drop the unused legacy platform data for omap4 sgx. Then for
> omap5, we need add the missing clkctrl clock data so we can configure
> sgx. And we configure sgx for omap34xx, omap36xx and am3517.
>
> For am335x, we still have a dependency for rstctrl reset driver changes,
> so that will be added later on.
>
> Note that this branch is based on earlier ti-sysc branch for omap36xx
> glue layer quirk handling.

Pulled into arm/late, thanks!

        Arnd
