From: "Gutierrez, Juan" <jgutierrez@ti.com>
Subject: Re: [PATCH] omap: remoteproc: set bootaddr support
Date: Tue, 11 Sep 2012 09:47:40 -0500
Message-ID: <CADVn9RHC7ikoxWkuTxEc56nP5CPvSp5KZtY_24NjwqtibCVDiw@mail.gmail.com>
References: <1345044348-19898-1-git-send-email-jgutierrez@ti.com>
 <CAK=Wgbb6EKS1YqR89y08stkwz3zFw786J3an2iDT+rKFWyo+5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0337123309216033626=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=Wgbb6EKS1YqR89y08stkwz3zFw786J3an2iDT+rKFWyo+5A@mail.gmail.com>
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
Cc: Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0337123309216033626==
Content-Type: multipart/alternative; boundary=047d7b343f061f186704c96e296d

--047d7b343f061f186704c96e296d
Content-Type: text/plain; charset=UTF-8

Cool. Thanks Ohad

On Tue, Sep 11, 2012 at 7:30 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:

> Hi Juan,
>
> On Wed, Aug 15, 2012 at 6:25 PM, Juan Gutierrez <jgutierrez@ti.com> wrote:
> > Some remote processors (like Omap4's DSP) need to explicitly
> > set a boot address from which they start executing code when
> > taken out of reset.
> >
> > Support for this has been added to remoteproc code through
> > a set_bootaddr function in the platform data which, if needed,
> > must be set according to the backend rproc.
> >
> > For omap4's dsp we can use the next control funtion:
> >
> >   .set_bootaddr  = omap_ctrl_write_dsp_boot_addr
> >
> > Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>
>
> Applied with slight changes to the commit log. Thanks!
>
> Ohad.
>



-- 
Thanks

juan gutierrez

--047d7b343f061f186704c96e296d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Cool. Thanks Ohad<br><br><div class=3D"gmail_quote">On Tue, Sep 11, 2012 at=
 7:30 AM, Ohad Ben-Cohen <span dir=3D"ltr">&lt;<a href=3D"mailto:ohad@wizer=
y.com" target=3D"_blank">ohad@wizery.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">

Hi Juan,<br>
<div class=3D"im"><br>
On Wed, Aug 15, 2012 at 6:25 PM, Juan Gutierrez &lt;<a href=3D"mailto:jguti=
errez@ti.com">jgutierrez@ti.com</a>&gt; wrote:<br>
&gt; Some remote processors (like Omap4&#39;s DSP) need to explicitly<br>
&gt; set a boot address from which they start executing code when<br>
&gt; taken out of reset.<br>
&gt;<br>
&gt; Support for this has been added to remoteproc code through<br>
&gt; a set_bootaddr function in the platform data which, if needed,<br>
&gt; must be set according to the backend rproc.<br>
&gt;<br>
&gt; For omap4&#39;s dsp we can use the next control funtion:<br>
&gt;<br>
&gt; =C2=A0 .set_bootaddr =C2=A0=3D omap_ctrl_write_dsp_boot_addr<br>
&gt;<br>
&gt; Signed-off-by: Juan Gutierrez &lt;<a href=3D"mailto:jgutierrez@ti.com"=
>jgutierrez@ti.com</a>&gt;<br>
<br>
</div>Applied with slight changes to the commit log. Thanks!<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Ohad.<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Thanks<div><br></div><div>juan gutierrez</div><br>

--047d7b343f061f186704c96e296d--


--===============0337123309216033626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0337123309216033626==--
