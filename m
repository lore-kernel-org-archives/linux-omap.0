From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] dts fixes for omaps for v5.0-rc cycle
Date: Wed, 30 Jan 2019 11:24:45 +0100
Message-ID: <CAK8P3a1Qra2p=3vF8Mxk8c-ya06OcJ0uO-1TCFSMDh5K=F+Ang@mail.gmail.com>
References: <pull-1548435073-725543@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1548435073-725543@atomide.com>
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

On Fri, Jan 25, 2019 at 5:52 PM Tony Lindgren <tony@atomide.com> wrote:
> Device tree fixes for omaps for v5.0-rc cycle
>
> This series of dts fixes for omap devices fixes several device specific
> regressions:
>
> - The onenand timings for n950/n9 have been wrong for a while since
>   we moved to dts based timings
>
> - A typo for the cpcap pmic is now producing erors during boot as the
>   level should be 0 for unconfigurable triggering instead of 1
>
> - Changes for ti-sysc for omap5 left uart3 with debug flags that should
>   not be set
>
> - Fix a new dtc warning started showing up for omap3-gta04 grap_port
>
> - With the generic MMC card detection code we need to fix the gpio
>   in dts for n900 and am335x-shc

Pulled into arm/fixes, thanks!

     Arnd
