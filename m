From: "Vutla, Lokesh" <lokeshvutla@ti.com>
Subject: Re: [PATCH] Watchdog: OMAP: Fix the runtime pm code to avoid module
 getting stuck intransition state.
Date: Sat, 30 Jun 2012 12:53:14 +0530
Message-ID: <CAJ1gdcajf5RG7gsMC7V8qsS7KB9bFC_ox5Jj62CRCmmsTOSHhQ@mail.gmail.com>
References: <1339996996-3257-1-git-send-email-lokeshvutla@ti.com>
 <CAMQu2gwUgPewy98L+yF5bcdrqXRLZftb3utLNg5HV1jBscGpTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1687735934677129137=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMQu2gwUgPewy98L+yF5bcdrqXRLZftb3utLNg5HV1jBscGpTQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1687735934677129137==
Content-Type: multipart/alternative; boundary=00235429cd5050481a04c3ab715e

--00235429cd5050481a04c3ab715e
Content-Type: text/plain; charset=ISO-8859-1

Gentle ping on this....



Thanks n regards
Lokesh Vutla
LDC MPUSS Platform Team



On Mon, Jun 18, 2012 at 11:11 AM, Shilimkar, Santosh <
santosh.shilimkar@ti.com> wrote:

> (You should cc linux-omap too.  CC'ing linux-omap)
>
> On Mon, Jun 18, 2012 at 10:53 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
> > OMAP watchdong driver is adapted to runtime PM like a general device
> > driver but it is not appropriate. It is causing couple of functional
> > issues.
> >
> > 1. On OMAP4 SYSCLK can't be gated, because of issue with WDTIMER2 module,
> > which constantly stays in "in transition" state. Value of register
> > CM_WKUP_WDTIMER2_CLKCTRL is always 0x00010000 in this case.
> > Issue occurs immediately after first idle, when hwmod framework tries
> > to disable WDTIMER2 functional clock - "wd_timer2_fck". After this
> > module falls to "in transition" state, and SYSCLK gating is blocked.
> >
> > 2. Due to runtime PM, watchdog timer may be completely disabled.
> > In current code base watchdog timer is not disabled only because of
> > issue 1. Otherwise state of WDTIMER2 module will be "Disabled", and there
> > will be no interrupts from omap_wdt. In other words watchdog will not
> > work at all.
> >
> > Watchdong is a special IP and it should not be disabled otherwise
> > purpose of it itself is defeated. Watchdog functional clock should
> > never be disabled. This patch updates the runtime PM handling in
> > driver so that runtime PM is limited only during probe/shutdown
> > and suspend/resume.
> >
> > The patch fixes issue 1 and 2
> >
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> > ---
> > Tested on OMAP4430SDP.
> >
> > Issue #1 can be easily reproduced on mainline kernel.
> > - Take latest mainline kernel and create uImage using omap2plus_defconfig
> > - Write a program to open watchdog,like
> > void main(void)
> > {
> >        int fd = open("/dev/watchdog", O_WRONLY);
> >
> >        if (fd == -1) {
> >                perror("Watchdog device interface is not available!\n");
> >        }
> > }
> > - Build with arm compiler and copy it to your file syatem
> > - Boot the image and run the executable.
> >
> >
> >  drivers/watchdog/omap_wdt.c |   17 -----------------
> >  1 files changed, 0 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> > index 8285d65..27ab8db 100644
> > --- a/drivers/watchdog/omap_wdt.c
> > +++ b/drivers/watchdog/omap_wdt.c
> > @@ -126,8 +126,6 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev
> *wdev)
> >        u32 pre_margin = GET_WLDR_VAL(timer_margin);
> >        void __iomem *base = wdev->base;
> >
> > -       pm_runtime_get_sync(wdev->dev);
> > -
> >        /* just count up at 32 KHz */
> >        while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
> >                cpu_relax();
> > @@ -135,8 +133,6 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev
> *wdev)
> >        __raw_writel(pre_margin, base + OMAP_WATCHDOG_LDR);
> >        while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
> >                cpu_relax();
> > -
> > -       pm_runtime_put_sync(wdev->dev);
> >  }
> >
> >  /*
> > @@ -166,8 +162,6 @@ static int omap_wdt_open(struct inode *inode, struct
> file *file)
> >        omap_wdt_ping(wdev); /* trigger loading of new timeout value */
> >        omap_wdt_enable(wdev);
> >
> > -       pm_runtime_put_sync(wdev->dev);
> > -
> >        return nonseekable_open(inode, file);
> >  }
> >
> > @@ -179,8 +173,6 @@ static int omap_wdt_release(struct inode *inode,
> struct file *file)
> >         *      Shut off the timer unless NOWAYOUT is defined.
> >         */
> >  #ifndef CONFIG_WATCHDOG_NOWAYOUT
> > -       pm_runtime_get_sync(wdev->dev);
> > -
> >        omap_wdt_disable(wdev);
> >
> >        pm_runtime_put_sync(wdev->dev);
> > @@ -199,11 +191,9 @@ static ssize_t omap_wdt_write(struct file *file,
> const char __user *data,
> >
> >        /* Refresh LOAD_TIME. */
> >        if (len) {
> > -               pm_runtime_get_sync(wdev->dev);
> >                spin_lock(&wdt_lock);
> >                omap_wdt_ping(wdev);
> >                spin_unlock(&wdt_lock);
> > -               pm_runtime_put_sync(wdev->dev);
> >        }
> >        return len;
> >  }
> > @@ -236,18 +226,15 @@ static long omap_wdt_ioctl(struct file *file,
> unsigned int cmd,
> >                                        (int __user *)arg);
> >                return put_user(0, (int __user *)arg);
> >        case WDIOC_KEEPALIVE:
> > -               pm_runtime_get_sync(wdev->dev);
> >                spin_lock(&wdt_lock);
> >                omap_wdt_ping(wdev);
> >                spin_unlock(&wdt_lock);
> > -               pm_runtime_put_sync(wdev->dev);
> >                return 0;
> >        case WDIOC_SETTIMEOUT:
> >                if (get_user(new_margin, (int __user *)arg))
> >                        return -EFAULT;
> >                omap_wdt_adjust_timeout(new_margin);
> >
> > -               pm_runtime_get_sync(wdev->dev);
> >                spin_lock(&wdt_lock);
> >                omap_wdt_disable(wdev);
> >                omap_wdt_set_timeout(wdev);
> > @@ -255,7 +242,6 @@ static long omap_wdt_ioctl(struct file *file,
> unsigned int cmd,
> >
> >                omap_wdt_ping(wdev);
> >                spin_unlock(&wdt_lock);
> > -               pm_runtime_put_sync(wdev->dev);
> >                /* Fall */
> >        case WDIOC_GETTIMEOUT:
> >                return put_user(timer_margin, (int __user *)arg);
> > @@ -363,7 +349,6 @@ static void omap_wdt_shutdown(struct platform_device
> *pdev)
> >        struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
> >
> >        if (wdev->omap_wdt_users) {
> > -               pm_runtime_get_sync(wdev->dev);
> >                omap_wdt_disable(wdev);
> >                pm_runtime_put_sync(wdev->dev);
> >        }
> > @@ -403,7 +388,6 @@ static int omap_wdt_suspend(struct platform_device
> *pdev, pm_message_t state)
> >        struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
> >
> >        if (wdev->omap_wdt_users) {
> > -               pm_runtime_get_sync(wdev->dev);
> >                omap_wdt_disable(wdev);
> >                pm_runtime_put_sync(wdev->dev);
> >        }
> > @@ -419,7 +403,6 @@ static int omap_wdt_resume(struct platform_device
> *pdev)
> >                pm_runtime_get_sync(wdev->dev);
> >                omap_wdt_enable(wdev);
> >                omap_wdt_ping(wdev);
> > -               pm_runtime_put_sync(wdev->dev);
> >        }
> >
> >        return 0;
> > --
> > 1.7.5.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

--00235429cd5050481a04c3ab715e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gentle ping on this....<br clear=3D"all"><br><br><br>Thanks n regards<br>Lo=
kesh Vutla<div>LDC MPUSS Platform Team</div><br>
<br><br><div class=3D"gmail_quote">On Mon, Jun 18, 2012 at 11:11 AM, Shilim=
kar, Santosh <span dir=3D"ltr">&lt;<a href=3D"mailto:santosh.shilimkar@ti.c=
om" target=3D"_blank">santosh.shilimkar@ti.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">

(You should cc linux-omap too. =A0CC&#39;ing linux-omap)<br>
<div><div class=3D"h5"><br>
On Mon, Jun 18, 2012 at 10:53 AM, Lokesh Vutla &lt;<a href=3D"mailto:lokesh=
vutla@ti.com">lokeshvutla@ti.com</a>&gt; wrote:<br>
&gt; OMAP watchdong driver is adapted to runtime PM like a general device<b=
r>
&gt; driver but it is not appropriate. It is causing couple of functional<b=
r>
&gt; issues.<br>
&gt;<br>
&gt; 1. On OMAP4 SYSCLK can&#39;t be gated, because of issue with WDTIMER2 =
module,<br>
&gt; which constantly stays in &quot;in transition&quot; state. Value of re=
gister<br>
&gt; CM_WKUP_WDTIMER2_CLKCTRL is always 0x00010000 in this case.<br>
&gt; Issue occurs immediately after first idle, when hwmod framework tries<=
br>
&gt; to disable WDTIMER2 functional clock - &quot;wd_timer2_fck&quot;. Afte=
r this<br>
&gt; module falls to &quot;in transition&quot; state, and SYSCLK gating is =
blocked.<br>
&gt;<br>
&gt; 2. Due to runtime PM, watchdog timer may be completely disabled.<br>
&gt; In current code base watchdog timer is not disabled only because of<br=
>
&gt; issue 1. Otherwise state of WDTIMER2 module will be &quot;Disabled&quo=
t;, and there<br>
&gt; will be no interrupts from omap_wdt. In other words watchdog will not<=
br>
&gt; work at all.<br>
&gt;<br>
&gt; Watchdong is a special IP and it should not be disabled otherwise<br>
&gt; purpose of it itself is defeated. Watchdog functional clock should<br>
&gt; never be disabled. This patch updates the runtime PM handling in<br>
&gt; driver so that runtime PM is limited only during probe/shutdown<br>
&gt; and suspend/resume.<br>
&gt;<br>
&gt; The patch fixes issue 1 and 2<br>
&gt;<br>
&gt; Signed-off-by: Lokesh Vutla &lt;<a href=3D"mailto:lokeshvutla@ti.com">=
lokeshvutla@ti.com</a>&gt;<br>
&gt; Acked-by: Santosh Shilimkar &lt;<a href=3D"mailto:santosh.shilimkar@ti=
.com">santosh.shilimkar@ti.com</a>&gt;<br>
&gt; Cc: Wim Van Sebroeck &lt;<a href=3D"mailto:wim@iguana.be">wim@iguana.b=
e</a>&gt;<br>
&gt; ---<br>
&gt; Tested on OMAP4430SDP.<br>
&gt;<br>
&gt; Issue #1 can be easily reproduced on mainline kernel.<br>
&gt; - Take latest mainline kernel and create uImage using omap2plus_defcon=
fig<br>
&gt; - Write a program to open watchdog,like<br>
&gt; void main(void)<br>
&gt; {<br>
&gt; =A0 =A0 =A0 =A0int fd =3D open(&quot;/dev/watchdog&quot;, O_WRONLY);<b=
r>
&gt;<br>
&gt; =A0 =A0 =A0 =A0if (fd =3D=3D -1) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror(&quot;Watchdog device interface =
is not available!\n&quot;);<br>
&gt; =A0 =A0 =A0 =A0}<br>
&gt; }<br>
&gt; - Build with arm compiler and copy it to your file syatem<br>
&gt; - Boot the image and run the executable.<br>
&gt;<br>
&gt;<br>
&gt; =A0drivers/watchdog/omap_wdt.c | =A0 17 -----------------<br>
&gt; =A01 files changed, 0 insertions(+), 17 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c=
<br>
&gt; index 8285d65..27ab8db 100644<br>
&gt; --- a/drivers/watchdog/omap_wdt.c<br>
&gt; +++ b/drivers/watchdog/omap_wdt.c<br>
&gt; @@ -126,8 +126,6 @@ static void omap_wdt_set_timeout(struct omap_wdt_d=
ev *wdev)<br>
&gt; =A0 =A0 =A0 =A0u32 pre_margin =3D GET_WLDR_VAL(timer_margin);<br>
&gt; =A0 =A0 =A0 =A0void __iomem *base =3D wdev-&gt;base;<br>
&gt;<br>
&gt; - =A0 =A0 =A0 pm_runtime_get_sync(wdev-&gt;dev);<br>
&gt; -<br>
&gt; =A0 =A0 =A0 =A0/* just count up at 32 KHz */<br>
&gt; =A0 =A0 =A0 =A0while (__raw_readl(base + OMAP_WATCHDOG_WPS) &amp; 0x04=
)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();<br>
&gt; @@ -135,8 +133,6 @@ static void omap_wdt_set_timeout(struct omap_wdt_d=
ev *wdev)<br>
&gt; =A0 =A0 =A0 =A0__raw_writel(pre_margin, base + OMAP_WATCHDOG_LDR);<br>
&gt; =A0 =A0 =A0 =A0while (__raw_readl(base + OMAP_WATCHDOG_WPS) &amp; 0x04=
)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();<br>
&gt; -<br>
&gt; - =A0 =A0 =A0 pm_runtime_put_sync(wdev-&gt;dev);<br>
&gt; =A0}<br>
&gt;<br>
&gt; =A0/*<br>
&gt; @@ -166,8 +162,6 @@ static int omap_wdt_open(struct inode *inode, stru=
ct file *file)<br>
&gt; =A0 =A0 =A0 =A0omap_wdt_ping(wdev); /* trigger loading of new timeout =
value */<br>
&gt; =A0 =A0 =A0 =A0omap_wdt_enable(wdev);<br>
&gt;<br>
&gt; - =A0 =A0 =A0 pm_runtime_put_sync(wdev-&gt;dev);<br>
&gt; -<br>
&gt; =A0 =A0 =A0 =A0return nonseekable_open(inode, file);<br>
&gt; =A0}<br>
&gt;<br>
&gt; @@ -179,8 +173,6 @@ static int omap_wdt_release(struct inode *inode, s=
truct file *file)<br>
&gt; =A0 =A0 =A0 =A0 * =A0 =A0 =A0Shut off the timer unless NOWAYOUT is def=
ined.<br>
&gt; =A0 =A0 =A0 =A0 */<br>
&gt; =A0#ifndef CONFIG_WATCHDOG_NOWAYOUT<br>
&gt; - =A0 =A0 =A0 pm_runtime_get_sync(wdev-&gt;dev);<br>
&gt; -<br>
&gt; =A0 =A0 =A0 =A0omap_wdt_disable(wdev);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0pm_runtime_put_sync(wdev-&gt;dev);<br>
&gt; @@ -199,11 +191,9 @@ static ssize_t omap_wdt_write(struct file *file, =
const char __user *data,<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0/* Refresh LOAD_TIME. */<br>
&gt; =A0 =A0 =A0 =A0if (len) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(wdev-&gt;dev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock(&amp;wdt_lock);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_ping(wdev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&amp;wdt_lock);<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(wdev-&gt;dev);<br>
&gt; =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0 =A0 =A0return len;<br>
&gt; =A0}<br>
&gt; @@ -236,18 +226,15 @@ static long omap_wdt_ioctl(struct file *file, un=
signed int cmd,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(int __user *)arg);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return put_user(0, (int __user *)arg);<=
br>
&gt; =A0 =A0 =A0 =A0case WDIOC_KEEPALIVE:<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(wdev-&gt;dev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock(&amp;wdt_lock);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_ping(wdev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&amp;wdt_lock);<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(wdev-&gt;dev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;<br>
&gt; =A0 =A0 =A0 =A0case WDIOC_SETTIMEOUT:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (get_user(new_margin, (int __user *)=
arg))<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EFAULT;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_adjust_timeout(new_margin);<br=
>
&gt;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(wdev-&gt;dev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock(&amp;wdt_lock);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_disable(wdev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_set_timeout(wdev);<br>
&gt; @@ -255,7 +242,6 @@ static long omap_wdt_ioctl(struct file *file, unsi=
gned int cmd,<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_ping(wdev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&amp;wdt_lock);<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(wdev-&gt;dev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Fall */<br>
&gt; =A0 =A0 =A0 =A0case WDIOC_GETTIMEOUT:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return put_user(timer_margin, (int __us=
er *)arg);<br>
&gt; @@ -363,7 +349,6 @@ static void omap_wdt_shutdown(struct platform_devi=
ce *pdev)<br>
&gt; =A0 =A0 =A0 =A0struct omap_wdt_dev *wdev =3D platform_get_drvdata(pdev=
);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0if (wdev-&gt;omap_wdt_users) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(wdev-&gt;dev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_disable(wdev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_put_sync(wdev-&gt;dev);<br>
&gt; =A0 =A0 =A0 =A0}<br>
&gt; @@ -403,7 +388,6 @@ static int omap_wdt_suspend(struct platform_device=
 *pdev, pm_message_t state)<br>
&gt; =A0 =A0 =A0 =A0struct omap_wdt_dev *wdev =3D platform_get_drvdata(pdev=
);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0if (wdev-&gt;omap_wdt_users) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(wdev-&gt;dev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_disable(wdev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_put_sync(wdev-&gt;dev);<br>
&gt; =A0 =A0 =A0 =A0}<br>
&gt; @@ -419,7 +403,6 @@ static int omap_wdt_resume(struct platform_device =
*pdev)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_get_sync(wdev-&gt;dev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_enable(wdev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_wdt_ping(wdev);<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(wdev-&gt;dev);<br>
&gt; =A0 =A0 =A0 =A0}<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0return 0;<br>
&gt; --<br>
&gt; 1.7.5.4<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; linux-arm-kernel mailing list<br>
&gt; <a href=3D"mailto:linux-arm-kernel@lists.infradead.org">linux-arm-kern=
el@lists.infradead.org</a><br>
&gt; <a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kerne=
l" target=3D"_blank">http://lists.infradead.org/mailman/listinfo/linux-arm-=
kernel</a><br>
</blockquote></div><br>

--00235429cd5050481a04c3ab715e--


--===============1687735934677129137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1687735934677129137==--
