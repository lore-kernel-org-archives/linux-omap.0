From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Regression with arm in next with stack protector
Date: Fri, 23 Mar 2018 15:45:27 -0300
Message-ID: <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
References: <20180323181452.GJ5799@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323181452.GJ5799@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Huacai Chen <chenhc@lemote.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Rich Felker <dalias@libc.org>, Russell King <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kernel <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-omap@vger.kernel.org, James Hogan <james.hogan@mips.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 23, 2018 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> Looks like commit 5638790dadae ("zboot: fix stack protector in
> compressed boot phase") breaks booting on arm.

Yes, almost all imx are broken in linux-next due to this commit:
https://kernelci.org/soc/imx/job/next/kernel/next-20180323/
