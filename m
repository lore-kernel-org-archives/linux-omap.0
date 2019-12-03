From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Dec 3 (switchdev & TI_CPSW_SWITCHDEV)
Date: Tue, 3 Dec 2019 15:43:09 -0800
Message-ID: <58aebf62-54f8-9084-147b-801ea65327bb@infradead.org>
References: <20191203155405.31404722@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203155405.31404722@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/2/19 8:54 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any material for v5.6 to your linux-next included
> trees until after v5.5-rc1 has been released.
> 
> Changes since 20191202:

I am seeing this (happens to be on i386; I doubt that it matters):
CONFIG_COMPILE_TEST=y


WARNING: unmet direct dependencies detected for NET_SWITCHDEV
  Depends on [n]: NET [=y] && INET [=n]
  Selected by [y]:
  - TI_CPSW_SWITCHDEV [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_TI [=y] && (ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST [=y])

because TI_CPSW_SWITCHDEV blindly selects NET_SWITCHDEV even though
INET is not set/enabled, while NET_SWITCHDEV depends on INET.

However, the build succeeds, including net/switchdev/*.

So why does NET_SWITCHDEV depend on INET?

It looks like TI_CPSW_SWITCHDEV should depend on INET (based on the
Kconfig rules), but in practice it doesn't seem to matter to the build.

thanks.
-- 
~Randy
