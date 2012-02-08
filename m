From: Andrew Richardson <chardson-63aXycvo3TyHXe+LvDLADg@public.gmane.org>
Subject: Re: Minimum timing resolution in Ubuntu/Linaro on the PandaBoard ES
Date: Wed, 8 Feb 2012 04:32:51 -0500
Message-ID: <51DAA6EF-1C3B-4964-8447-893D295E51A1@umich.edu>
References: <4F31A91B.8080106@umich.edu> <4F32063F.1020607@linaro.org>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: multipart/mixed; boundary="===============5356261907985372319=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F32063F.1020607-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Dmitry Antipov <dmitry.antipov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--===============5356261907985372319==
Content-Type: multipart/alternative; boundary="Apple-Mail=_139F2DBC-AD7C-4AA2-8723-DAD87029210A"


--Apple-Mail=_139F2DBC-AD7C-4AA2-8723-DAD87029210A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

Ah, very interesting.

> dmesg | grep clock
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps =
every 131071999ms
[    0.309448] omap_hwmod: l4_div_ck: missing clockdomain for l4_div_ck.
[    0.716979] Skipping twl internal clock init and using bootloader =
value (unknown osc rate)
[    1.001129] Switching to clocksource 32k_counter
[    6.907501] twl_rtc twl_rtc: setting system clock to 2000-01-01 =
00:00:01 UTC (946684801)

Do you recommend using "Get linaro image tools: method 2 (source code)" =
( http://releases.linaro.org/12.01/ubuntu/leb-panda/ ) and building the =
kernel myself? I think we're, for the most part, unconcerned with power =
usage for our application (we're robotics researchers and, I believe, =
computation is only a small fraction of the power draw when compared to =
the motors).

It seems to me that we would want to disable some of the power-saving =
changes that have been made, such as this timer, and possibly configure =
other settings like cache behavior, though I have no idea how they're =
currently set. I have a bunch of docs from ARM on power and cache =
config, but I haven't messed around with them as I'm not sure where to =
start. My best guess is that I would have to rebuild the kernel to start =
handling that configuration myself. Is that true?

Some people ( =
http://groups.google.com/group/pandaboard/browse_thread/thread/a18fa3514d1=
30720 ) have mentioned enabling line fill and prefetching to speed up =
memcpy operations, which also seems useful. Is this also a kernel-level =
setting?

If you think that's the right route, I would appreciate advice on where, =
within the build process, I need to start changing things to get the =
settings I want.

Many thanks,
Andrew



On Feb 8, 2012, at 12:21 AM, Dmitry Antipov wrote:

> On 02/07/2012 02:43 PM, Andrew Richardson wrote:
>=20
>> I'm experiencing what appears to be a minimum clock resolution issue
>> in using clock_gettime() on a PandaBoard ES running ubuntu.
>=20
> Do you have CONFIG_OMAP_32K_TIMER enabled in your kernel?
> Look at 'dmesg | grep clock' and check for the following:
>=20
> ...
> OMAP clockevent source: GPTIMER1 at 32768 Hz
> sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every =
131071999ms
> ...
>=20
> Most probably this is the answer - by default, recent OMAPs are =
configured
> to use less-accurate, but more energy-saving timer (32KHz) in favor of
> MPU timer.
>=20
> Disable CONFIG_OMAP_32K_TIMER to switch to MPU timer, and check
> 'dmesg | grep clock' to see:
>=20
> ...
> OMAP clockevent source: GPTIMER1 at 38400000 Hz
> OMAP clocksource: GPTIMER2 at 38400000 Hz
> sched_clock: 32 bits at 38MHz, resolution 26ns, wraps every 111848ms
> ...
>=20
> BTW, I have no ideas why clock_getres(CLOCK_REALTIME,...) returns {0, =
1}
> regardless of underlying clock source. I expect {0, 30517} for 32K =
timer
> and {0, 26} for MPU timer.
>=20
> Dmitry
>=20
>=20


--Apple-Mail=_139F2DBC-AD7C-4AA2-8723-DAD87029210A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=iso-8859-1

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; ">Ah, =
very interesting.<div><br></div><blockquote =
class=3D"webkit-indent-blockquote" style=3D"margin: 0 0 0 40px; border: =
none; padding: 0px;"><div><div><b>&gt; dmesg | grep =
clock</b></div><div><b>[ &nbsp; &nbsp;0.000000] OMAP clockevent source: =
GPTIMER1 at 32768 Hz</b></div><div><b>[ &nbsp; &nbsp;0.000000] =
sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every =
131071999ms</b></div><div>[ &nbsp; &nbsp;0.309448] omap_hwmod: =
l4_div_ck: missing clockdomain for l4_div_ck.</div><div>[ &nbsp; =
&nbsp;0.716979] Skipping twl internal clock init and using bootloader =
value (unknown osc rate)</div><div>[ &nbsp; &nbsp;1.001129] Switching to =
clocksource 32k_counter</div><div>[ &nbsp; &nbsp;6.907501] twl_rtc =
twl_rtc: setting system clock to 2000-01-01 00:00:01 UTC =
(946684801)</div></div><div><br></div></blockquote><div>Do you recommend =
using "Get linaro image tools: method 2 (source code)" ( <a =
href=3D"http://releases.linaro.org/12.01/ubuntu/leb-panda/">http://release=
s.linaro.org/12.01/ubuntu/leb-panda/</a> ) and building the kernel =
myself? I think we're, for the most part, unconcerned with power usage =
for our application (we're robotics researchers and, I believe, =
computation is only a small fraction of the power draw when compared to =
the motors).</div><div><br></div><div>It seems to me that we would want =
to disable some of the power-saving changes that have been made, such as =
this timer, and possibly configure other settings like cache behavior, =
though I have no idea how they're currently set. I have a bunch of docs =
from ARM on power and cache config, but I haven't messed around with =
them as I'm not sure where to start. My best guess is that I would have =
to rebuild the kernel to start handling that configuration myself. Is =
that true?</div><div><br></div><div>Some people (&nbsp;<a =
href=3D"http://groups.google.com/group/pandaboard/browse_thread/thread/a18=
fa3514d130720">http://groups.google.com/group/pandaboard/browse_thread/thr=
ead/a18fa3514d130720</a> ) have mentioned enabling line fill and =
prefetching to speed up memcpy operations, which also seems useful. Is =
this also a kernel-level setting?</div><div><br></div><div>If you think =
that's the right route, I would appreciate advice on where, within the =
build process, I need to start changing things to get the settings I =
want.</div><div><br></div><div>Many =
thanks,</div><div>Andrew</div><div><br></div><div><br></div><br><div><div>=
<div>On Feb 8, 2012, at 12:21 AM, Dmitry Antipov wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div>On =
02/07/2012 02:43 PM, Andrew Richardson wrote:<br><br><blockquote =
type=3D"cite">I'm experiencing what appears to be a minimum clock =
resolution issue<br></blockquote><blockquote type=3D"cite">in using =
clock_gettime() on a PandaBoard ES running =
ubuntu.<br></blockquote><br>Do you have CONFIG_OMAP_32K_TIMER enabled in =
your kernel?<br>Look at 'dmesg | grep clock' and check for the =
following:<br><br>...<br>OMAP clockevent source: GPTIMER1 at 32768 =
Hz<br>sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every =
131071999ms<br>...<br><br>Most probably this is the answer - by default, =
recent OMAPs are configured<br>to use less-accurate, but more =
energy-saving timer (32KHz) in favor of<br>MPU timer.<br><br>Disable =
CONFIG_OMAP_32K_TIMER to switch to MPU timer, and check<br>'dmesg | grep =
clock' to see:<br><br>...<br>OMAP clockevent source: GPTIMER1 at =
38400000 Hz<br>OMAP clocksource: GPTIMER2 at 38400000 Hz<br>sched_clock: =
32 bits at 38MHz, resolution 26ns, wraps every =
111848ms<br>...<br><br>BTW, I have no ideas why =
clock_getres(CLOCK_REALTIME,...) returns {0, 1}<br>regardless of =
underlying clock source. I expect {0, 30517} for 32K timer<br>and {0, =
26} for MPU =
timer.<br><br>Dmitry<br><br><br></div></blockquote></div><br></div></body>=
</html>=

--Apple-Mail=_139F2DBC-AD7C-4AA2-8723-DAD87029210A--


--===============5356261907985372319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============5356261907985372319==--
