From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: omap2plus_defconfig broken on ARMv6
Date: Mon, 27 May 2019 23:41:35 +0300
Message-ID: <20190527204135.GA24195@darkstar.musicnaut.iki.fi>
References: <20190524220731.GB4597@t60.musicnaut.iki.fi>
 <20190527055746.GH5447@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190527055746.GH5447@atomide.com>
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
Cc: linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, May 26, 2019 at 10:57:46PM -0700, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [190524 22:07]:
> > Noticed today that booting omap2plus_defconfig on N8x0 crashes
> > early. Disabling CONFIG_SMP makes it work.
> 
> OK. It sure used to work when I last tested but that's been quite
> a while now. Any ideas which commit caused the ldrexd regression?

No idea, I tried even 3.16 and even that seems to have the same issue
if multi v6/v7 and SMP is selected.

A.
