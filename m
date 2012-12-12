From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 05/12] ARM: OMAP3xxx: PM: convert to use the functional
 power states API
Date: Wed, 12 Dec 2012 11:18:23 +0100
Message-ID: <CAORVsuXaVZL3u5eGDVG+pmec+zCUZip6JBWoUUQzt_9itkezLg@mail.gmail.com>
References: <20121209174545.6933.59371.stgit@dusk.lan>
 <20121209175312.6933.92995.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3798201257144335915=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121209175312.6933.92995.stgit@dusk.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============3798201257144335915==
Content-Type: multipart/alternative; boundary=e89a8f502f8e4cc85204d0a51e36

--e89a8f502f8e4cc85204d0a51e36
Content-Type: text/plain; charset=ISO-8859-1

Paul,

On Sun, Dec 9, 2012 at 6:53 PM, Paul Walmsley <paul@pwsan.com> wrote:

> From: Jean Pihet <jean.pihet@newoldbits.com>
>
> Use the functional power states as the API to control power domains:
>
> - use the PWRDM_FUNC_PWRST_* macros for the power states and logic
>   settings,
>
> - the function pwrdm_set_next_fpwrst(), which controls the power domains
>   next power and logic settings, shall be used instead of
>   pwrdm_set_next_pwrst() to program the power domains next states,
>
> - the function pwrdm_set_fpwrst(), which programs the power domains
>   power and logic settings, shall be used instead of
>   omap_set_pwrdm_state().
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> [paul@pwsan.com: split the original patch into OMAP2/3/4 variants;
>  clean up omap3_save_secure_ram_context(); fix commit message;
>  warn if sets fail; various other changes]
>

There are a lot of 'XXX' comments, can this be fixed by a proper comment?

Regards,
Jean


> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   95 ++++++++++++-----------
>  arch/arm/mach-omap2/pm.h          |    2
>  arch/arm/mach-omap2/pm34xx.c      |  156
> +++++++++++++++++++------------------
>  3 files changed, 130 insertions(+), 123 deletions(-)
>
>
>

--e89a8f502f8e4cc85204d0a51e36
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Paul,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sun, =
Dec 9, 2012 at 6:53 PM, Paul Walmsley <span dir=3D"ltr">&lt;<a href=3D"mail=
to:paul@pwsan.com" target=3D"_blank">paul@pwsan.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
From: Jean Pihet &lt;<a href=3D"mailto:jean.pihet@newoldbits.com">jean.pihe=
t@newoldbits.com</a>&gt;<br>
<br>
Use the functional power states as the API to control power domains:<br>
<br>
- use the PWRDM_FUNC_PWRST_* macros for the power states and logic<br>
=A0 settings,<br>
<br>
- the function pwrdm_set_next_fpwrst(), which controls the power domains<br=
>
=A0 next power and logic settings, shall be used instead of<br>
=A0 pwrdm_set_next_pwrst() to program the power domains next states,<br>
<br>
- the function pwrdm_set_fpwrst(), which programs the power domains<br>
=A0 power and logic settings, shall be used instead of<br>
=A0 omap_set_pwrdm_state().<br>
<br>
Signed-off-by: Jean Pihet &lt;<a href=3D"mailto:j-pihet@ti.com">j-pihet@ti.=
com</a>&gt;<br>
[<a href=3D"mailto:paul@pwsan.com">paul@pwsan.com</a>: split the original p=
atch into OMAP2/3/4 variants;<br>
=A0clean up omap3_save_secure_ram_context(); fix commit message;<br>
=A0warn if sets fail; various other changes]<br></blockquote><div><br>There=
 are a lot of &#39;XXX&#39; comments, can this be fixed by a proper comment=
?<br><br>Regards,<br>Jean<br>=A0<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

Signed-off-by: Paul Walmsley &lt;<a href=3D"mailto:paul@pwsan.com">paul@pws=
an.com</a>&gt;<br>
---<br>
=A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 95 ++++++++++++-----------<br>
=A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0| =A0 =A02<br>
=A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0156 +++++++++++++++++++----=
--------------<br>
=A03 files changed, 130 insertions(+), 123 deletions(-)<br>
<br>
<br>
</blockquote></div><br></div>

--e89a8f502f8e4cc85204d0a51e36--


--===============3798201257144335915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3798201257144335915==--
