From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Tue, 15 Jan 2013 07:26:55 +0800
Message-ID: <CACTFLAMT2-6VRkNSO3OF6X=afTYKRz=JcDkYqqyZ4VNT5xBVkw@mail.gmail.com>
References: <1355481404-27695-1-git-send-email-zonque@gmail.com>
 <1355481404-27695-6-git-send-email-zonque@gmail.com>
 <CALF0-+UbqFF17X1Ok1s1AGKg6SBmvMc1mvjVuZb=Ej7xo+qcmA@mail.gmail.com>
 <20130114180602.GV14149@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8638351888129735540=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130114180602.GV14149-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, x0148406-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, avinashphilip-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============8638351888129735540==
Content-Type: multipart/alternative; boundary=e0cb4efe323e19e9b904d347fbff

--e0cb4efe323e19e9b904d347fbff
Content-Type: text/plain; charset=ISO-8859-1

On Jan 15, 2013 2:06 AM, "Tony Lindgren" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>
> * Ezequiel Garcia <elezegarcia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [121223 13:49]:
> > On Fri, Dec 14, 2012 at 7:36 AM, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > +
> > > +Example for an AM33xx board:
> > > +
> > > +       gpmc: gpmc@50000000 {
> > > +               compatible = "ti,am3352-gpmc";
> > > +               ti,hwmods = "gpmc";
> > > +               reg = <0x50000000 0x1000000>;
> > > +               interrupts = <100>;
> > > +               gpmc,num-cs = <8>;
> > > +               gpmc,num-waitpins = <2>;
> > > +               #address-cells = <2>;
> > > +               #size-cells = <1>;
> > > +               ranges = <0 0 0x08000000 0x2000>;       /* CS0: NAND
*/
> > > +
> > > +               nand@0,0 {
> > > +                       reg = <0 0 0>; /* CS0, offset 0 */
> >
> > I'm a bit confused by this: what are the other two values in "reg"?
> > I see you've only added a binding for CS.
> >
> > I've extended a bit on your work and added a binding to enable OneNAND
> > device on my IGEP board.
> >
> > I might send some patches in case anyone wants to give it a try.
>
> Daniel, should this be updated to just pass the CS?

No, as Rob pointed out earlier in a thread about this topic, the 'ranges'
feature will help doing the math for the offset calculation eventually, so
we need to pass all three values.

Regards,
Daniel

--e0cb4efe323e19e9b904d347fbff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Jan 15, 2013 2:06 AM, &quot;Tony Lindgren&quot; &lt;<a href=3D"mailto:to=
ny-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org">tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; * Ezequiel Garcia &lt;<a href=3D"mailto:elezegarcia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">elezega=
rcia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; [121223 13:49]:<br>
&gt; &gt; On Fri, Dec 14, 2012 at 7:36 AM, Daniel Mack &lt;<a href=3D"mailt=
o:zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +Example for an AM33xx board:<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; + =A0 =A0 =A0 gpmc: gpmc@50000000 {<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;ti,am3352=
-gpmc&quot;;<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D &quot;gpmc&quot;=
;<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt;0x50000000 0x10000=
00&gt;;<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D &lt;100&gt;;<br=
>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc,num-cs =3D &lt;8&gt;;<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc,num-waitpins =3D &lt;2&gt=
;;<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D &lt;2&gt;;<=
br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D &lt;1&gt;;<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D &lt;0 0 0x08000000 =
0x2000&gt;; =A0 =A0 =A0 /* CS0: NAND */<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nand@0,0 {<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt;0 =
0 0&gt;; /* CS0, offset 0 */<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m a bit confused by this: what are the other two values in =
&quot;reg&quot;?<br>
&gt; &gt; I see you&#39;ve only added a binding for CS.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;ve extended a bit on your work and added a binding to enabl=
e OneNAND<br>
&gt; &gt; device on my IGEP board.<br>
&gt; &gt;<br>
&gt; &gt; I might send some patches in case anyone wants to give it a try.<=
br>
&gt;<br>
&gt; Daniel, should this be updated to just pass the CS?</p>
<p dir=3D"ltr">No, as Rob pointed out earlier in a thread about this topic,=
 the &#39;ranges&#39; feature will help doing the math for the offset calcu=
lation eventually, so we need to pass all three values.</p>
<p dir=3D"ltr">Regards,<br>
Daniel<br>
</p>

--e0cb4efe323e19e9b904d347fbff--

--===============8638351888129735540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8638351888129735540==--
