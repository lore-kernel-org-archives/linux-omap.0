From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: Compiling latest kernel (from kernel.org,
	linux-omap git version) in n800
Date: Mon, 23 Apr 2007 21:35:14 +0300
Message-ID: <20070423183514.GI19866@intune.research.nokia.com>
References: <5bc4c4570704191356q6a6d89e9y745bc8fb661d36c5@mail.gmail.com>
	<5bc4c4570704191417u6c27c752se688d8347eadec9c@mail.gmail.com>
	<5bc4c4570704211518p1168ec99qd8d44fb8f14f5979@mail.gmail.com>
	<5bc4c4570704211519q1cc49e46j3fc25dd013d3332d@mail.gmail.com>
	<31e679430704211543x65fb0950pc997a360a30f9e6d@mail.gmail.com>
	<5bc4c4570704221023h3a52d78bpac1f56f8fb5560a1@mail.gmail.com>
	<20070423090244.e7a39073.jarkko.nikula@nokia.com>
	<5bc4c4570704231118q47974273qfd36e41970a02635@mail.gmail.com>
	<31e679430704231123v6a73cc8fqd6b67918be28a5a9@mail.gmail.com>
	<5bc4c4570704231129r7bff6759xc97eedc3d8ee26c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5bc4c4570704231129r7bff6759xc97eedc3d8ee26c7@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Leandro Melo de Sales <leandroal@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 23, 2007 at 03:29:26PM -0300, ext Leandro Melo de Sales wrote:
> Really? I need to take some wireless performance tests using a
> modified transport protocol and wifi and I cannot? Is there another
> way to do that?

You can build the cx3110x driver against the new kernel (it's on
garage.maemo.org IIRC), but I guess you'll have to copy it into the
initfs by hand.  It's mounted as /mnt/initfs on the device, or you can
extract initfs.jffs2 from the FIASCO image and rebuild it from there
with mkfs.jffs2 and sumtool.

Cheers,
Daniel
