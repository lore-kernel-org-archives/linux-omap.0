From: Xiao Jiang <jgq516@gmail.com>
Subject: Re: [PATCH 1/1] ARM: add PROC_DEVICETREE support in Kconfig
Date: Sat, 7 Jul 2012 08:10:57 +0800
Message-ID: <CAERv70vi6-OanH2p9Db0jy-zLVVeNa+dfC04aYrsd_3m7OydLQ@mail.gmail.com>
References: <1341571127-14461-1-git-send-email-jgq516@gmail.com>
 <4FF6DCCA.2080509@gmail.com>
 <CAERv70uZMEoX4OcECssOrktVzC911tiSLXRH56TjyhQqVgNwBA@mail.gmail.com>
 <CAOesGMjmeXVx2MR7GGux9Cztkf-C3cBqpBW1_PW75D_Gk0GHiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3033496832178948443=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOesGMjmeXVx2MR7GGux9Cztkf-C3cBqpBW1_PW75D_Gk0GHiA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: linux@arm.linux.org.uk, arnd@arndb.de, tony@atomide.com, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, ldewangan@nvidia.com, swarren@nvidia.com, linux-omap@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org, hdoyu@nvidia.com
List-Id: linux-omap@vger.kernel.org

--===============3033496832178948443==
Content-Type: multipart/alternative; boundary=90e6ba6134f40b4e3b04c4323702

--90e6ba6134f40b4e3b04c4323702
Content-Type: text/plain; charset=ISO-8859-1

2012/7/7 Olof Johansson <olof@lixom.net>

> On Fri, Jul 6, 2012 at 4:15 PM, Xiao Jiang <jgq516@gmail.com> wrote:
> > 2012/7/6 Rob Herring <robherring2@gmail.com>
> >>
> >> On 07/06/2012 05:38 AM, jgq516@gmail.com wrote:
> >> > From: Xiao Jiang <jgq516@gmail.com>
> >> >
> >> > Since more and more arm chips support device tree, it'd be better add
> >> > PROC_DEVICETREE
> >> > in arch/arm/Kconfig to avoid duplicate code.
> >>
> >> I think this should remain user choice. If its going to be selected,
> >> then you might as well just remove the option altogether. Perhaps just
> >> make the option default to yes.
> >>
> > Hmm, sounds reasonable from your point. So the better choice is to set
> the
> > option default to Y if the board has dt support just like tegra_defconfig
> > and at91_dt_defconfig,  right? thanks.
>
> Why bother? If the defconfigs select it then most users basing their
> config from that will be just fine.
>
> PROC_DEVICETREE is 100% optional, it's useful to get runtime access to
> the contents of the device tree but it's not required for the kernel
> to boot.
>
> Got it, thanks.

Regards,
Xiao

>
> -Olof
>

--90e6ba6134f40b4e3b04c4323702
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2012/7/7 Olof Johansson <span dir=3D"ltr">&lt;<a href=3D"mailto:olof@lixom.=
net" target=3D"_blank">olof@lixom.net</a>&gt;</span><br><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Fri, Jul 6, 2012 at 4:15 PM, Xiao Jiang &lt;<a href=3D=
"mailto:jgq516@gmail.com">jgq516@gmail.com</a>&gt; wrote:<br>
&gt; 2012/7/6 Rob Herring &lt;<a href=3D"mailto:robherring2@gmail.com">robh=
erring2@gmail.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 07/06/2012 05:38 AM, <a href=3D"mailto:jgq516@gmail.com">jgq516=
@gmail.com</a> wrote:<br>
&gt;&gt; &gt; From: Xiao Jiang &lt;<a href=3D"mailto:jgq516@gmail.com">jgq5=
16@gmail.com</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Since more and more arm chips support device tree, it&#39;d b=
e better add<br>
&gt;&gt; &gt; PROC_DEVICETREE<br>
&gt;&gt; &gt; in arch/arm/Kconfig to avoid duplicate code.<br>
&gt;&gt;<br>
&gt;&gt; I think this should remain user choice. If its going to be selecte=
d,<br>
&gt;&gt; then you might as well just remove the option altogether. Perhaps =
just<br>
&gt;&gt; make the option default to yes.<br>
&gt;&gt;<br>
&gt; Hmm, sounds reasonable from your point. So the better choice is to set=
 the<br>
&gt; option default to Y if the board has dt support just like tegra_defcon=
fig<br>
&gt; and at91_dt_defconfig, =A0right? thanks.<br>
<br>
</div>Why bother? If the defconfigs select it then most users basing their<=
br>
config from that will be just fine.<br>
<br>
PROC_DEVICETREE is 100% optional, it&#39;s useful to get runtime access to<=
br>
the contents of the device tree but it&#39;s not required for the kernel<br=
>
to boot.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div>Got it, thanks.<br><br>Regards,<br>Xiao <br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888">
<br>
-Olof<br>
</font></span></blockquote></div><br>

--90e6ba6134f40b4e3b04c4323702--


--===============3033496832178948443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3033496832178948443==--
