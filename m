From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 1/7] remoteproc: resource table overhaul
Date: Tue, 22 May 2012 10:18:22 +0200
Message-ID: <CAHTX3dKKr5bjUKQVsaHhy41yjz8V-yyAWAbit73WgGEWFv4e2Q@mail.gmail.com>
References: <1330589497-4139-1-git-send-email-ohad@wizery.com>
 <1330589497-4139-2-git-send-email-ohad@wizery.com>
 <4F6354E4.8030704@monstr.eu>
 <CAK=Wgbbbi4GnuHedSh6cR1LhkZr8c9q6i=_TLSL252LpPB8Xsw@mail.gmail.com>
 <CAK=WgbYeQr5ZwTSBo+ZJUzN7fQ--0QbC8HSjrGT-Geycs4SKcg@mail.gmail.com>
 <CAHTX3d+=QTZo994jct6+pPqsCniG0B2a_9q6fLdGjvcbZ7qj_A@mail.gmail.com>
 <CAK=WgbahzGHmvszw6HBgihN4NcPA8ceaQCNSOk_FC61bToxBXQ@mail.gmail.com>
 <CAHTX3dK8rDomYqWvBX1ay200AmM1dBCYD3nJ2UYbzC_SSFankw@mail.gmail.com>
 <CAK=WgbYSrzTKW-QME4-r6XhVAQL0b6iWyus632KZOpfpTPgwWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2367586966458659470=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=WgbYSrzTKW-QME4-r6XhVAQL0b6iWyus632KZOpfpTPgwWg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Ludovic BARRE <ludovic.barre@stericsson.com>, Anna Suman <s-anna@ti.com>, Guzman Lugo Fernando <fernando.lugo@ti.com>, Arnd Bergmann <arnd@arndb.de>, Iliyan Malchev <malchev@google.com>, Brian Swetland <swetland@google.com>, Loic PALLARDY <loic.pallardy@stericsson.com>, Rusty Russell <rusty@rustcorp.com.au>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Saravana Kannan <skannan@codeaurora.org>, John Williams <john.williams@petalogix.com>, Clark Rob <rob@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-omap@vger.kernel.org, Kieran Bingham <kieranbingham@gmail.com>, Mark Grosen <mgrosen@ti.com>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

--===============2367586966458659470==
Content-Type: multipart/alternative; boundary=047d7b33d628741fbc04c09ba920

--047d7b33d628741fbc04c09ba920
Content-Type: text/plain; charset=ISO-8859-1

Hi Ohad,

2012/5/22 Ohad Ben-Cohen <ohad@wizery.com>

> Hi Michal,
>
> On Tue, May 22, 2012 at 8:51 AM, Michal Simek <monstr@monstr.eu> wrote:
> > Simple enabling RSC_VDEV in rproc_handle_rsc doesn't work.
>
> Sure - you'll need to actually plug the vrings allocation code there,
> too (i.e. this requires some coding, it's not a 1-liner).
>
> > BTW: I am using kernel modules and there is no dependency for
> > virtio_rpmsg_bus in remoteproc module
> > in sense if you load remoteproc module you also need to load
> > virtio_rpmsg_bus to get firmware to work.
>
> This is expected: remoteproc only provides means for booting and
> controlling remote processors and it doesn't boot them upfront.
>
> To actually boot a remote processor, and do something useful with it,
> one needs to load a module which utilizes remoteproc's API (e.g.
> virtio_rpmsg_bus, but YMMV).
>
> > ~ # lsmod
> > ~ # modprobe zynq_remoteproc
> > zynq_remoteproc: Unknown symbol rproc_register (err 0)
> > zynq_remoteproc: Unknown symbol rproc_alloc (err 0)
> > zynq_remoteproc: Unknown symbol rproc_vq_interrupt (err 0)
> > zynq_remoteproc: Unknown symbol rproc_free (err 0)
> > zynq_remoteproc: Unknown symbol rproc_unregister (err 0)
>
> We don't have these errors - have you tried looking into them ?
>

It is probably any problem with modules. If I load them in sequence
there is no error.


>
> Btw do you plan on submitting the code for zynq_remoteproc ?
>

It is still under developing and there are some core changes in ARM low
level code
which need to be applied to mainline before this driver. I haven't sent
these patches
to mainline for review but I expect they won't be accepted but maybe I am
wrong.


>
> > Can you see the same behavior on omap?
>
> Except the "Unknown symbol" errors, everything else looks good.
>

Ok. Good.

Thanks,
Michal

--047d7b33d628741fbc04c09ba920
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ohad,<br><br><div class=3D"gmail_quote">2012/5/22 Ohad Ben-Cohen <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:ohad@wizery.com" target=3D"_blank">ohad@wi=
zery.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Michal,<br>
<div class=3D"im"><br>
On Tue, May 22, 2012 at 8:51 AM, Michal Simek &lt;<a href=3D"mailto:monstr@=
monstr.eu">monstr@monstr.eu</a>&gt; wrote:<br>
&gt; Simple enabling RSC_VDEV in rproc_handle_rsc doesn&#39;t work.<br>
<br>
</div>Sure - you&#39;ll need to actually plug the vrings allocation code th=
ere,<br>
too (i.e. this requires some coding, it&#39;s not a 1-liner).<br>
<div class=3D"im"><br>
&gt; BTW: I am using kernel modules and there is no dependency for<br>
&gt; virtio_rpmsg_bus in remoteproc module<br>
&gt; in sense if you load remoteproc module you also need to load<br>
&gt; virtio_rpmsg_bus to get firmware to work.<br>
<br>
</div>This is expected: remoteproc only provides means for booting and<br>
controlling remote processors and it doesn&#39;t boot them upfront.<br>
<br>
To actually boot a remote processor, and do something useful with it,<br>
one needs to load a module which utilizes remoteproc&#39;s API (e.g.<br>
virtio_rpmsg_bus, but YMMV).<br>
<div class=3D"im"><br>
&gt; ~ # lsmod<br>
&gt; ~ # modprobe zynq_remoteproc<br>
&gt; zynq_remoteproc: Unknown symbol rproc_register (err 0)<br>
&gt; zynq_remoteproc: Unknown symbol rproc_alloc (err 0)<br>
&gt; zynq_remoteproc: Unknown symbol rproc_vq_interrupt (err 0)<br>
&gt; zynq_remoteproc: Unknown symbol rproc_free (err 0)<br>
&gt; zynq_remoteproc: Unknown symbol rproc_unregister (err 0)<br>
<br>
</div>We don&#39;t have these errors - have you tried looking into them ?<b=
r></blockquote><div><br>It is probably any problem with modules. If I load =
them in sequence<br>there is no error.<br>=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">

<br>
Btw do you plan on submitting the code for zynq_remoteproc ?<br></blockquot=
e><div><br>It is still under developing and there are some core changes in =
ARM low level code<br>which need to be applied to mainline before this driv=
er. I haven&#39;t sent these patches<br>
to mainline for review but I expect they won&#39;t be accepted but maybe I =
am wrong.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt=
 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"im"><br>
&gt; Can you see the same behavior on omap?<br>
<br>
</div>Except the &quot;Unknown symbol&quot; errors, everything else looks g=
ood.<br></blockquote><br></div>Ok. Good.<br><br>Thanks,<br>Michal<br><br>

--047d7b33d628741fbc04c09ba920--


--===============2367586966458659470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2367586966458659470==--
