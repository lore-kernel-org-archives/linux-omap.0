From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [GIT PULL] omap1 changes for v4.21
Date: Thu, 13 Dec 2018 01:02:20 +0200
Message-ID: <20181212230220.GB5762@darkstar.musicnaut.iki.fi>
References: <pull-1544638322-89579@atomide.com>
 <20181212215917.yao2orsyr6qqagi2@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181212215917.yao2orsyr6qqagi2@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Dec 12, 2018 at 01:59:17PM -0800, Olof Johansson wrote:
> Cool, merged into next/soc now. Is the kernel about to outgrow these platforms
> due to binary size just slowly increasing over time, or is it still usable?

It's still very much usable. On currently actively tested OMAP1 boards
we have >= 32 MB RAM, and there hasn't been any issues. You might need
a custom kconfig however, depending on which board you are using.

On Nokia 770, the bootloader refuses > 2 MB kernel, so I'm using
chainloading (still with a modern kernel, but with minimized .config)
and kexec to boot a bigger kernel. But this has been going on for couple
of years already.

A.
