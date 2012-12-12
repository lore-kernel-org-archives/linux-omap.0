From: =?UTF-8?Q?Adrien_Ferr=C3=A9?= <ferre.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] Fix sprz319 erratum 2.1
Date: Wed, 12 Dec 2012 03:19:26 -0800 (PST)
Message-ID: <8f4f87ed-61f7-44ee-9c74-0f57e0f6a930@googlegroups.com>
References: <4F4289C2.90707@kynesim.co.uk>
 <alpine.DEB.2.00.1202241419580.23504@utopia.booyaka.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_75_9961818.1355311166091"
Return-path: <beagleboard+bncBDB75T4YUEIBBPWQUGDAKGQEZTVAOVQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1202241419580.23504-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post?hl=en>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard?hl=en>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=en>, <mailto:beagleboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=en>,
 <mailto:googlegroups-manage+1035534660134+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Richard Watts <rrw-XQiHveOWqdgqdlJmJB21zg@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgpaul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

------=_Part_75_9961818.1355311166091
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi

We are facing this kind of issue on several beaglexm and panda es. We are=
=20
currently seting up a test case which is:

Heavy network traffic:

A ftp server on the LAN serving one file to all boards.
All boards download the file, remove it, redownload it, ...

Heavy usb traffic:

We have to USB-Serial adapters wired together at 115200 with RTS/CTS=20
enabled and serving a file to each other simultaneously.

We'll run the tests for a few days and I'll give the results here.

OCS: do you have results to provide for your tests please?

Le vendredi 24 f=E9vrier 2012 23:13:57 UTC+1, Paul Walmsley a =E9crit :
>
> cc'ing beagleboard list, Kevin
>
> Hi Richard,
>
> thanks for the patch.  A quick question for you or anyone else who is=20
> experiencing this problem.
>
> On Mon, 20 Feb 2012, Richard Watts wrote:
>
> > There is an erratum in DM3730 which results in the
> > EHCI USB PLL (DPLL5) not updating sufficiently frequently; this
> > leads to USB PHY clock drift and once the clock has drifted far
> > enough, the PHY's ULPI interface stops responding and USB
> > drops out. This is manifested on a Beagle xM by having the attached
> > SMSC9514 report 'Cannot enable port 2. Maybe the USB cable is bad?'
> > or similar.
> >=20
> > The fix is to carefully adjust your DPLL5 settings so as to
> > keep the PHY clock as close as possible to 120MHz over the long
> > term; TI SPRZ319e gives a table of such settings and this patch
> > applies that table to systems with a 13MHz or a 26MHz clock,
> > thus fixing the issue (inasfar as it can be fixed) on Beagle xM
> > and Overo Firestorm.
> >=20
> > Signed-off-by: Richard Watts <r...-XQiHveOWqdgqdlJmJB21zg@public.gmane.org <javascript:>>
>
> Funny, I just had a conversation with Kevin Hilman about needing to put=
=20
> the DPLL rate rounding code back in for the OPP tables.  This looks like=
=20
> another reason why...
>
> Could you, or anyone else who is experiencing this problem on a board wit=
h=20
> a 26MHz oscillator try a quick test for me?  I'm a little curious about=
=20
> the (M, N) of (443, 12) that SPRZ319E is recommending.  Could you see if=
=20
> your USB problems are also solved by using (480, 13) ?
>
> ...
>
> Here's the rationale.  Walking through the estimates here based on=20
> SPRZ319E, (443, 12) results in a frequency error of -166,667 Hz at the VC=
O=20
> output.  This is 174 ppm below the desired target rate of 960MHz.  But=20
> (480, 13) results in no frequency error.
>
> The downside of using (480, 13) is that the PLL update interval increases=
=20
> from 461 ns to 500 ns (+9%).  But if the long-term drift of the DPLL is=
=20
> downward, then starting at a -174 ppm error has removed 35% of the total=
=20
> margin (+/- 500 ppm).  This might be too na=EFve, but a downward drift,=
=20
> seems likely given that gate delay increases as temperature increases.
>
> Mainline is currently using (120, 13) which results in a VCO output=20
> frequency of 240MHz -- this presumably results in increased phase noise=
=20
> compared to (443, 12) and (480, 13) per SPRZ319E. =20
>
>
> - Paul
>
>

--=20
For more options, visit http://beagleboard.org/discuss



------=_Part_75_9961818.1355311166091
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<div><br></div><div>We are facing this kind of issue on several beaglexm =
and panda es. We are currently seting up a test case which is:</div><div><b=
r></div><div>Heavy network traffic:</div><div><br></div><div>A ftp server o=
n the LAN serving one file to all boards.</div><div>All boards download the=
 file, remove it, redownload it, ...<br></div><div><br></div><div>Heavy usb=
 traffic:</div><div><br></div><div>We have to USB-Serial adapters wired tog=
ether at 115200 with RTS/CTS enabled and serving a file to each other simul=
taneously.<br><br>We'll run the tests for a few days and I'll give the resu=
lts here.<br><br>OCS: do you have results to provide for your tests please?=
<br><br>Le vendredi 24 f=E9vrier 2012 23:13:57 UTC+1, Paul Walmsley a =E9cr=
it&nbsp;:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: =
0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">cc'ing beagleboard li=
st, Kevin<p>Hi Richard,</p><p>thanks for the patch. &nbsp;A quick question =
for you or anyone else who is <br>experiencing this problem.</p><p>On Mon, =
20 Feb 2012, Richard Watts wrote:</p><p>&gt; There is an erratum in DM3730 =
which results in the<br>&gt; EHCI USB PLL (DPLL5) not updating sufficiently=
 frequently; this<br>&gt; leads to USB PHY clock drift and once the clock h=
as drifted far<br>&gt; enough, the PHY's ULPI interface stops responding an=
d USB<br>&gt; drops out. This is manifested on a Beagle xM by having the at=
tached<br>&gt; SMSC9514 report 'Cannot enable port 2. Maybe the USB cable i=
s bad?'<br>&gt; or similar.<br>&gt; <br>&gt; The fix is to carefully adjust=
 your DPLL5 settings so as to<br>&gt; keep the PHY clock as close as possib=
le to 120MHz over the long<br>&gt; term; TI SPRZ319e gives a table of such =
settings and this patch<br>&gt; applies that table to systems with a 13MHz =
or a 26MHz clock,<br>&gt; thus fixing the issue (inasfar as it can be fixed=
) on Beagle xM<br>&gt; and Overo Firestorm.<br>&gt; <br>&gt; Signed-off-by:=
 Richard Watts &lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfuscated=
-mailto=3D"RoRpyZE_7dIJ">r...-XQiHveOWqdgqdlJmJB21zg@public.gmane.org</a>&gt;</p><p>Funny, I just had=
 a conversation with Kevin Hilman about needing to put <br>the DPLL rate ro=
unding code back in for the OPP tables. &nbsp;This looks like <br>another r=
eason why...</p><p>Could you, or anyone else who is experiencing this probl=
em on a board with <br>a 26MHz oscillator try a quick test for me? &nbsp;I'=
m a little curious about <br>the (M, N) of (443, 12) that SPRZ319E is recom=
mending. &nbsp;Could you see if <br>your USB problems are also solved by us=
ing (480, 13) ?</p><p>...</p><p>Here's the rationale. &nbsp;Walking through=
 the estimates here based on <br>SPRZ319E, (443, 12) results in a frequency=
 error of -166,667 Hz at the VCO <br>output. &nbsp;This is 174 ppm below th=
e desired target rate of 960MHz. &nbsp;But <br>(480, 13) results in no freq=
uency error.</p><p>The downside of using (480, 13) is that the PLL update i=
nterval increases <br>from 461 ns to 500 ns (+9%). &nbsp;But if the long-te=
rm drift of the DPLL is <br>downward, then starting at a -174 ppm error has=
 removed 35% of the total <br>margin (+/- 500 ppm). &nbsp;This might be too=
 na=EFve, but a downward drift, <br>seems likely given that gate delay incr=
eases as temperature increases.</p><p>Mainline is currently using (120, 13)=
 which results in a VCO output <br>frequency of 240MHz -- this presumably r=
esults in increased phase noise <br>compared to (443, 12) and (480, 13) per=
 SPRZ319E. &nbsp;</p><p><br>- Paul</p><p></p><p></p><p></p><p></p><p></p><p=
></p><p></p><p></p><p></p><p></p></blockquote></div>

<p></p>

-- <br />
For more options, visit <a href=3D"http://beagleboard.org/discuss">http://b=
eagleboard.org/discuss</a><br />
&nbsp;<br />
&nbsp;<br />

------=_Part_75_9961818.1355311166091--
