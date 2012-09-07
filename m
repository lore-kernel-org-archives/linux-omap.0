From: OCS <mickeyocs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] Fix sprz319 erratum 2.1
Date: Fri, 7 Sep 2012 04:34:12 -0700 (PDT)
Message-ID: <8243bbb9-7177-461f-8e39-c9934e81033e@googlegroups.com>
References: <4F4289C2.90707@kynesim.co.uk> <alpine.DEB.2.00.1202241419580.23504@utopia.booyaka.com>
 <alpine.DEB.2.00.1207121518240.25585@utopia.booyaka.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_651_5765332.1347017652418"
Return-path: <beagleboard+bncCMqPif7EDxC0t6eCBRoEOb4Xaw-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1207121518240.25585-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post?hl=en>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard?hl=en>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=en>,
 <mailto:googlegroups-manage+1035534660134+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Richard Watts <rrw-XQiHveOWqdgqdlJmJB21zg@public.gmane.org>, khilman-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

------=_Part_651_5765332.1347017652418
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi ,

Robert N provided me with a kernel that has the patch in it. It seems to=20
work in the test unit I have . Going to do more extensive tests* *next.=20

The board i have essentially never goes beyond a few hrs with camera=20
grabbing frames and ethernet activities going on. The cpu is constantly at=
=20
90+ percent. Many times it would even hit the usb reset problem in a just=
=20
few mins.=20

With the patch it seems to be running so far overnight.=20

If the extensive test fails, i would update the group again.=20

Thanks to Robert and Richard for the patch!

cheers,
CS

On Thursday, July 12, 2012 5:19:37 PM UTC-4, Paul Walmsley wrote:
>
> Hi,=20
>
> On Fri, 24 Feb 2012, Paul Walmsley wrote:=20
>
> > cc'ing beagleboard list, Kevin=20
> >=20
> > Hi Richard,=20
> >=20
> > thanks for the patch.  A quick question for you or anyone else who is=
=20
> > experiencing this problem.=20
> >=20
> > On Mon, 20 Feb 2012, Richard Watts wrote:=20
> >=20
> > > There is an erratum in DM3730 which results in the=20
> > > EHCI USB PLL (DPLL5) not updating sufficiently frequently; this=20
> > > leads to USB PHY clock drift and once the clock has drifted far=20
> > > enough, the PHY's ULPI interface stops responding and USB=20
> > > drops out. This is manifested on a Beagle xM by having the attached=
=20
> > > SMSC9514 report 'Cannot enable port 2. Maybe the USB cable is bad?'=
=20
> > > or similar.=20
> > >=20
> > > The fix is to carefully adjust your DPLL5 settings so as to=20
> > > keep the PHY clock as close as possible to 120MHz over the long=20
> > > term; TI SPRZ319e gives a table of such settings and this patch=20
> > > applies that table to systems with a 13MHz or a 26MHz clock,=20
> > > thus fixing the issue (inasfar as it can be fixed) on Beagle xM=20
> > > and Overo Firestorm.=20
> > >=20
> > > Signed-off-by: Richard Watts <r...-XQiHveOWqdgqdlJmJB21zg@public.gmane.org <javascript:>>=20
> >=20
> > Funny, I just had a conversation with Kevin Hilman about needing to put=
=20
> > the DPLL rate rounding code back in for the OPP tables.  This looks lik=
e=20
> > another reason why...=20
> >=20
> > Could you, or anyone else who is experiencing this problem on a board=
=20
> with=20
> > a 26MHz oscillator try a quick test for me?  I'm a little curious about=
=20
> > the (M, N) of (443, 12) that SPRZ319E is recommending.  Could you see i=
f=20
> > your USB problems are also solved by using (480, 13) ?=20
> >=20
> > ...=20
> >=20
> > Here's the rationale.  Walking through the estimates here based on=20
> > SPRZ319E, (443, 12) results in a frequency error of -166,667 Hz at the=
=20
> VCO=20
> > output.  This is 174 ppm below the desired target rate of 960MHz.  But=
=20
> > (480, 13) results in no frequency error.=20
> >=20
> > The downside of using (480, 13) is that the PLL update interval=20
> increases=20
> > from 461 ns to 500 ns (+9%).  But if the long-term drift of the DPLL is=
=20
> > downward, then starting at a -174 ppm error has removed 35% of the tota=
l=20
> > margin (+/- 500 ppm).  This might be too na=EFve, but a downward drift,=
=20
> > seems likely given that gate delay increases as temperature increases.=
=20
> >=20
> > Mainline is currently using (120, 13) which results in a VCO output=20
> > frequency of 240MHz -- this presumably results in increased phase noise=
=20
> > compared to (443, 12) and (480, 13) per SPRZ319E.  =20
>
> Just a quick followup on this.  Have you or anyone else out there tried=
=20
> this change?  Alternatively does someone out there have a test case that=
=20
> is simple to reproduce?  =20
>
>
> - Paul

-- To join: http://beagleboard.org/discuss
To unsubscribe from this group, send email to:
beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Frequently asked questions: http://beagleboard.org/faq

------=_Part_651_5765332.1347017652418
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi ,<br><br>Robert N provided me with a kernel that has the patch in it. It=
 seems to work in the test unit I have . Going to do more extensive tests<i=
> </i>next. <br><br>The board i have essentially never goes beyond a few hr=
s with camera grabbing frames and ethernet activities going on. The cpu is =
constantly at 90+ percent. Many times it would even hit the usb reset probl=
em in a just few mins. <br><br>With the patch it seems to be running so far=
 overnight. <br><br>If the extensive test fails, i would update the group a=
gain. <br><br>Thanks to Robert and Richard for the patch!<br><br>cheers,<br=
>CS<br><br>On Thursday, July 12, 2012 5:19:37 PM UTC-4, Paul Walmsley wrote=
:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;bo=
rder-left: 1px #ccc solid;padding-left: 1ex;">Hi,
<br>
<br>On Fri, 24 Feb 2012, Paul Walmsley wrote:
<br>
<br>&gt; cc'ing beagleboard list, Kevin
<br>&gt;=20
<br>&gt; Hi Richard,
<br>&gt;=20
<br>&gt; thanks for the patch. &nbsp;A quick question for you or anyone els=
e who is=20
<br>&gt; experiencing this problem.
<br>&gt;=20
<br>&gt; On Mon, 20 Feb 2012, Richard Watts wrote:
<br>&gt;=20
<br>&gt; &gt; There is an erratum in DM3730 which results in the
<br>&gt; &gt; EHCI USB PLL (DPLL5) not updating sufficiently frequently; th=
is
<br>&gt; &gt; leads to USB PHY clock drift and once the clock has drifted f=
ar
<br>&gt; &gt; enough, the PHY's ULPI interface stops responding and USB
<br>&gt; &gt; drops out. This is manifested on a Beagle xM by having the at=
tached
<br>&gt; &gt; SMSC9514 report 'Cannot enable port 2. Maybe the USB cable is=
 bad?'
<br>&gt; &gt; or similar.
<br>&gt; &gt;=20
<br>&gt; &gt; The fix is to carefully adjust your DPLL5 settings so as to
<br>&gt; &gt; keep the PHY clock as close as possible to 120MHz over the lo=
ng
<br>&gt; &gt; term; TI SPRZ319e gives a table of such settings and this pat=
ch
<br>&gt; &gt; applies that table to systems with a 13MHz or a 26MHz clock,
<br>&gt; &gt; thus fixing the issue (inasfar as it can be fixed) on Beagle =
xM
<br>&gt; &gt; and Overo Firestorm.
<br>&gt; &gt;=20
<br>&gt; &gt; Signed-off-by: Richard Watts &lt;<a href=3D"javascript:" targ=
et=3D"_blank" gdf-obfuscated-mailto=3D"n_3MwsKRcKwJ">r...-XQiHveOWqdgqdlJmJB21zg@public.gmane.org</a>=
&gt;
<br>&gt;=20
<br>&gt; Funny, I just had a conversation with Kevin Hilman about needing t=
o put=20
<br>&gt; the DPLL rate rounding code back in for the OPP tables. &nbsp;This=
 looks like=20
<br>&gt; another reason why...
<br>&gt;=20
<br>&gt; Could you, or anyone else who is experiencing this problem on a bo=
ard with=20
<br>&gt; a 26MHz oscillator try a quick test for me? &nbsp;I'm a little cur=
ious about=20
<br>&gt; the (M, N) of (443, 12) that SPRZ319E is recommending. &nbsp;Could=
 you see if=20
<br>&gt; your USB problems are also solved by using (480, 13) ?
<br>&gt;=20
<br>&gt; ...
<br>&gt;=20
<br>&gt; Here's the rationale. &nbsp;Walking through the estimates here bas=
ed on=20
<br>&gt; SPRZ319E, (443, 12) results in a frequency error of -166,667 Hz at=
 the VCO=20
<br>&gt; output. &nbsp;This is 174 ppm below the desired target rate of 960=
MHz. &nbsp;But=20
<br>&gt; (480, 13) results in no frequency error.
<br>&gt;=20
<br>&gt; The downside of using (480, 13) is that the PLL update interval in=
creases=20
<br>&gt; from 461 ns to 500 ns (+9%). &nbsp;But if the long-term drift of t=
he DPLL is=20
<br>&gt; downward, then starting at a -174 ppm error has removed 35% of the=
 total=20
<br>&gt; margin (+/- 500 ppm). &nbsp;This might be too na=EFve, but a downw=
ard drift,=20
<br>&gt; seems likely given that gate delay increases as temperature increa=
ses.
<br>&gt;=20
<br>&gt; Mainline is currently using (120, 13) which results in a VCO outpu=
t=20
<br>&gt; frequency of 240MHz -- this presumably results in increased phase =
noise=20
<br>&gt; compared to (443, 12) and (480, 13) per SPRZ319E. &nbsp;
<br>
<br>Just a quick followup on this. &nbsp;Have you or anyone else out there =
tried=20
<br>this change? &nbsp;Alternatively does someone out there have a test cas=
e that=20
<br>is simple to reproduce? &nbsp;
<br>
<br>
<br>- Paul</blockquote>

<p></p>

-- To join: <a href=3D"http://beagleboard.org/discuss">http://beagleboard.o=
rg/discuss</a><br />
To unsubscribe from this group, send email to:<br />
beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org<br />
Frequently asked questions: <a href=3D"http://beagleboard.org/faq">http://b=
eagleboard.org/faq</a><br />

------=_Part_651_5765332.1347017652418--
