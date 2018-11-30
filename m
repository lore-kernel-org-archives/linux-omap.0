From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 4/4] defconfig changes for omaps for v4.21
Date: Fri, 30 Nov 2018 15:51:55 -0800
Message-ID: <20181130235155.bb5hmxmhmzzxlpsb@localhost>
References: <pull-1543521343-338334@atomide.com>
 <pull-1543521343-338334@atomide.com-4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1543521343-338334@atomide.com-4>
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

On Thu, Nov 29, 2018 at 11:57:43AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/defconfig-signed
> 
> for you to fetch changes up to f98d45145e6a48b91e0cae12fae7a5367486e91e:
> 
>   ARM: multi_v7_defconfig: Enable 8250-omap serial driver and use it by default (2018-11-08 08:54:40 -0800)
> 
> ----------------------------------------------------------------
> Defconfig changes for omaps for v4.21 merge window
> 
> We're finally changing omaps to use 8250_OMAP instead of SERIAL_OMAP
> for multi_v7_defconfig. This will make things much easier for distros,
> and the kernel already warns about the kernel console getting
> redirected with CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP defaulting to y.
> 
> People using /etc/inittab still need to s/ttyO/ttyS/ if using the
> out-of-box multi_v7_defconfig, and that did not seem to be an issue
> when we moved omap2plus_defconfig to use 8250_OMAP earlier.
> 
> The other change is to enable CONFIG_SND_SOC_TLV320AIC23_I2C as a
> loadable module that I forgot to send a pull request for earlier.
> 
> ----------------------------------------------------------------
> Adam Ford (1):
>       ARM: omap2plus_defconfig: Add tlv320aic23 as module
> 
> Tony Lindgren (2):
>       Merge branch 'omap-for-v4.20/defconfig' into omap-for-v4.21/defconfig
>       ARM: multi_v7_defconfig: Enable 8250-omap serial driver and use it by default

Merged, thanks!


-Olof
