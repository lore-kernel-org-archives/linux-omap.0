From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 5/5] omap defconfig changes for v4.11 merge window
Date: Sun, 29 Jan 2017 17:18:41 -0800
Message-ID: <20170130011841.GZ3133@localhost>
References: <pull-1485274191-192300>
 <58879776.0ada620a.ff7f0.43b9SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <58879776.0ada620a.ff7f0.43b9SMTPIN_ADDED_BROKEN@mx.google.com>
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 24, 2017 at 10:05:18AM -0800, Tony Lindgren wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/defconfig-signed
> 
> for you to fetch changes up to ac57feb25833a6f3832a436d28808ffc16c672b3:
> 
>   ARM: omap2plus_defconfig: Enable support for RTC M41T80 (2017-01-24 07:04:11 -0800)
> 
> ----------------------------------------------------------------
> Few omap2plus_defconfig changes for v4.11 merge window:
> 
> - Switch to use LIS3LV02DL IIO driver instead of the
>   LIS3LC02D misc driver
> 
> - Set CONFIG_SERIAL_8250_RUNTIME_UARTS=6 to avoid runtime
>   warnings on omap5 and dra7
> 
> - Enable ksz9021 phy and m41t80 rtc as they are used at
>   least on phyCORE-AM335x

Merged, thanks.


-Olof
