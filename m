From: Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] arm: dts: Add uart1 and uart2 to igep boards.
Date: Sat, 26 Jan 2013 16:56:57 +0100
Message-ID: <CAAwP0s01Jxh0f-T0sd5D980dZPcEV0J1KzjPbNHkrXLaKA3YUg@mail.gmail.com>
References: <1355326422-12357-1-git-send-email-matthias.bgg@gmail.com>
 <50C8AC3C.9020908@ti.com>
 <CABuKBeJsHCq98Pe-BwPajbQ+2OLQpwrbtVTJe=j9thPDQCCBrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5052716075240598713=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CABuKBeJsHCq98Pe-BwPajbQ+2OLQpwrbtVTJe=j9thPDQCCBrg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org" <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, "ebutera-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ebutera-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--===============5052716075240598713==
Content-Type: multipart/alternative; boundary=f46d044630d2fd129704d4331700

--f46d044630d2fd129704d4331700
Content-Type: text/plain; charset=UTF-8

On Sat, Jan 26, 2013 at 4:16 PM, Matthias Brugger
<matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<javascript:;>>
wrote:
> Hi Benoit,
>
> 2012/12/12 Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org <javascript:;>>:
>> Hi Matthias,
>>
>> On 12/12/2012 04:33 PM, Matthias Brugger wrote:
>>> This patch is a follow-up patch for Javier Martinez effort adding
initial
>>> device tree support to IGEP technology devices. [1]
>>>
>>> It adds uart1 and uart2 bindings to the generic dtsi for the IGEP
boards.
>>>
>>> [1] http://www.spinics.net/lists/linux-omap/msg83409.html
>>>
>>> Signed-off-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:;>>
>>> ---
>>>  arch/arm/boot/dts/omap3-igep.dtsi |   24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi
b/arch/arm/boot/dts/omap3-igep.dtsi
>>> index 125fe00..c02e3c0 100644
>>> --- a/arch/arm/boot/dts/omap3-igep.dtsi
>>> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
>>> @@ -27,6 +27,20 @@
>>>  };
>>>
>>>  &omap3_pmx_core {
>>> +     uart1_pins: pinmux_uart1_pins {
>>> +             pinctrl-single,pins = <
>>> +                     0x152 0x100     /* uart1_rx.uart1_rx INPUT |
MODE0 */
>>> +                     0x14c 0         /* uart1_tx.uart1_tx OUTPUT |
MODE0 */
>>> +             >;
>>> +     };
>>> +
>>> +     uart2_pins: pinmux_uart2_pins {
>>> +             pinctrl-single,pins = <
>>> +                     0x14a 0x100     /* uart2_rx.uart2_rx INPUT |
MODE0 */
>>> +                     0x148 0         /* uart2_tx.uart2_tx OUTPUT |
MODE0 */
>>> +             >;
>>> +     };
>>> +
>>>       uart3_pins: pinmux_uart3_pins {
>>>               pinctrl-single,pins = <
>>>                       0x16e 0x100     /* uart3_rx.uart3_rx INPUT |
MODE0 */
>>> @@ -77,6 +91,16 @@
>>>       status = "disabled";
>>>  };
>>>
>>> +&uart1 {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&uart1_pins>;
>>> +};
>>> +
>>> +&uart2 {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&uart2_pins>;
>>> +};
>>> +
>>>  &uart3 {
>>>         pinctrl-names = "default";
>>>         pinctrl-0 = <&uart3_pins>;
>>>
>>
>> That looks good to me. I'll apply it on top of javier's series for 3.9.
>
> Can you pin-point me to the repository where this patches are in right
> now? I tried to figure it out these days, but didn't found where to
> clone the repository from.
>
> Thanks,
> Matthias
>

Hi Matthias,

OMAP DT tree is: git://
git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git

Hope it helps,
Javier

--f46d044630d2fd129704d4331700
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 26, 2013 at 4:16 PM, Matthias Brugger &lt;<a href=3D"javascript=
:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&#39;)"=
>matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; Hi Benoit,<br>
&gt;<br>
&gt; 2012/12/12 Benoit Cousson &lt;<a href=3D"javascript:;" onclick=3D"_e(e=
vent, &#39;cvml&#39;, &#39;b-cousson-l0cyMroinI0@public.gmane.org&#39;)">b-cousson-l0cyMroinI0@public.gmane.org</a>&gt;=
:<br>
&gt;&gt; Hi Matthias,<br>
&gt;&gt;<br>
&gt;&gt; On 12/12/2012 04:33 PM, Matthias Brugger wrote:<br>
&gt;&gt;&gt; This patch is a follow-up patch for Javier Martinez effort add=
ing initial<br>
&gt;&gt;&gt; device tree support to IGEP technology devices. [1]<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; It adds uart1 and uart2 bindings to the generic dtsi for the I=
GEP boards.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [1] <a href=3D"http://www.spinics.net/lists/linux-omap/msg8340=
9.html" target=3D"_blank">http://www.spinics.net/lists/linux-omap/msg83409.=
html</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Matthias Brugger &lt;<a href=3D"javascript:;" o=
nclick=3D"_e(event, &#39;cvml&#39;, &#39;matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&#39;)">matt=
hias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; =C2=A0arch/arm/boot/dts/omap3-igep.dtsi | =C2=A0 24 ++++++++++=
++++++++++++++<br>
&gt;&gt;&gt; =C2=A01 file changed, 24 insertions(+)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot=
/dts/omap3-igep.dtsi<br>
&gt;&gt;&gt; index 125fe00..c02e3c0 100644<br>
&gt;&gt;&gt; --- a/arch/arm/boot/dts/omap3-igep.dtsi<br>
&gt;&gt;&gt; +++ b/arch/arm/boot/dts/omap3-igep.dtsi<br>
&gt;&gt;&gt; @@ -27,6 +27,20 @@<br>
&gt;&gt;&gt; =C2=A0};<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0&amp;omap3_pmx_core {<br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 uart1_pins: pinmux_uart1_pins {<br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinctrl-single,pin=
s =3D &lt;<br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x152 0x100 =C2=A0 =C2=A0 /* uart1_rx.uart1_rx INPUT | MODE0 */<=
br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x14c 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* uart1_tx.uart1_tx OUTPUT =
| MODE0 */<br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;;<br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 };<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 uart2_pins: pinmux_uart2_pins {<br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinctrl-single,pin=
s =3D &lt;<br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x14a 0x100 =C2=A0 =C2=A0 /* uart2_rx.uart2_rx INPUT | MODE0 */<=
br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x148 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* uart2_tx.uart2_tx OUTPUT =
| MODE0 */<br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;;<br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 };<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 uart3_pins: pinmux_uart3_pins {<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinctrl-singl=
e,pins =3D &lt;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0x16e 0x100 =C2=A0 =C2=A0 /* uart3_rx.uart3_rx INPUT | MODE0=
 */<br>
&gt;&gt;&gt; @@ -77,6 +91,16 @@<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 status =3D &quot;disabled&quot;;<br>
&gt;&gt;&gt; =C2=A0};<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +&amp;uart1 {<br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 pinctrl-names =3D &quot;default&quot;;<=
br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 pinctrl-0 =3D &lt;&amp;uart1_pins&gt;;<=
br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +&amp;uart2 {<br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 pinctrl-names =3D &quot;default&quot;;<=
br>
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 pinctrl-0 =3D &lt;&amp;uart2_pins&gt;;<=
br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; =C2=A0&amp;uart3 {<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinctrl-names =3D &quot;default&qu=
ot;;<br>
&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 pinctrl-0 =3D &lt;&amp;uart3_pins&=
gt;;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; That looks good to me. I&#39;ll apply it on top of javier&#39;s se=
ries for 3.9.<br>
&gt;<br>
&gt; Can you pin-point me to the repository where this patches are in right=
<br>
&gt; now? I tried to figure it out these days, but didn&#39;t found where t=
o<br>
&gt; clone the repository from.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Matthias<br>
&gt;<br>
<br>
Hi Matthias,<br>
<br>
OMAP DT tree <span></span>is: git://<a href=3D"http://git.kernel.org/pub/sc=
m/linux/kernel/git/bcousson/linux-omap-dt.git" target=3D"_blank">git.kernel=
.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git</a><br>
<br>
Hope it helps,<br>
Javier<br>

--f46d044630d2fd129704d4331700--

--===============5052716075240598713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5052716075240598713==--
