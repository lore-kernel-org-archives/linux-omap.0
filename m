From: Michal Bachraty <michal.bachraty@gmail.com>
Subject: Re: [PATCH] am33xx: cpsw: default to ethernet hwaddr from efuse if
 not defined in dt
Date: Fri, 18 Jan 2013 09:23:14 +0100
Message-ID: <CAAfrEwaDd5CU5fd2TbSD-8dMdOrCeC8f5LxPUGfqUsRs69BV+Q@mail.gmail.com>
References: <1358370073-32545-1-git-send-email-jacmet@sunsite.dk>
 <loom.20130117T105358-639@post.gmane.org>
 <87a9s7lq09.fsf@dell.be.48ers.dk>
 <20130117174528.GM14149@atomide.com>
 <871udjlafn.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5338342365772902963=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <871udjlafn.fsf@dell.be.48ers.dk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============5338342365772902963==
Content-Type: multipart/alternative; boundary=e89a8f3b9e8f9f238e04d38bd2d2

--e89a8f3b9e8f9f238e04d38bd2d2
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jan 17, 2013 at 11:19 PM, Peter Korsgaard <jacmet@sunsite.dk> wrote:

> >>>>> "Tony" == Tony Lindgren <tony@atomide.com> writes:
>
> Hi,
>
>  >> The way I've handled it is similar to how it is done on atleast one
>  >> other arm subarchicture, see
>  >> arch/arm/mach-mxs/mach-mxs.c::update_fec_mac_prop()
>
>  Tony> Cool this seems like the cleanest way to deal with it so far. Can
>  Tony> you please resend with also linux-net and DT list Cc:d too?
>
>  Tony> Also the arch_initcall should be omap_arch_initcall in linux next
>  Tony> for consistency if we ever have SoC specific sections for those.
>
> Sure, resent with the initcall change and netdev/devicetree-discuss added.
>
> --
> Bye, Peter Korsgaard
>

Thanks,
I added DT option mac-address-source because there is still possiblility to
have mac address set by the u-boot in the future. Beaglebone have special
eeprom on board, were you can have stored user MAC and u-boot can read
eeprom
data. Maybe some users will want this feature.  Also in cpsw dt binding
documentation, there is mention  /* Filled in by U-Boot */.  For that
purpose,
code I proposed can easily deal with any driver exteds.

Reading CPU mac address registers with (my approach) or without (your
approach) DT should be more discussed. Also your way seems to be fine.

Regards
Michal

--e89a8f3b9e8f9f238e04d38bd2d2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Jan 17, 2013 at 11:19 PM, Peter =
Korsgaard <span dir=3D"ltr">&lt;<a href=3D"mailto:jacmet@sunsite.dk" target=
=3D"_blank">jacmet@sunsite.dk</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
&gt;&gt;&gt;&gt;&gt; &quot;Tony&quot; =3D=3D Tony Lindgren &lt;<a href=3D"m=
ailto:tony@atomide.com">tony@atomide.com</a>&gt; writes:<br>
<br>
Hi,<br>
<div class=3D"im"><br>
=A0&gt;&gt; The way I&#39;ve handled it is similar to how it is done on atl=
east one<br>
=A0&gt;&gt; other arm subarchicture, see<br>
=A0&gt;&gt; arch/arm/mach-mxs/mach-mxs.c::update_fec_mac_prop()<br>
<br>
</div>=A0Tony&gt; Cool this seems like the cleanest way to deal with it so =
far. Can<br>
=A0Tony&gt; you please resend with also linux-net and DT list Cc:d too?<br>
<br>
=A0Tony&gt; Also the arch_initcall should be omap_arch_initcall in linux ne=
xt<br>
=A0Tony&gt; for consistency if we ever have SoC specific sections for those=
.<br>
<br>
Sure, resent with the initcall change and netdev/devicetree-discuss added.<=
br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Bye, Peter Korsgaard<br>
</font></span></blockquote></div><br>Thanks,<br>I added DT option mac-addre=
ss-source because there is still possiblility to <br>have mac address set b=
y the u-boot in the future. Beaglebone have special <br>eeprom on board, we=
re you can have stored user MAC and u-boot can read eeprom <br>
data. Maybe some users will want this feature.=A0 Also in cpsw dt binding <=
br>documentation, there is mention=A0 /* Filled in by U-Boot */.=A0 For tha=
t purpose, <br>code I proposed can easily deal with any driver exteds. <br>=
<br>
Reading CPU mac address registers with (my approach) or without (your <br>a=
pproach) DT should be more discussed. Also your way seems to be fine. <br><=
br>Regards<br>Michal<br>

--e89a8f3b9e8f9f238e04d38bd2d2--


--===============5338342365772902963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5338342365772902963==--
