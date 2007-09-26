From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: problems witha device driver
Date: Wed, 26 Sep 2007 12:02:22 -0400
Message-ID: <31e679430709260902p87dcf29s9ae1fcadbd788ecb@mail.gmail.com>
References: <ae36f8040709260846t522b4d18t1f5119b1ba707795@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040709260846t522b4d18t1f5119b1ba707795@mail.gmail.com>
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
To: lvcargnini@gmail.com
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 9/26/07, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
> dear fellows I'm testing a device driver, and I received the following :

Which device driver the next time. I've grep "drivers/" folder in
kernel tree and didn't find any occurency of ads8xxx.

> Unable to handle kernel NULL pointer dereference at virtual address 00000=
fc8
> pgd =3D c1a58000
> [00000fc8] *pgd=3D11983031, *pte=3D00000000, *ppte=3D00000000
> Internal error: Oops: 17 [#1]
> Modules linked in: ads8xxx
> CPU: 0
> PC is at rt_mutex_lock_interruptible+0x2c/0x6c
> LR is at rt_down_interruptible+0x20/0x60
> pc : [<c02b5058>]    lr : [<c0078d48>]    Not tainted
> sp : c1a3df08  ip : c1c4f600  fp : c1a3df14
> r10: 40151608  r9 : c1a3c000  r8 : c1a3df80
> r7 : 00000000  r6 : 00000fb4  r5 : 00000fb8  r4 : 00000fb4
> r3 : 60000093  r2 : 60000013  r1 : 00000000  r0 : 00000fb8
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  Segment user
> Control: 5717F
> Table: 11A58000  DAC: 00000015
> Process adstest (pid: 356, stack limit =3D 0xc1a3c250)
> Stack: (0xc1a3df08 to 0xc1a3e000)
>
>
> this happens after my driver execute the open operation the null pointer =
the
> dereferencing pointer could be what ?

You're probably using a NULL pointer in some case.
Try to test the point with some if clause.

pointer =3D some_function_to_initialize_pointer();

if (!pointer)
    printk (KERN_ERR "Pointer %p is not initialized\n", pointer);



In any case, it'll be better if you show us some code.

>
> --
> -------------------------------------------------------------------------=
-----
> Thanks && Regards
> Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Electrical Engineer Faculty @ PUCRS
> Ipiranga Avenue, 6681 =96 Building 30
> P.O. Box: 90619-900 =96 Porto Alegre/RS
> Phone: +55 51 3320 3500  extension: 7696
> -------------------------------------------------------------------------=
--------
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


--=20
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
