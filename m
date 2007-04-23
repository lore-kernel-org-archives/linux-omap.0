From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: Compiling latest kernel (from kernel.org,
	linux-omap git version) in n800
Date: Mon, 23 Apr 2007 22:47:45 +0300
Message-ID: <31e679430704231247i3b1b005bsd6fa93f18d52780a@mail.gmail.com>
References: <5bc4c4570704191356q6a6d89e9y745bc8fb661d36c5@mail.gmail.com>
	<5bc4c4570704211518p1168ec99qd8d44fb8f14f5979@mail.gmail.com>
	<5bc4c4570704211519q1cc49e46j3fc25dd013d3332d@mail.gmail.com>
	<31e679430704211543x65fb0950pc997a360a30f9e6d@mail.gmail.com>
	<5bc4c4570704221023h3a52d78bpac1f56f8fb5560a1@mail.gmail.com>
	<20070423090244.e7a39073.jarkko.nikula@nokia.com>
	<5bc4c4570704231118q47974273qfd36e41970a02635@mail.gmail.com>
	<31e679430704231123v6a73cc8fqd6b67918be28a5a9@mail.gmail.com>
	<5bc4c4570704231129r7bff6759xc97eedc3d8ee26c7@mail.gmail.com>
	<20070423183514.GI19866@intune.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070423183514.GI19866@intune.research.nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Stone <daniel.stone@nokia.com>, ext Leandro Melo de Sales <leandroal@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Daniel,


On 4/23/07, Daniel Stone <daniel.stone@nokia.com> wrote:
> On Mon, Apr 23, 2007 at 03:29:26PM -0300, ext Leandro Melo de Sales wrote:
> > Really? I need to take some wireless performance tests using a
> > modified transport protocol and wifi and I cannot? Is there another
> > way to do that?
>
> You can build the cx3110x driver against the new kernel (it's on
> garage.maemo.org IIRC)
Didn't know about that. That's nice then :-)

> initfs by hand.  It's mounted as /mnt/initfs on the device, or you can
> extract initfs.jffs2 from the FIASCO image and rebuild it from there
> with mkfs.jffs2 and sumtool.

Actually, you can use mtdblock to mount jffs2 filesystem on you pc...
after that you can copy stuff to there or just
make INSTALL_MOD_PATH=/mymtblock modules_install

They'll be directly copied to you initfs or rootfs, whatever you want.



-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
