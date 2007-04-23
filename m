From: "Leandro Melo de Sales" <leandroal@gmail.com>
Subject: Re: Compiling latest kernel (from kernel.org,
	linux-omap git version) in n800
Date: Mon, 23 Apr 2007 16:39:16 -0300
Message-ID: <5bc4c4570704231239w32060adcq2d026e7956452064@mail.gmail.com>
References: <5bc4c4570704211518p1168ec99qd8d44fb8f14f5979@mail.gmail.com>
	<5bc4c4570704221023h3a52d78bpac1f56f8fb5560a1@mail.gmail.com>
	<20070423090244.e7a39073.jarkko.nikula@nokia.com>
	<5bc4c4570704231118q47974273qfd36e41970a02635@mail.gmail.com>
	<31e679430704231123v6a73cc8fqd6b67918be28a5a9@mail.gmail.com>
	<5bc4c4570704231129r7bff6759xc97eedc3d8ee26c7@mail.gmail.com>
	<20070423183514.GI19866@intune.research.nokia.com>
	<5bc4c4570704231153p788a3936ue36041eeb7e06f8e@mail.gmail.com>
	<20070423185719.GJ19866@intune.research.nokia.com>
	<5bc4c4570704231216m15565ed0l8e8bb976ac8c0828@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5bc4c4570704231216m15565ed0l8e8bb976ac8c0828@mail.gmail.com>
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
To: jarkko.nikula@nokia.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Jarkko,

  First of all, I'd like to thank you about all help that you are done
to me. Well, as I said, I can't use my WLAN interface after I compiled
the omap git kernel and flash it into my n800. But Daniel Stone
suggested me to use the cx3110x driver. From your post at
http://maemo.org/pipermail/maemo-developers/2007-February/007809.html,
I read that the driver will be available as soon as possible. Does
cx3110x driver correspond to the driver that you mentioned the that
post?
  Please, let me know from now how can I use the driver with my
compiled kernel. Daniel suggested me some process, but I don't know
how can I do it.

Thank you,
Leandro.

2007/4/23, Leandro Melo de Sales <leandroal@gmail.com>:
> Hi Daniel,
>
>   garage.maemo.org I know! I just didn't understand when you said
> IIRC, in all case, thank you. I get mkfs.jffs2 and download the source
> of cx3110x driver. I extracted from tar.gz and type make modules, but
> I got the following:
>
> [sbox-SDK_ARMEL: ~/maemo/linux-omap-dev-2.6.git/cx3110x-1.2] > make modules
> make -C src/ modules CONFIG_CX3110X_PROD=m
> make[1]: Entering directory
> `/home/leandro/maemo/linux-omap-dev-2.6.git/cx3110x-1.2/src'
> /scratchbox/tools/bin/make -C
> SUBDIRS=/home/leandro/maemo/linux-omap-dev-2.6.git/cx3110x-1.2/src
> modules
> make: *** SUBDIRS=/home/leandro/maemo/linux-omap-dev-2.6.git/cx3110x-1.2/src:
> No such file or directory.  Stop.
> make: Entering an unknown directorymake: Leaving an unknown
> directorymake[1]: *** [modules] Error 2
> make[1]: Leaving directory
> `/home/leandro/maemo/linux-omap-dev-2.6.git/cx3110x-1.2/src'
> make: *** [modules] Error 2
> [sbox-SDK_ARMEL: ~/maemo/linux-omap-dev-2.6.git/cx3110x-1.2] > ls
> COPYING  Makefile  src
> [sbox-SDK_ARMEL: ~/maemo/linux-omap-dev-2.6.git/cx3110x-1.2] >
>
> What is wrong?
>
> Thank you,
> Leandro.
>
> 2007/4/23, Daniel Stone <daniel.stone@nokia.com>:
> > On Mon, Apr 23, 2007 at 03:53:56PM -0300, ext Leandro Melo de Sales wrote:
> > >  please, I'd like you explain me this process in more details. Sorry
> > > but I'm a newbie into maemo platform, although I have been working
> > > with linux for many years. I'm taking my master degree at federal
> > > university of campina grande, Brazil, where we have projects with
> > > INdT/Brazil (Instituto Nokia de Tecnologia).
> > > First of all, when you say garage.maemo.org IIRC, do you mean the
> > > maemo channel of irc.freenode.net? what do you mean IIRC? Second, when
> > > you say copy into the initfs, does /mnt/initfs is a read-only area,
> > > doesn't it? How can I do it? About extract initfs.jffs2 from FIASCO,
> > > how can I do that? I tried to use flasher with -u option like this:
> > >
> > > ./flasher --unpack RX-34_2007SE_3.2007.10-7_PR_COMBINED_MR0_ARM.bin
> > > flasher v0.8.7 (Oct 17 2006)
> > >
> > > but flasher do nothing. I'm using scratchbox and I don't have
> > > mkfs.jffs2 command, where can I get it?
> >
> > Hi,
> > garage.maemo.org is a website: http://garage.maemo.org.  I don't believe
> > /mnt/initfs is mount-only.  You can get mkfs.jffs2 from your
> > distribution, and you need to pass -F to flasher as well: flasher -u -F
> > blah.bin.
> >
> > Cheers,
> > Daniel
> >
> > -----BEGIN PGP SIGNATURE-----
> > Version: GnuPG v1.4.3 (GNU/Linux)
> >
> > iD8DBQFGLQGP68xJuWtYYdURAsY6AKCbUFQXT5pRSdoFIZt4pZROMBGJ8gCfevY/
> > OkIH0CkExKfoFzuLmAQrdbQ=
> > =PY9j
> > -----END PGP SIGNATURE-----
> >
> >
>
