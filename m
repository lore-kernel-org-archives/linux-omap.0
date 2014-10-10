From: manty kuma <mantykuma@gmail.com>
Subject: Re: cpuidle - minimum time for sleep
Date: Fri, 10 Oct 2014 12:22:55 +0900
Message-ID: <CAB6A5-BJZtcT0GZpYC=TOeXrEC+mvTCxKkVftObxzt3OkNadHQ@mail.gmail.com>
References: <CAJ2oMhJXi-wxZJFcmm3LsTQOC35tAVKwr1PihUc0CmbnNtfPVQ@mail.gmail.com>
	<11792.1412881303@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0574089394210601613=="
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
In-Reply-To: <11792.1412881303@turing-police.cc.vt.edu>
List-Unsubscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc: linux-omap@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-embedded@vger.kernel.org, Ran Shalit <ranshalit@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============0574089394210601613==
Content-Type: multipart/alternative; boundary=001a11c3319ea90f7e050509102f

--001a11c3319ea90f7e050509102f
Content-Type: text/plain; charset=UTF-8

>> Does anybody know what is the minimum expected time for sleep period
>> with the cpuidle ?
By sleep period do you mean sleep time for complete device or only for
cpu's? If you want to check for device as a whole, you can see the print in
the kernel log. If you want to check programmatically,
suspend_devices_and_enter() is the function.

On Fri, Oct 10, 2014 at 4:01 AM, <Valdis.Kletnieks@vt.edu> wrote:

> On Thu, 09 Oct 2014 21:28:23 +0300, Ran Shalit said:
>
> > Does anybody know what is the minimum expected time for sleep period
> > with the cpuidle ?
>
> Both processor dependent and sleep level dependent.  There's a certain
> amount of latency induced by the hardware waking up.
>
> Look at /sys/devices/system/cpu/cpu*/cpuidle/state*/latency
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>
>

--001a11c3319ea90f7e050509102f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt;&gt;=20
Does anybody know what is the minimum expected time for sleep period<br>&gt=
;&gt; with the cpuidle ?<br>By sleep period do you mean sleep time for comp=
lete device or only for cpu&#39;s? If you want to check for device as a who=
le, you can see the print in the kernel log. If you want to check programma=
tically, suspend_devices_and_enter() is the function.<br></div></div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Oct 10, 2014 at=
 4:01 AM,  <span dir=3D"ltr">&lt;<a href=3D"mailto:Valdis.Kletnieks@vt.edu"=
 target=3D"_blank">Valdis.Kletnieks@vt.edu</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><span class=3D"">On Thu, 09 Oct 2014 21:28:23 +0300=
, Ran Shalit said:<br>
<br>
&gt; Does anybody know what is the minimum expected time for sleep period<b=
r>
&gt; with the cpuidle ?<br>
<br>
</span>Both processor dependent and sleep level dependent.=C2=A0 There&#39;=
s a certain<br>
amount of latency induced by the hardware waking up.<br>
<br>
Look at /sys/devices/system/cpu/cpu*/cpuidle/state*/latency<br>
<br>_______________________________________________<br>
Kernelnewbies mailing list<br>
<a href=3D"mailto:Kernelnewbies@kernelnewbies.org">Kernelnewbies@kernelnewb=
ies.org</a><br>
<a href=3D"http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies" t=
arget=3D"_blank">http://lists.kernelnewbies.org/mailman/listinfo/kernelnewb=
ies</a><br>
<br></blockquote></div><br></div>

--001a11c3319ea90f7e050509102f--


--===============0574089394210601613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============0574089394210601613==--
