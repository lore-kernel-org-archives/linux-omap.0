From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] Input: omap4-keypad: Remove the OMAP4_KBD_SYSCONFIG and
 OMAP4_KBD_SYSSTATUS
Date: Tue, 27 Nov 2012 10:46:12 +0530
Message-ID: <CAM=Q2cuU4J81s9E3o95MTFcp0fnbrrn-p65qGiJFOQTsiT-oqg@mail.gmail.com>
References: <1353927079-12493-1-git-send-email-shubhrajyoti@ti.com>
 <20121126180158.GD14623@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1982186891070239172=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121126180158.GD14623@core.coreip.homeip.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============1982186891070239172==
Content-Type: multipart/alternative; boundary=14dae934090107f91404cf7326f9

--14dae934090107f91404cf7326f9
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Nov 26, 2012 at 11:31 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com
> wrote:

> On Mon, Nov 26, 2012 at 04:21:19PM +0530, Shubhrajyoti D wrote:
> > The macros OMAP4_KBD_SYSSTATUS and OMAP4_KBD_SYSSTATUS are not used
> > so remove them.
>
> They document the existing registers and do not add bloat to the
> generated objects so let's leave them be.
>

The objective of the patch is not to prevent bloat.

Actually these registers have power/system impact so it was decided that
the drivers will not
configure the sysc registers (infact not define). Currently hwmod
configures the registers.

To be safe I thought of deleting it.


> Thanks.
>

--14dae934090107f91404cf7326f9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Nov 26, 2012 at 11:31 PM, Dmitry=
 Torokhov <span dir=3D"ltr">&lt;<a href=3D"mailto:dmitry.torokhov@gmail.com=
" target=3D"_blank">dmitry.torokhov@gmail.com</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<div class=3D"im">On Mon, Nov 26, 2012 at 04:21:19PM +0530, Shubhrajyoti D =
wrote:<br>
&gt; The macros OMAP4_KBD_SYSSTATUS and OMAP4_KBD_SYSSTATUS are not used<br=
>
&gt; so remove them.<br>
<br>
</div>They document the existing registers and do not add bloat to the<br>
generated objects so let&#39;s leave them be.<br></blockquote><div><br>The =
objective of the patch is not to prevent bloat. <br></div><div><br>Actually=
 these registers have power/system impact so it was decided that the driver=
s will not<br>
configure the sysc registers (infact not define). Currently hwmod configure=
s the registers.<br><br>To be safe I thought of deleting it.<br><br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">

<br>
Thanks.<div class=3D"yj6qo ajU"><div id=3D":yy" class=3D"ajR" tabindex=3D"0=
"><img class=3D"ajT" src=3D"https://mail.google.com/mail/u/0/images/cleardo=
t.gif"></div></div></blockquote></div><br>

--14dae934090107f91404cf7326f9--


--===============1982186891070239172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1982186891070239172==--
