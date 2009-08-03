From: Arun KS <arunks@mistralsolutions.com>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Mon, 3 Aug 2009 10:53:31 -0700
Message-ID: <dfeb90390908031053o14b4583fh83e4306253a13944@mail.gmail.com>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl>
	<20090803112950.3fb6cda9.jhnikula@gmail.com>
	<4A76ED80.6040001@tis.icnet.pl>
Reply-To: Discussion of the Amstrad E3 emailer hardware/software
	<e3-hacking@earth.li>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1055905484072374536=="
Return-path: <e3-hacking-bounces@earth.li>
In-Reply-To: <4A76ED80.6040001@tis.icnet.pl>
List-Unsubscribe: <http://www.earth.li/cgi-bin/mailman/options/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=unsubscribe>
List-Archive: <http://www.earth.li/pipermail/e3-hacking>
List-Post: <mailto:e3-hacking@earth.li>
List-Help: <mailto:e3-hacking-request@earth.li?subject=help>
List-Subscribe: <http://www.earth.li/cgi-bin/mailman/listinfo/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=subscribe>
Mime-version: 1.0
Sender: e3-hacking-bounces@earth.li
Errors-To: e3-hacking-bounces@earth.li
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, e3-hacking@earth.li, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--===============1055905484072374536==
Content-Type: multipart/alternative; boundary=00163642749eaf2db1047040724b

--00163642749eaf2db1047040724b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Aug 3, 2009 at 7:00 AM, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>wrote:

> Jarkko Nikula wrote:
>
>> On Mon, 3 Aug 2009 03:32:04 +0200
>> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
>>
>>  This patch tries to correct the problem of full duplex mode not working
>>> over a single McBSP based CPU DAI.
>>>
>>> Created against linux-2.6.31-rc5.
>>> Tested on Amstrad Delta.
>>>
>>>  Do you have some specific test case how to trigger this? I haven't
>> seen this on 2420 or 34xx (e.g. with 'arecord -d 1 -f dat |aplay') but
>> I have no doubt that this can happen on 1510. At least this doesn't
>> cause any harm on Beagle so I'm fine with the fix.
>>
>
> Hi,
> I made more testing on my OMAP1510 and found out that I could get your
> example usage working without my patch, but only if started like this:
>
>        arecord -D hw:0,0 -f S16_LE|aplay -D hw:0,0
>
> If I start the same with "-D hw:0,0" omitted from aplay, it doesn't work
> any longer, waiting forever. It definitelly doesn't work if I start capture
> and playback one after another, no matter which one goes first (record while
> playing or play while recording). So it looks like starting both streams
> simultaneously can do the job, but a short delay breaks it.
>
> With my patch, it seems to work fine for me in all cases.
>
> Jarkko, have you ever tried it on your OMAP2/3 with parallel playback and
> capture started one after another, not simultaneously?
>
> Arun, can your snd-soc-osk9512 work on OMAP1610 in full duplex mode without
> any limitations?


Janusz,

Haven't done testing in full duplex mode.
I don't have access to osk5912 board now. If someone has got osk and do the
testing it ll be good. It  ll take at least another 2 more month for me to
do the testing on osk.

Regards,
Arun


>
> If the problem appears to be OMAP1510 or AMS_DELTA specific, I can add a
> check for a machine or cpu type to avoid braking unaffected machines.
>
> Thanks,
> Janusz
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--00163642749eaf2db1047040724b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Aug 3, 2009 at 7:00 AM, Janusz K=
rzysztofik <span dir=3D"ltr">&lt;<a href=3D"mailto:jkrzyszt@tis.icnet.pl">j=
krzyszt@tis.icnet.pl</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0p=
t 0.8ex; padding-left: 1ex;">
<div class=3D"im">Jarkko Nikula wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Mon, 3 Aug 2009 03:32:04 +0200<br>
Janusz Krzysztofik &lt;<a href=3D"mailto:jkrzyszt@tis.icnet.pl" target=3D"_=
blank">jkrzyszt@tis.icnet.pl</a>&gt; wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
This patch tries to correct the problem of full duplex mode not working<br>
over a single McBSP based CPU DAI.<br>
<br>
Created against linux-2.6.31-rc5.<br>
Tested on Amstrad Delta.<br>
<br>
</blockquote>
Do you have some specific test case how to trigger this? I haven&#39;t<br>
seen this on 2420 or 34xx (e.g. with &#39;arecord -d 1 -f dat |aplay&#39;) =
but<br>
I have no doubt that this can happen on 1510. At least this doesn&#39;t<br>
cause any harm on Beagle so I&#39;m fine with the fix.<br>
</blockquote>
<br></div>
Hi,<br>
I made more testing on my OMAP1510 and found out that I could get your exam=
ple usage working without my patch, but only if started like this:<br>
<br>
 =A0 =A0 =A0 =A0arecord -D hw:0,0 -f S16_LE|aplay -D hw:0,0<br>
<br>
If I start the same with &quot;-D hw:0,0&quot; omitted from aplay, it doesn=
&#39;t work any longer, waiting forever. It definitelly doesn&#39;t work if=
 I start capture and playback one after another, no matter which one goes f=
irst (record while playing or play while recording). So it looks like start=
ing both streams simultaneously can do the job, but a short delay breaks it=
.<br>

<br>
With my patch, it seems to work fine for me in all cases.<br>
<br>
Jarkko, have you ever tried it on your OMAP2/3 with parallel playback and c=
apture started one after another, not simultaneously?<br>
<br>
Arun, can your snd-soc-osk9512 work on OMAP1610 in full duplex mode without=
 any limitations?</blockquote><div>=A0</div><div>Janusz,<br><br>Haven&#39;t=
 done testing in full duplex mode.<br>I don&#39;t have access to osk5912 bo=
ard now. If someone has got osk and do the testing it ll be good. It=A0 ll =
take at least another 2 more month for me to do the testing on osk.<br>
<br>Regards,<br>Arun<br><br></div><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;"><br>
<br>
If the problem appears to be OMAP1510 or AMS_DELTA specific, I can add a ch=
eck for a machine or cpu type to avoid braking unaffected machines.<br>
<br>
Thanks,<br><font color=3D"#888888">
Janusz</font><div><div></div><div class=3D"h5"><br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-omap&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org" targe=
t=3D"_blank">majordomo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</div></div></blockquote></div><br>

--00163642749eaf2db1047040724b--


--===============1055905484072374536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
e3-hacking mailing list
e3-hacking@earth.li
http://www.earth.li/cgi-bin/mailman/listinfo/e3-hacking

--===============1055905484072374536==--
