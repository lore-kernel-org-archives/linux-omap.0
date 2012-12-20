From: =?UTF-8?Q?Adrien_Ferr=C3=A9?= <ferre.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] Fix sprz319 erratum 2.1
Date: Thu, 20 Dec 2012 06:51:59 -0800 (PST)
Message-ID: <d94a4cfd-538c-481c-aa8f-26a730739ac5@googlegroups.com>
References: <4F4289C2.90707@kynesim.co.uk>
 <alpine.DEB.2.00.1202241419580.23504@utopia.booyaka.com>
 <8f4f87ed-61f7-44ee-9c74-0f57e0f6a930@googlegroups.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1411_6210662.1356015119273"
Return-path: <beagleboard+bncBDB75T4YUEIBBEGMZSDAKGQE2JY6DAQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <8f4f87ed-61f7-44ee-9c74-0f57e0f6a930-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

------=_Part_1411_6210662.1356015119273
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi

The tests have been running for 6 days now and we had only one failing BBxm

There are five boards:

2 panda: high network + usb traffic
3 bbxm: high network + usb traffic

The only error we got was on a bbxm after 40 hours or so, see log below:


[81288.126525] usb 1-2.4: new full-speed USB device number 8 using ehci-oma=
p
[81288.252624] usb 1-2.4: New USB device found, idVendor=3D0403,=20
idProduct=3D6001
[81288.252655] usb 1-2.4: New USB device strings: Mfr=3D1, Product=3D2,=20
SerialNumber=3D3
[81288.252685] usb 1-2.4: Product: FT232R USB UART
[81288.252716] usb 1-2.4: Manufacturer: FTDI
[81288.252746] usb 1-2.4: SerialNumber: A401180G
[81288.264221] ftdi_sio 1-2.4:1.0: FTDI USB Serial Device converter detecte=
d
[81288.264587] usb 1-2.4: Detected FT232RL
[81288.264617] usb 1-2.4: Number of endpoints 2
[81288.264648] usb 1-2.4: Endpoint 1 MaxPacketSize 64
[81288.264678] usb 1-2.4: Endpoint 2 MaxPacketSize 64
[81288.264709] usb 1-2.4: Setting MaxPacketSize 64
[81288.269409] usb 1-2.4: FTDI USB Serial Device converter now attached to=
=20
ttyUSB0
[244500.186431] hub 1-0:1.0: port 2 disabled by hub (EMI?), re-enabling...
[244500.193756] usb 1-2: USB disconnect, device number 2
[244500.193756] usb 1-2.1: USB disconnect, device number 3
[244500.197296] usb 1-2: clear tt 4 (9081) error -19
[244500.206756] usb 1-2: clear tt 4 (9081) error -19
[244500.216766] smsc95xx 1-2.1:1.0: eth0: unregister 'smsc95xx'=20
usb-ehci-omap.0-2.1, smsc95xx USB 2.0 Ethernet
[244500.272369] ftdi_sio ttyUSB0: ftdi_set_termios urb failed to set=20
baudrate
[244500.279937] ftdi_sio ttyUSB0: urb failed to clear flow control
[244501.531372] usb 1-2.4: USB disconnect, device number 8
[244501.532318] ftdi_sio ttyUSB0: FTDI USB Serial Device converter now=20
disconnected from ttyUSB0
[244501.532409] ftdi_sio 1-2.4:1.0: device disconnected

This board has 2 xbee devices talking to each other, on on a usb serial=20
adapter and the other one is mapped on a native UART of the bbxm.

This is not the first I've this EMI error, but this is the first time I see=
=20
the "usb 1-2: clear tt 4 (9081) error -19" part.=20


Le mercredi 12 d=E9cembre 2012 12:19:26 UTC+1, Adrien Ferr=E9 a =E9crit :
>
> Hi
>
> We are facing this kind of issue on several beaglexm and panda es. We are=
=20
> currently seting up a test case which is:
>
> Heavy network traffic:
>
> A ftp server on the LAN serving one file to all boards.
> All boards download the file, remove it, redownload it, ...
>
> Heavy usb traffic:
>
> We have to USB-Serial adapters wired together at 115200 with RTS/CTS=20
> enabled and serving a file to each other simultaneously.
>
> We'll run the tests for a few days and I'll give the results here.
>
> OCS: do you have results to provide for your tests please?
>
> Le vendredi 24 f=E9vrier 2012 23:13:57 UTC+1, Paul Walmsley a =E9crit :
>>
>> cc'ing beagleboard list, Kevin
>>
>> Hi Richard,
>>
>> thanks for the patch.  A quick question for you or anyone else who is=20
>> experiencing this problem.
>>
>> On Mon, 20 Feb 2012, Richard Watts wrote:
>>
>> > There is an erratum in DM3730 which results in the
>> > EHCI USB PLL (DPLL5) not updating sufficiently frequently; this
>> > leads to USB PHY clock drift and once the clock has drifted far
>> > enough, the PHY's ULPI interface stops responding and USB
>> > drops out. This is manifested on a Beagle xM by having the attached
>> > SMSC9514 report 'Cannot enable port 2. Maybe the USB cable is bad?'
>> > or similar.
>> >=20
>> > The fix is to carefully adjust your DPLL5 settings so as to
>> > keep the PHY clock as close as possible to 120MHz over the long
>> > term; TI SPRZ319e gives a table of such settings and this patch
>> > applies that table to systems with a 13MHz or a 26MHz clock,
>> > thus fixing the issue (inasfar as it can be fixed) on Beagle xM
>> > and Overo Firestorm.
>> >=20
>> > Signed-off-by: Richard Watts <r...-XQiHveOWqdgqdlJmJB21zg@public.gmane.org>
>>
>> Funny, I just had a conversation with Kevin Hilman about needing to put=
=20
>> the DPLL rate rounding code back in for the OPP tables.  This looks like=
=20
>> another reason why...
>>
>> Could you, or anyone else who is experiencing this problem on a board=20
>> with=20
>> a 26MHz oscillator try a quick test for me?  I'm a little curious about=
=20
>> the (M, N) of (443, 12) that SPRZ319E is recommending.  Could you see if=
=20
>> your USB problems are also solved by using (480, 13) ?
>>
>> ...
>>
>> Here's the rationale.  Walking through the estimates here based on=20
>> SPRZ319E, (443, 12) results in a frequency error of -166,667 Hz at the=
=20
>> VCO=20
>> output.  This is 174 ppm below the desired target rate of 960MHz.  But=
=20
>> (480, 13) results in no frequency error.
>>
>> The downside of using (480, 13) is that the PLL update interval increase=
s=20
>> from 461 ns to 500 ns (+9%).  But if the long-term drift of the DPLL is=
=20
>> downward, then starting at a -174 ppm error has removed 35% of the total=
=20
>> margin (+/- 500 ppm).  This might be too na=EFve, but a downward drift,=
=20
>> seems likely given that gate delay increases as temperature increases.
>>
>> Mainline is currently using (120, 13) which results in a VCO output=20
>> frequency of 240MHz -- this presumably results in increased phase noise=
=20
>> compared to (443, 12) and (480, 13) per SPRZ319E. =20
>>
>>
>> - Paul
>>
>>

--=20
For more options, visit http://beagleboard.org/discuss



------=_Part_1411_6210662.1356015119273
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<div><br></div><div>The tests have been running for 6 days now and we had=
 only one failing BBxm</div><div><br></div><div>There are five boards:</div=
><div><br></div><div>2 panda: high network + usb traffic</div><div>3 bbxm: =
high network + usb traffic<br><br>The only error we got was on a bbxm after=
 40 hours or so, see log below:</div><div><br></div><div><br></div><div><di=
v>[81288.126525] usb 1-2.4: new full-speed USB device number 8 using ehci-o=
map</div><div>[81288.252624] usb 1-2.4: New USB device found, idVendor=3D04=
03, idProduct=3D6001</div><div>[81288.252655] usb 1-2.4: New USB device str=
ings: Mfr=3D1, Product=3D2, SerialNumber=3D3</div><div>[81288.252685] usb 1=
-2.4: Product: FT232R USB UART</div><div>[81288.252716] usb 1-2.4: Manufact=
urer: FTDI</div><div>[81288.252746] usb 1-2.4: SerialNumber: A401180G</div>=
<div>[81288.264221] ftdi_sio 1-2.4:1.0: FTDI USB Serial Device converter de=
tected</div><div>[81288.264587] usb 1-2.4: Detected FT232RL</div><div>[8128=
8.264617] usb 1-2.4: Number of endpoints 2</div><div>[81288.264648] usb 1-2=
.4: Endpoint 1 MaxPacketSize 64</div><div>[81288.264678] usb 1-2.4: Endpoin=
t 2 MaxPacketSize 64</div><div>[81288.264709] usb 1-2.4: Setting MaxPacketS=
ize 64</div><div>[81288.269409] usb 1-2.4: FTDI USB Serial Device converter=
 now attached to ttyUSB0</div><div>[244500.186431] hub 1-0:1.0: port 2 disa=
bled by hub (EMI?), re-enabling...</div><div>[244500.193756] usb 1-2: USB d=
isconnect, device number 2</div><div>[244500.193756] usb 1-2.1: USB disconn=
ect, device number 3</div><div>[244500.197296] usb 1-2: clear tt 4 (9081) e=
rror -19</div><div>[244500.206756] usb 1-2: clear tt 4 (9081) error -19</di=
v><div>[244500.216766] smsc95xx 1-2.1:1.0: eth0: unregister 'smsc95xx' usb-=
ehci-omap.0-2.1, smsc95xx USB 2.0 Ethernet</div><div>[244500.272369] ftdi_s=
io ttyUSB0: ftdi_set_termios urb failed to set baudrate</div><div>[244500.2=
79937] ftdi_sio ttyUSB0: urb failed to clear flow control</div><div>[244501=
.531372] usb 1-2.4: USB disconnect, device number 8</div><div>[244501.53231=
8] ftdi_sio ttyUSB0: FTDI USB Serial Device converter now disconnected from=
 ttyUSB0</div><div>[244501.532409] ftdi_sio 1-2.4:1.0: device disconnected<=
/div><div><br></div><div>This board has 2 xbee devices talking to each othe=
r, on on a usb serial adapter and the other one is mapped on a native UART =
of the bbxm.</div><div><br></div>This is not the first I've this EMI error,=
 but this is the first time I see the "usb 1-2: clear tt 4 (9081) error -19=
" part.&nbsp;</div><div><br></div><div><br>Le mercredi 12 d=E9cembre 2012 1=
2:19:26 UTC+1, Adrien Ferr=E9 a =E9crit&nbsp;:<blockquote class=3D"gmail_qu=
ote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padd=
ing-left: 1ex;">Hi<div><br></div><div>We are facing this kind of issue on s=
everal beaglexm and panda es. We are currently seting up a test case which =
is:</div><div><br></div><div>Heavy network traffic:</div><div><br></div><di=
v>A ftp server on the LAN serving one file to all boards.</div><div>All boa=
rds download the file, remove it, redownload it, ...<br></div><div><br></di=
v><div>Heavy usb traffic:</div><div><br></div><div>We have to USB-Serial ad=
apters wired together at 115200 with RTS/CTS enabled and serving a file to =
each other simultaneously.<br><br>We'll run the tests for a few days and I'=
ll give the results here.<br><br>OCS: do you have results to provide for yo=
ur tests please?<br><br>Le vendredi 24 f=E9vrier 2012 23:13:57 UTC+1, Paul =
Walmsley a =E9crit&nbsp;:<blockquote class=3D"gmail_quote" style=3D"margin:=
0;margin-left:0.8ex;border-left:1px #ccc solid;padding-left:1ex">cc'ing bea=
gleboard list, Kevin<p>Hi Richard,</p><p>thanks for the patch. &nbsp;A quic=
k question for you or anyone else who is <br>experiencing this problem.</p>=
<p>On Mon, 20 Feb 2012, Richard Watts wrote:</p><p>&gt; There is an erratum=
 in DM3730 which results in the<br>&gt; EHCI USB PLL (DPLL5) not updating s=
ufficiently frequently; this<br>&gt; leads to USB PHY clock drift and once =
the clock has drifted far<br>&gt; enough, the PHY's ULPI interface stops re=
sponding and USB<br>&gt; drops out. This is manifested on a Beagle xM by ha=
ving the attached<br>&gt; SMSC9514 report 'Cannot enable port 2. Maybe the =
USB cable is bad?'<br>&gt; or similar.<br>&gt; <br>&gt; The fix is to caref=
ully adjust your DPLL5 settings so as to<br>&gt; keep the PHY clock as clos=
e as possible to 120MHz over the long<br>&gt; term; TI SPRZ319e gives a tab=
le of such settings and this patch<br>&gt; applies that table to systems wi=
th a 13MHz or a 26MHz clock,<br>&gt; thus fixing the issue (inasfar as it c=
an be fixed) on Beagle xM<br>&gt; and Overo Firestorm.<br>&gt; <br>&gt; Sig=
ned-off-by: Richard Watts &lt;<a>r...-XQiHveOWqdgqdlJmJB21zg@public.gmane.org</a>&gt;</p><p>Funny, I =
just had a conversation with Kevin Hilman about needing to put <br>the DPLL=
 rate rounding code back in for the OPP tables. &nbsp;This looks like <br>a=
nother reason why...</p><p>Could you, or anyone else who is experiencing th=
is problem on a board with <br>a 26MHz oscillator try a quick test for me? =
&nbsp;I'm a little curious about <br>the (M, N) of (443, 12) that SPRZ319E =
is recommending. &nbsp;Could you see if <br>your USB problems are also solv=
ed by using (480, 13) ?</p><p>...</p><p>Here's the rationale. &nbsp;Walking=
 through the estimates here based on <br>SPRZ319E, (443, 12) results in a f=
requency error of -166,667 Hz at the VCO <br>output. &nbsp;This is 174 ppm =
below the desired target rate of 960MHz. &nbsp;But <br>(480, 13) results in=
 no frequency error.</p><p>The downside of using (480, 13) is that the PLL =
update interval increases <br>from 461 ns to 500 ns (+9%). &nbsp;But if the=
 long-term drift of the DPLL is <br>downward, then starting at a -174 ppm e=
rror has removed 35% of the total <br>margin (+/- 500 ppm). &nbsp;This migh=
t be too na=EFve, but a downward drift, <br>seems likely given that gate de=
lay increases as temperature increases.</p><p>Mainline is currently using (=
120, 13) which results in a VCO output <br>frequency of 240MHz -- this pres=
umably results in increased phase noise <br>compared to (443, 12) and (480,=
 13) per SPRZ319E. &nbsp;</p><p><br>- Paul</p><p></p><p></p><p></p><p></p><=
p></p><p></p><p></p><p></p><p></p><p></p></blockquote></div></blockquote></=
div>

<p></p>

-- <br />
For more options, visit <a href=3D"http://beagleboard.org/discuss">http://b=
eagleboard.org/discuss</a><br />
&nbsp;<br />
&nbsp;<br />

------=_Part_1411_6210662.1356015119273--
