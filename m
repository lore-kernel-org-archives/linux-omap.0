From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] mmc voltage and boot issue fixes for omaps for v5.2
Date: Sun, 16 Jun 2019 13:28:08 -0700
Message-ID: <CAOesGMhF9_3Y184zAC3bdyRMemnM4CLBiOp-vcRaXQOrtf0E1A@mail.gmail.com>
References: <pull-1559115102-965591@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1559115102-965591@atomide.com>
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
Cc: linux-omap <linux-omap@vger.kernel.org>, ARM-SoC Maintainers <arm@kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 29, 2019 at 12:32 AM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
>
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/fixes-rc2
>
> for you to fetch changes up to 4ee23cd76c0ce8622976b3da0e2bc89e6d94f6d4:
>
>   Merge branch 'omap-for-v5.2/ti-sysc' into fixes (2019-05-20 08:33:03 -0700)
>
> ----------------------------------------------------------------
> Fixes for omap variants for dra7 mmc voltage and boot issues
>
> This series contains dra7 mmc voltage fixes, and fixes to the recent
> changes to probe devices with device tree data insteas of legacy
> platform data:
>
> - Two fixes for dra7 mmc that needs 1.8V mode disabled as in case of a
>   reset, the bootrom will try to access the mmc card at 3.3V potentially
>   damaging the card
>
> - Two regression fixes for am335x d_can. We must allow devices with no
>   control registers for ti-sysc interconnect target module driver for
>   at least d_can, and we remove the incorrect control registers for
>   d_can. And we must configure the osc clock for d_can as otherwise
>   register access may fail depending on the bootloader version
>
> - Four regression fixes for dra7 variant dts files to tag rtc and usb4
>   as disabled for dra71x and dra76x. These SoC variants do not have
>   these devices, and got accidentally enabled when the L4 interconnect
>   got defined in the dra7-l4.dtsi for the dra7 SoC family


Merged, thanks!


-Olof
