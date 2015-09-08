From: Tony Lindgren <tony@atomide.com>
Subject: Re: mysterious crashes on OMAP5 uevm
Date: Tue, 8 Sep 2015 07:38:11 -0700
Message-ID: <20150908143810.GD4215@atomide.com>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [150908 05:50]:
> Hi,
> 
> this is a longstanding problem I'm seeing since the very beginning,
> which was around 3.12 or so (when I've first got the hardware) and it
> seems 4.2 is affected by it still. Basically what happens is Xorg
> randomly segfaults at some "impossible" location. I don't have the
> details at the moment (could get them is needed), but from what I
> examined with gdb some time ago the situation did not make any sense.
> 
> There are 2 workarounds that I know which make the problem go away
> (one is enough):
> - recompile Xorg with -marm (I'm using Debian armhf so it's thumb2 by default)
> - disable ARCH_MULTI_V6 in the kernel config
> 
> Because of the above workarounds I have forgotten about it several
> times, but it regularly comes back and bites again. It would look like
> some missing erratum workaround, but I have all of them enabled in the
> kernel.
> 
> Does anyone know about this? Perhaps some missing erratum workaround
> in the bootloader? u-boot isn't too old here (2015.07).

Seems like some incorrect handling with CONFIG_CPU_V6 compiled in.. 
Maybe try to narrow it down by commenting out some CONFIG_CPU_V6 and
__LINUX_ARM_ARCH__ = 6 ifdefs in the git grep CONFIG_CPU_V6
places ignoring uncompress and davinci code.

Do you have some easy way to reproduce this issue?

Regards,

Tony
