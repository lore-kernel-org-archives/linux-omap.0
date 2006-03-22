From: toshihiro.kobayashi@nokia.com
Subject: Re: Problems building DSP gateway on 2.6.15
Date: Thu, 23 Mar 2006 01:44:23 +0900 (JST)
Message-ID: <20060323.014423.846936348.toshihiro.kobayashi@nokia.com>
References: <008101c64dcb$7d1cb110$642aa8c0@BUFFY> <442178FF.7060803@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <442178FF.7060803@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: richard.copeman@lauterbach.co.uk, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Problems building DSP gateway on 2.6.15
Date: Wed, 22 Mar 2006 17:19:11 +0100

> Richard Copeman wrote:
> > Toshihiro san,
> > 
> > Thanks for the pointer.
> > There is no OMAP DSP Gateway message displayed during my startup.
> > I do not do "make uImage". I use a JTAG debugger to download vmlinux
> > directly to RAM. What does "make uImage" do for me?
> 
> If you use JTAG debugger for download you don't need 'make 
> uImage'. You only need this if you use bootloader U-Boot to 
> download and start the image.

Yes, Richard-san, I've missed you'd explained you are loading the kernel
with JTAG debugger. Sorry for that.
But anyway your kernel doesn't contain DSP Gateway,
so you should check you are loading correct kernel image.

When I load my kernel through JTAG, I use vmlinux for symbols besides
using zImage for the binary to run, to save download time by using a
compressed image. In that case I need to replace both vmlinux and
zImage on the debugger host.
Could this kind of things happen on your situation?

BR,
Toshihiro Kobayashi
