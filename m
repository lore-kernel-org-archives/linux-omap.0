From: Ola Helm <ola.hel@gmail.com>
Subject: Re: 2420 H4 and kernel startup RAM error
Date: Thu, 2 Feb 2006 11:25:53 +0200
Message-ID: <3d3153f60602020125i1ed37e09ka064fd98fb7661ff@mail.gmail.com>
References: <AcYWpTe6aXSMe0MKSzKgc7ZYk93NfwAIDqiQ>
	<520AB2AD990DC04082102F77CA172638023C279B@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <520AB2AD990DC04082102F77CA172638023C279B@dlee03.ent.ti.com>
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
To: "Menon, Nishanth" <x0nishan@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Old news, but I finally surrendered and did excatly as you guys adviced
- used nfs
- flash_eraseall
- mount
and it naturally worked.

So in case anybody happens to read this conversation, my advice is to do
just as told in previous mails. Whatever way the jffs2-image has been
generated,  I recommend to use nfs to generate the pre-filesystem which via
at least jffs2 image is brought available to be flashed.

Thanks to everybody again for help.

On 1/11/06, Menon, Nishanth <x0nishan@ti.com> wrote:
>
>
> >The questions are:
> >1) No way to do filesystem flashing and loading in uboot state i.e.
> with >same method as with kernel?
> U can do the same from uboot too, but a tftp of a 60 Meg image is
> guaranteed to take a long long time.. it is much easier to have it in
> nfs and cat it.
> The procedure will be the same as the flashing of the uboot.
>
> Lets say u managed to have an rd-jffs2.bin which worked fine from nfs
> filesystem and you were able to mount -t jffs2 the resultant partition.
> In such a case, repeat the steps we did for uboot, but change the
> addresses to map to mtd3 and the size to map to the size of the
> partition from uboot. It should still do the same thing.
>
> >2) Is there a way to load the image afterwards i.e. when the system has
>
> >booted up with some filesystem?
> > 3) Could this kind loading be done with ramdisk system?
> This is what I had presented - usually we do it over nfs since the jffs2
> image file tends to be big and may not fit into a ramdisk. This has the
> additional advantage of being able to modify the filesystem and reflash
> it as often as I need to..
>
> Regards,
> Nishanth Menon
>
