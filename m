From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: problems with backlight
Date: Wed, 3 Oct 2007 14:17:00 -0300
Message-ID: <ae36f8040710031017u5ddae9f7ladff0d4ace673375@mail.gmail.com>
References: <ae36f8040710021045n4a966f26laec721e2b9d1cf1f@mail.gmail.com>
	<31e679430710021103r6737b937l30afeed8788aad43@mail.gmail.com>
	<31e679430710021108n1428d7c4gfb799d7aa18f7449@mail.gmail.com>
	<ae36f8040710030944m5b67fb7dle9d23d5486f30941@mail.gmail.com>
	<31e679430710030954h3fce6412m15c6b7a7e5e1a784@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <31e679430710030954h3fce6412m15c6b7a7e5e1a784@mail.gmail.com>
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
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

oops:
 MODPOST 173 modules
ERROR: "tsc2102_coords_cb" [drivers/input/touchscreen/tsc2102_ts.ko]
undefined!
ERROR: "tsc2102_touch_cb" [drivers/input/touchscreen/tsc2102_ts.ko]
undefined!
 disabling this.

On 10/3/07, Felipe Balbi <felipebalbi@users.sourceforge.net> wrote:
>
> Hi,
>
> On 10/3/07, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
> > I applied the patches only now and are compiling the kernel right now
>
> please confirm it's working. I can't test it on OMAP boards right due
> to time issues :-p
>
> >
> >
> > On 10/2/07, Felipe Balbi <felipebalbi@users.sourceforge.net
> > > wrote:
> > > Sorry,
> > >
> > > forgot to change to correct function...
> > >
> > > try this one
> > >
> > >
> > >
> > >
> > >
> > > On 10/2/07, Felipe Balbi
> > <felipebalbi@users.sourceforge.net> wrote:
> > > > Hi Luis,
> > > >
> > > > On 10/2/07, Lu=EDs Cargnini < lvcargnini@gmail.com> wrote:
> > > > > Dear fellows,
> > > > > I had the following problems compiling for omap with omap
> backlight
> > enabled,
> > > > > the following error:
> > > > > make
> > > > >   CHK     include/linux/version.h
> > > > > make[1]: `include/asm-arm/mach-types.h' is up to date.
> > > > >   CHK     include/linux/utsrelease.h
> > > > >   CALL    scripts/checksyscalls.sh
> > > > > <stdin>:1097:2: warning: #warning syscall fadvise64 not
> implemented
> > > > > <stdin>:1265:2: warning: #warning syscall migrate_pages not
> > implemented
> > > > > <stdin>:1321:2: warning: #warning syscall pselect6 not implemente=
d
> > > > > <stdin>:1325:2: warning: #warning syscall ppoll not implemented
> > > > > <stdin>:1365:2: warning: #warning syscall epoll_pwait not
> implemented
> > > > > <stdin>:1385:2: warning: #warning syscall fallocate not
> implemented
> > > > >   CHK     include/linux/compile.h
> > > > >   CC [M]  drivers/video/backlight/omap_bl.o
> > > > > drivers/video/backlight/omap_bl.c: In function
> > 'omapbl_suspend':
> > > > > drivers/video/backlight/omap_bl.c:79: error: 'struct
> > backlight_device' has
> > > > > no member named 'class_dev'
> > > > > drivers/video/backlight/omap_bl.c: In function
> > 'omapbl_resume':
> > > > > drivers/video/backlight/omap_bl.c:88: error: 'struct
> > backlight_device' has
> > > > > no member named 'class_dev'
> > > > > drivers/video/backlight/omap_bl.c: In function
> > 'omapbl_set_power':
> > > > > drivers/video/backlight/omap_bl.c:100: error: 'struct
> > backlight_device' has
> > > > > no member named 'class_dev'
> > > > > drivers/video/backlight/omap_bl.c: In function
> > 'omapbl_update_status':
> > > > > drivers/video/backlight/omap_bl.c:110: error: 'struct
> > backlight_device' has
> > > > > no member named 'class_dev'
> > > > > drivers/video/backlight/omap_bl.c: In function
> > 'omapbl_get_intensity':
> > > > > drivers/video/backlight/omap_bl.c:130: error: 'struct
> > backlight_device' has
> > > > > no member named 'class_dev'
> > > > > drivers/video/backlight/omap_bl.c: In function
> > 'omapbl_remove':
> > > > > drivers/video/backlight/omap_bl.c:185: error: 'struct
> > backlight_device' has
> > > > > no member named 'class_dev'
> > > > > make[3]: *** [drivers/video/backlight/omap_bl.o]
> > Error 1
> > > > > make[2]: *** [drivers/video/backlight] Error 2
> > > > > make[1]: *** [drivers/video] Error 2
> > > > > make: *** [drivers] Error 2
> > > > >
> > > > > looking he source code:
> > > > > struct omap_backlight {
> > > > >     int powermode;
> > > > >     int current_intensity;
> > > > >
> > > > >     struct device *dev;
> > > > >     struct omap_backlight_config *pdata;
> > > > > };
> > > > >
> > > > >
> > > > > but :
> > > > > #ifdef CONFIG_PM
> > > > > static int omapbl_suspend(struct platform_device *pdev,
> pm_message_t
> > state)
> > > > > {
> > > > >     struct backlight_device *dev =3D platform_get_drvdata(pdev);
> > > > >     struct omap_backlight *bl =3D
> > class_get_devdata(&dev->class_dev);
> > > > >
> > > > >     omapbl_blank(bl, FB_BLANK_POWERDOWN);
> > > > >     return 0;
> > > > > }
> > > > >
> > > > > someone have figured this problem before ?
> > > > > can I make the fix ?
> > > > > There is no fix, no problem I'm just creating one ?
> > > >
> > > > Check if the attached fixes the issue...
> > > >
> > > > If it works, I'll send a proper formated patch
> > > >
> > > > >
> > > > > --
> > > > >
> >
> -------------------------------------------------------------------------=
-----
> > > > > Thanks && Regards
> > > > > Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> > > > > IEEE Member
> > > > > Electrical Engineer Faculty @ PUCRS
> > > > > Ipiranga Avenue, 6681 =96 Building 30
> > > > > P.O. Box: 90619-900 =96 Porto Alegre/RS
> > > > > Phone: +55 51 3320 3500  extension: 7696
> > > > >
> >
> -------------------------------------------------------------------------=
--------
> > > > > _______________________________________________
> > > > > Linux-omap-open-source mailing list
> > > > > Linux-omap-open-source@linux.omap.com
> > > > >
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > > > >
> > > >
> > > >
> > > > --
> > > > Best Regards,
> > > >
> > > > Felipe Balbi
> > > > felipebalbi@users.sourceforge.net
> > > >
> > > >
> > >
> > >
> > > --
> > > Best Regards,
> > >
> > > Felipe Balbi
> > > felipebalbi@users.sourceforge.net
> > >
> > >
> >
> >
> >
> > --
> >
> >
> -------------------------------------------------------------------------=
-----
> > Thanks && Regards
> > Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> > IEEE Member
> > Electrical Engineer Faculty @ PUCRS
> > Ipiranga Avenue, 6681 =96 Building 30
> > P.O. Box: 90619-900 =96 Porto Alegre/RS
> > Phone: +55 51 3320 3500  extension: 7696
> >
> -------------------------------------------------------------------------=
--------
>
>
> --
> Best Regards,
>
> Felipe Balbi
> felipebalbi@users.sourceforge.net
>



--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------
