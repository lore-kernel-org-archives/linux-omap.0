From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [GIT PULL] gpio/omap: final fixes for v3.5
Date: Fri, 6 Jul 2012 18:29:45 -0600
Message-ID: <CACxGe6v+67PEJrOk6K86WjcU055U_QrPU8e21ppKyn9Rfq36tQ@mail.gmail.com>
References: <87vci08npt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6147868586886055180=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87vci08npt.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6147868586886055180==
Content-Type: multipart/alternative; boundary=047d7b2ee2e949a3c704c4327a53

--047d7b2ee2e949a3c704c4327a53
Content-Type: text/plain; charset=ISO-8859-1

Hi Kevin,

Linus W. is handling picking up gpio stuff for me while I'm overloaded with
moving to the UK.

Linus, I typically pull from Kevin instead of applying the patches myself.

g.
 On Jul 6, 2012 5:38 PM, "Kevin Hilman" <khilman@ti.com> wrote:

> Hi Grant,
>
> Here's a couple (hopefully) final OMAP GPIO fixes for v3.5-rc.
>
> Thanks,
>
> Kevin
>
>
> The following changes since commit
> 6b16351acbd415e66ba16bf7d473ece1574cf0bc:
>
>   Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.gitfor_3.5/fixes/gpio-3
>
> for you to fetch changes up to 7b86cef34afceeecf57d4d07f3cfab06f8b60b13:
>
>   gpio/omap: fix invalid context restore of gpio bank-0 (2012-07-03
> 09:41:39 -0700)
>
> ----------------------------------------------------------------
> Grazvydas Ignotas (1):
>       gpio/omap: fix irq loss while in idle with debounce on
>
> Jon Hunter (1):
>       gpio/omap: fix invalid context restore of gpio bank-0
>
>  drivers/gpio/gpio-omap.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>

--047d7b2ee2e949a3c704c4327a53
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi Kevin,</p>
<p>Linus W. is handling picking up gpio stuff for me while I&#39;m overload=
ed with moving to the UK.</p>
<p>Linus, I typically pull from Kevin instead of applying the patches mysel=
f.</p>
<p>g.<br>
</p>
<div class=3D"gmail_quote">On Jul 6, 2012 5:38 PM, &quot;Kevin Hilman&quot;=
 &lt;<a href=3D"mailto:khilman@ti.com">khilman@ti.com</a>&gt; wrote:<br typ=
e=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Grant,<br>
<br>
Here&#39;s a couple (hopefully) final OMAP GPIO fixes for v3.5-rc.<br>
<br>
Thanks,<br>
<br>
Kevin<br>
<br>
<br>
The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc=
:<br>
<br>
=A0 Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)<br>
<br>
are available in the git repository at:<br>
<br>
=A0 git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/khilman=
/linux-omap-pm.git" target=3D"_blank">git.kernel.org/pub/scm/linux/kernel/g=
it/khilman/linux-omap-pm.git</a> for_3.5/fixes/gpio-3<br>
<br>
for you to fetch changes up to 7b86cef34afceeecf57d4d07f3cfab06f8b60b13:<br=
>
<br>
=A0 gpio/omap: fix invalid context restore of gpio bank-0 (2012-07-03 09:41=
:39 -0700)<br>
<br>
----------------------------------------------------------------<br>
Grazvydas Ignotas (1):<br>
=A0 =A0 =A0 gpio/omap: fix irq loss while in idle with debounce on<br>
<br>
Jon Hunter (1):<br>
=A0 =A0 =A0 gpio/omap: fix invalid context restore of gpio bank-0<br>
<br>
=A0drivers/gpio/gpio-omap.c | =A0 14 +++++++++++++-<br>
=A01 file changed, 13 insertions(+), 1 deletion(-)<br>
</blockquote></div>

--047d7b2ee2e949a3c704c4327a53--


--===============6147868586886055180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6147868586886055180==--
