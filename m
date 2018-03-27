From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] v2 of two omap fixes for v4.16-rc cycle
Date: Tue, 27 Mar 2018 13:11:45 +0200
Message-ID: <CAK8P3a2sm_0nYBA05pf=FrHhKz_YY0uPXtL0sG2Q4K5b5y45Aw@mail.gmail.com>
References: <pull-1521736922-590596@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1521736922-590596@atomide.com>
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

On Thu, Mar 22, 2018 at 5:42 PM, Tony Lindgren <tony@atomide.com> wrote:
> Two fixes for omap variants for v4.16-rc cycle
>
> Fix insecure W+X mapping warning for SRAM for omaps that
> don't yet use drivers/misc/*sram*.c code. An earlier attempt
> at fixing this turned out to cause problems with PM on omap3,
> this version works with PM on omap3.
>
> Also fix dmtimer probe for omap16xx devices that was noticed
> with the pending dmtimer move to drivers. It seems this has
> been broken for a while and is a non-critical for booting.
> It is needed for PM on omap16xx though.
>

Pulled into fixes, thanks!

      Arnd
