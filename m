From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH 1/2 v3] OMAP2+: hwmod: Add API to enable IO ring wakeup.
Date: Wed, 11 May 2011 09:46:16 +0530
Message-ID: <BANLkTimfvKnkKx=bOhQ1iOzd-ZaV91Kugg@mail.gmail.com>
References: <1305023405-9561-1-git-send-email-govindraj.raja@ti.com>
	<1305023405-9561-2-git-send-email-govindraj.raja@ti.com>
	<BANLkTikVKV6DcuQ7nVHm=L_+hqeYjcyv0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0045645009=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTikVKV6DcuQ7nVHm=L_+hqeYjcyv0g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0045645009==
Content-Type: multipart/alternative; boundary=0022152d68bda5b68b04a2f8567c

--0022152d68bda5b68b04a2f8567c
Content-Type: text/plain; charset=ISO-8859-1

On Tue, May 10, 2011 at 9:34 PM, Todd Poynor <toddpoynor@google.com> wrote:

> On Tue, May 10, 2011 at 3:30 AM, Govindraj.R <govindraj.raja@ti.com>wrote:
> ...
>
>> +/**
>> + * omap_device_enable_ioring_wakeup - Set wakeup bit for iopad ring.
>> + * @pdev: platform_device for which wakeup needs to be set.
>> + *
>> + * Caller should ensure this is called if device_may_wakeup(dev) is true
>> + * traverse through each hwmod and check each available pads
>> + * if pad is enabled then set wakeup enable flag for the mux pin.
>> + * Return error if pads are not enabled or not available.
>> + * Wakeup enable flag will be we used during hwmod idle transistion.
>> + */
>> +int omap_device_enable_ioring_wakeup(struct platform_device *pdev)
>> +{
>> +       int ret = -EINVAL, i;
>> +       struct omap_device *od;
>> +       struct omap_hwmod *oh;
>> +
>> +       od = _find_by_pdev(pdev);
>> +       for (i = 0; i < od->hwmods_cnt; i++) {
>> +               oh = od->hwmods[i];
>> +               ret = omap_hwmod_enable_ioring_wakeup(oh);
>> +       }
>> +
>> +       return ret;
>>
>
> Error returns from all but the last hwmod are discarded.  If the error
> returns are meaningful and need corrective action (or warning messages) by
> callers then these should be preserved.
>

Actually here we either consider whether dynamic_io_pad was available for
enabling wakeup
or whether its never available for given hwmod. So thats the reason we are
not preserving ret,
also wakeup capability will be dependent on wakeup enable flag and remux
flag which will set
during hwmod_iopad initialisation which takes static structures for all
pads.

--
Govindraj.R



> ...
>
> Todd
>
>

--0022152d68bda5b68b04a2f8567c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Tue, May 10, 2011 at 9:34 PM, Todd Poynor=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:toddpoynor@google.com">toddpoynor@=
google.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div class=3D"gmail_quote">On Tue, May 10, 2011 at 3:30 AM, Govindraj.R <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:govindraj.raja@ti.com" target=3D"_blan=
k">govindraj.raja@ti.com</a>&gt;</span> wrote:</div><div class=3D"gmail_quo=
te">...<div class=3D"im">

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">

+/**<br>
+ * omap_device_enable_ioring_wakeup - Set wakeup bit for iopad ring.<br>
+ * @pdev: platform_device for which wakeup needs to be set.<br>
+ *<br>
+ * Caller should ensure this is called if device_may_wakeup(dev) is true<b=
r>
+ * traverse through each hwmod and check each available pads<br>
+ * if pad is enabled then set wakeup enable flag for the mux pin.<br>
+ * Return error if pads are not enabled or not available.<br>
+ * Wakeup enable flag will be we used during hwmod idle transistion.<br>
+ */<br>
+int omap_device_enable_ioring_wakeup(struct platform_device *pdev)<br>
+{<br>
+ =A0 =A0 =A0 int ret =3D -EINVAL, i;<br>
+ =A0 =A0 =A0 struct omap_device *od;<br>
+ =A0 =A0 =A0 struct omap_hwmod *oh;<br>
+<br>
+ =A0 =A0 =A0 od =3D _find_by_pdev(pdev);<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; od-&gt;hwmods_cnt; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh =3D od-&gt;hwmods[i];<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hwmod_enable_ioring_wakeup(oh);<=
br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return ret;<br></blockquote><div><br></div></div><div>Error r=
eturns from all but the last hwmod are discarded. =A0If the error returns a=
re meaningful and need corrective action (or warning messages) by callers t=
hen these should be preserved.</div>

</div></blockquote><div><br></div><div>Actually=A0here we either consider w=
hether dynamic_io_pad was=A0available=A0for enabling wakeup</div><div>or wh=
ether its never=A0available=A0for given hwmod.=A0So thats the reason we are=
 not preserving ret,=A0</div>

<div>also wakeup capability will be dependent=A0on wakeup enable flag and r=
emux flag which will set</div><div>during hwmod_iopad initialisation which=
=A0takes static structures for all pads.</div><div><br></div><div>--</div><=
div>

Govindraj.R=A0</div><div><br></div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex;"><div class=3D"gmail_quote">
<div><br></div><div>...</div><div><br></div><div>Todd</div><div>=A0</div></=
div>
</blockquote></div><br>

--0022152d68bda5b68b04a2f8567c--


--===============0045645009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0045645009==--
