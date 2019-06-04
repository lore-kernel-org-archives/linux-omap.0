From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: Running linux on qemu omap
Date: Tue, 4 Jun 2019 11:44:13 +0200
Message-ID: <20190604094413.GB15484@Red>
References: <20190520190533.GA28160@Red>
	<20190521232323.GD3621@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <20190521232323.GD3621@darkstar.musicnaut.iki.fi>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, qemu-devel@nongnu.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 22, 2019 at 02:23:23AM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, May 20, 2019 at 09:05:33PM +0200, Corentin Labbe wrote:
> > Hello
> > 
> > I am working on adding a maximum set of qemu machine on kernelCI.
> 
> That's cool.
> 
> > For OMAP, five machine exists and I fail to boot any of them.
> 
> Which machines?
> 
> > The maximum I can get with omap1_defconfig is
> > qemu-system-arm -kernel zImage -nographic -machine cheetah -append 'root=/dev/ram0 console=ttyO0'
> > Uncompressing Linux... done, booting the kernel.
> > then nothing more.
> 
> It's known that omap1_defconfig doesn't work well for QEMU or
> "multi-board" usage. Perhaps the kernel size is now just too big?
> I'm using a custom config for every OMAP1 board anyway...
> 
> > Does someone have a working config+version to share ?
> 
> I have used the below config for OMAP1 SX1 board (the only one I got
> working with QEMU). Unfortunately the functionality is quite limited,
> but it still allows to run e.g. GCC bootstrap & testsuite, that is rare
> nowadays for armv4t.
> 
> I'm using the following command line with qemu-system-arm 3.1.0:
> 
>         -M sx1 \
>         -kernel "sx1-zImage" \
>         -nographic \
>         -drive file="sx1-mmc",if=sd,format=raw \
>         -no-reboot
> 
> This should work with v5.1 kernel.
> 
> I'm also interested to run other OMAP kernels under QEMU, e.g. cheetah
> (the real device, Palm TE works OK with the current mainline), and it
> would be interesting to know why QEMU/kernel has regressed...
> 

Thanks, with your config as starting point, I was able to boot both sx1 and cheetah

So I now use the omap1_defconfig and the only trick is to disable CONFIG_CPU_DCACHE_WRITETHROUGH.
I need also to disable CONFIG_FB for cheetah to works.

Regards
