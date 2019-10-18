From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] omapfb: reduce stack usage
Date: Fri, 18 Oct 2019 23:13:25 +0100
Message-ID: <CADVatmOHom0nLkezfHGrdQZBD97OiWGkEXVjhoSaCC6F8ymM7A@mail.gmail.com>
References: <20191018163004.23498-1-sudipm.mukherjee@gmail.com>
 <20191018172728.GA11857@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1745734681=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191018172728.GA11857@lenoch>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: LFBDEV <linux-fbdev@vger.kernel.org>, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-omap@vger.kernel.org

--===============1745734681==
Content-Type: multipart/alternative; boundary="000000000000c514aa059536a637"

--000000000000c514aa059536a637
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 18, 2019 at 6:27 PM Ladislav Michl <ladis@linux-mips.org> wrote:

> On Fri, Oct 18, 2019 at 05:30:04PM +0100, Sudip Mukherjee wrote:
> > The build of xtensa allmodconfig is giving a warning of:
> > In function 'dsi_dump_dsidev_irqs':
> > warning: the frame size of 1120 bytes is larger than 1024 bytes
> >
> > Allocate the memory for 'struct dsi_irq_stats' dynamically instead
> > of assigning it in stack.
>
> So now function can fail silently, executes longer, code is sligthly
> bigger... And all that to silent warning about exceeding frame size.
> Is it really worth "fixing"?
>

The only point of failure is if kmalloc() fails and if kmalloc() fails then
there will be error prints in dmesg to tell the user that there is no
memory left in the system. About the size bigger, it seems
the drivers/video/fbdev/omap2/omapfb/dss/dsi.o file is smaller with the
patch.
This is without the patch:
wo_patch
-rw-r--r-- 1 sudip sudip 316856 Oct 18 22:27
drivers/video/fbdev/omap2/omapfb/dss/dsi.o
And this is with the patch:
-rw-r--r-- 1 sudip sudip 316436 Oct 18 20:09
drivers/video/fbdev/omap2/omapfb/dss/dsi.o

And also, objdump shows me that <dsi_dump_dsidev_irqs> was taking up 0xD7D
bytes, and now with the patch it is taking up 0xBED bytes, thats a saving
of 400 bytes. If it has 400 bytes of less code to execute will it not be
faster now?

But, I may be totally wrong in my thinking, and in that case, please feel
free to reject the patch.

-- 
Regards
Sudip

--000000000000c514aa059536a637
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 18, 2019 at 6:27 PM Ladis=
lav Michl &lt;<a href=3D"mailto:ladis@linux-mips.org">ladis@linux-mips.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Fri, Oct 18, 2019 at 05:30:04PM +0100, Sudip Mukherjee wrote:<br>
&gt; The build of xtensa allmodconfig is giving a warning of:<br>
&gt; In function &#39;dsi_dump_dsidev_irqs&#39;:<br>
&gt; warning: the frame size of 1120 bytes is larger than 1024 bytes<br>
&gt; <br>
&gt; Allocate the memory for &#39;struct dsi_irq_stats&#39; dynamically ins=
tead<br>
&gt; of assigning it in stack.<br>
<br>
So now function can fail silently, executes longer, code is sligthly<br>
bigger... And all that to silent warning about exceeding frame size.<br>
Is it really worth &quot;fixing&quot;?<br></blockquote><div><br></div><div>=
The only point of failure is if kmalloc() fails and if kmalloc() fails then=
 there will be error prints in dmesg to tell the user that there is no memo=
ry left in the system. About the size bigger, it seems the=C2=A0drivers/vid=
eo/fbdev/omap2/omapfb/dss/dsi.o file is smaller with the patch.</div><div>T=
his is without the patch:</div><div>wo_patch<br>-rw-r--r-- 1 sudip sudip 31=
6856 Oct 18 22:27 drivers/video/fbdev/omap2/omapfb/dss/dsi.o<br></div><div>=
And this is with the patch:</div><div>-rw-r--r-- 1 sudip sudip 316436 Oct 1=
8 20:09 drivers/video/fbdev/omap2/omapfb/dss/dsi.o<br></div><div><br></div>=
<div>And also, objdump shows me that &lt;dsi_dump_dsidev_irqs&gt; was takin=
g up 0xD7D bytes, and now with the patch it is taking up 0xBED bytes, thats=
 a saving of 400 bytes. If it has 400 bytes of less code to execute will it=
 not be faster now?</div><div><br></div><div>But, I may be totally wrong in=
 my thinking, and in that case, please feel free to reject the patch.</div>=
<div><br></div><div>--=C2=A0<br></div></div><div dir=3D"ltr" class=3D"gmail=
_signature">Regards<br>Sudip</div></div>

--000000000000c514aa059536a637--

--===============1745734681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1745734681==--
