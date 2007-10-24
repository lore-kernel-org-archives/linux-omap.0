From: "Jonathan Kotta" <jpkotta@gmail.com>
Subject: Re: trying to read something
Date: Wed, 24 Oct 2007 18:09:45 -0500
Message-ID: <47c31da80710241609h27828d3cj2b080751c414b688@mail.gmail.com>
References: <ae36f8040710241405j393d22c7m823d4bf3e9a4633a@mail.gmail.com>
	<31e679430710241441j1e476419t5b0d8dd257e63f73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <31e679430710241441j1e476419t5b0d8dd257e63f73@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 10/24/07, Felipe Balbi <felipebalbi@users.sourceforge.net> wrote:
> Hi,
>
> On 10/25/07, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
> > Dear fellows,
> > I'm writing an driver, in the present moment
> > I have the following problem:
> > BUG: scheduling while atomic: adstest/0x00000002/854, CPU#0
> > [<c002c9f0>] (dump_stack+0x0/0x14) from [<c004cc3c>] (__schedule_bug+0x=
3c/0x44)
> > [<c004cc00>] (__schedule_bug+0x0/0x44) from [<c02592a0>] (__schedule+0x=
ac/0x484)
> > [<c02591f4>] (__schedule+0x0/0x484) from [<c0259fd4>] (schedule+0xcc/0x=
114)
> >  r7:00000001 r6:c030b8bc r5:c1c42000 r4:c1c42000
> > [<c0259f08>] (schedule+0x0/0x114) from [<c025a4c0>]
> > (wait_for_completion+0xc0/0x154)
> >  r4:c1c43ef4
> > [<c025a400>] (wait_for_completion+0x0/0x154) from [<c003de78>]
> > (omap_mcbsp_recv_word+0x40/0x64)
> >  r6:00000002 r5:c030b838 r4:fefb1000
> > [<c003de38>] (omap_mcbsp_recv_word+0x0/0x64) from [<bf00037c>]
> > (ads8xxx_read+0x50/0xf0 [ads8xxx])
> >  r6:00004005 r5:00000002 r4:c198e002
> > [<bf00032c>] (ads8xxx_read+0x0/0xf0 [ads8xxx]) from [<c00a3e68>]
> > (vfs_read+0xb4/0x140)
> > [<c00a3db4>] (vfs_read+0x0/0x140) from [<c00a4990>] (sys_read+0x4c/0x80=
)
> >  r7:00000003 r6:00000000 r5:00000002 r4:c1d2d160
> > [<c00a4944>] (sys_read+0x0/0x80) from [<c0028ee0>] (ret_fast_syscall+0x=
0/0x2c)
> >  r6:00000002 r5:0000873c r4:beb98eb4
> >
> >
> >
> > the system is locking in the read process of my driver, the read code
> > in driver is :
> >
> > ssize_t ads8xxx_read(struct file *filp, char __user *buf, size_t
> > count, loff_t *f_pos)
> > {
> >         ssize_t result =3D 0;
> >         int i;
> >         struct handler_dev *dev =3D filp->private_data;
> >
> >         spin_lock_irq(&dev->slock);
> >         //if (down_interruptible(&dev->sema))
> >         //      return -ERESTARTSYS;
> >         //if (*f_pos >=3D dev->rsize)
> >         //      goto out;
> >         //if (*f_pos + count > dev->rsize)
> >         //count =3D dev->rsize - *f_pos;
> >         for(i =3D 0; i< count; i++)
> >                 dev->rbuffer[i] =3D (uint16_t) omap_mcbsp_recv_word(dev=
->adc_dev);
>
> I can be wrong... but I think you can't "wait_for_completion()" inside
> a spinlock...
>
> remove your locks... it'll probably work...
> omap_mcbsp_recv_word()  will call wait_for_completion() which calls
> wait_for_common, and this one locks when needed...
>
> try that ;-)
>
>

Also, I don't think copy_to_user() should be called while holding a
spinlock, because it can sleep.

> >
> >         if (copy_to_user(buf, &dev->rbuffer, count))
> >         {
> >                 result =3D -EFAULT;
> >                 goto out;
> >         }
> >         *f_pos +=3D count;
> >         result =3D count;
> >
> >
> >         out:
> >
> >                 spin_unlock_irq(&dev->slock);
> >                 return result;
> >
> > --
> > -----------------------------------------------------------------------=
-------
> > Thanks && Regards
> > Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> > IEEE Member
> > Electrical Engineer Faculty @ PUCRS
> > Ipiranga Avenue, 6681 =96 Building 30
> > P.O. Box: 90619-900 =96 Porto Alegre/RS
> > Phone: +55 51 3320 3500  extension: 7696
> > -----------------------------------------------------------------------=
----------
> >
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> >
>
>
> --
> Best Regards,
>
> Felipe Balbi
> felipebalbi@users.sourceforge.net
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


--=20
Thanks,

Jonathan Kotta

Hofstadter's Law:
    It always takes longer than you expect, even
    when you take into account Hofstadter's Law.
