From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap device tree changes for v4.7 merge window, part 1
Date: Sun, 24 Apr 2016 23:51:11 +0200
Message-ID: <13923085.h5mVoITCv7@wuerfel>
References: <20160422223829.GO5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160422223829.GO5995@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 22 April 2016 15:38:29 Tony Lindgren wrote:
> First set of device tree changes for omaps for v4.7 merge window:
> 
> - Two sets of name and unit address check fixes for dts files.
> 
> - DMA, McASP, and timer and regulator related dts changes for dra7
> 
> - Add more devices for Nokia N9/N950
> 
> - Initial support for am335x ICEv2
> 
> - Initial support for am572x-IDK
> 
> - Pinctrl changes for am335x-baltos-ir5221
> 
> - Initial support for Amazon Kindle Fire (first generation)
> 
> - A series of changes to add GPIO controller support for the
>   GPMC driver. The driver changes will be merged separately.
> 
> - Support for am43xx clkout1
> 
> - Pinctrl and RTC changes for am335x-chili
> 
> - Add support for dra72-evm rev C (SR2.0)
> 

Pulled into next/dt, thanks!

	Arnd
