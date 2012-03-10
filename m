From: yang gqyang <hustgqyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: implementing "suspend to ram" on cortex A8 based on linux 3.0.8
Date: Sat, 10 Mar 2012 22:25:08 +0800
Message-ID: <CAFawwkWQd=y=kVm97UjSs37=-MRmJiy9f7sy8ChYzCHZ9Y-gyA@mail.gmail.com>
References: <CAFawwkXQhyj+c8LEDnD7q4mXDJV2jYCAHV0tBrqxrEaNGk+_0w@mail.gmail.com>
	<CACNz9cVbULxVSGvo60V+JLL=15BDEaYwgd5k9ZMNu09Kfwz4WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7499467546243556689=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CACNz9cVbULxVSGvo60V+JLL=15BDEaYwgd5k9ZMNu09Kfwz4WQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Chenglie He <chengjie.he-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, venki-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, Baohua.Song-kQvG35nSl+M@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, g.trinabh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, jon-hunter-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============7499467546243556689==
Content-Type: multipart/alternative; boundary=f46d04478497bab81204bae44657

--f46d04478497bab81204bae44657
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Thanks for your comment.
Finally, i find out that i made a mistake.  The uart(8250) have not been
restore after resume, instead, it use the configuration got from boot. The
uart have not been restored correctly, so that "ls" can not output result
correctly resulting in it seems that the busybox can not work correctly.
Now, i still have a question about the uart: why the "printk" can work
correctly, but the "printf" not?

Before this, i believe that the "printk" work correctly, then the uart work
ok. but now, i  need more reconsidaration about
the relation between the "printk", "printf" and "uart".
Can anyone give me some suggestion? Any comment is welcome, thanks a lot.


=D4=DA 2012=C4=EA3=D4=C29=C8=D5 =CF=C2=CE=E710:08=A3=ACChenglie He <chengji=
e.he-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>=D0=B4=B5=C0=A3=BA

> Hi,
>
> I am doing this on A9, echo mem >/sys/power/state is right, will trigger
> kernel to sleep.
>
> -jack
>
>  On 7 March 2012 23:05, yang gqyang <hustgqyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>>   dear all:
>> I am working on arm cortex a8 now, trying to implement "suspend to ram"
>> based on linux 3.0.8.
>> Before i start my work, the soc already support standby(the cpu is on wf=
i
>> state), so in order to implement "suspend to ram", i think i just need t=
o
>> implement the arch-specific related api. The "suspend to ram" works like
>> this:
>> "echo mem > /sys/power/state"  -> enter_state ->
>> suspend_devices_and_enter ->suspend_ops->enter(state)
>>  Is that right? Do you think the "suspend to ram" can be realized in thi=
s
>> way?
>> In order to power off the cortex A8, i save all the writable co-processo=
r
>> and   all modes's state register set, and restore them when resuming.
>> All the code seems work ok, because when I just does not power off the
>> cortex-A8 and jump to excute the resume code, the system works well. But=
,
>> when I power off the cpu, and wake up and excute resume code, the kernel
>> seem ok, but the busybox toolkit does not work proper, eg: "ls" can not
>> output the result through serial port. i add "printk statement" trying t=
o
>> locate the reason, but at this time, the "ls" work fine.  hence, i doubt
>> something must be corrupted after resume.
>> I have checked all the state register and co-processor, having not found
>> any exception, and I also compared all the dram data before power off an=
d
>> after wake up, nothing have changed. Right now, I do not know what has
>> happened, and what should I do to locate the real problem to make the
>> busybox works ok. I also want to know does the linux kernel 3.0.8 suppor=
t
>> "suspend to ram" like this:
>> "echo mem > /sys/power/state"  -> enter_state ->
>> suspend_devices_and_enter ->suspend_ops->enter(state)?
>> Can anyone give me some suggestion? Any comment is welcome, thanks a lot=
.
>>
>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> _______________________________________________
>> linaro-dev mailing list
>> linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
>> http://lists.linaro.org/mailman/listinfo/linaro-dev
>>
>>
>

--f46d04478497bab81204bae44657
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div>Thanks for your comment.&nbsp;</div>
<div>Finally, i find out that i made a mistake.&nbsp;&nbsp;The uart(8250) h=
ave not been restore after&nbsp;resume, instead, it use the configuration g=
ot from boot.&nbsp;The uart have not been restored correctly, so that &quot=
;ls&quot; can not output result correctly resulting in it seems that the bu=
sybox can not work correctly.&nbsp;</div>

<div>Now, i still have a question about the uart: why the &quot;printk&quot=
; can work correctly, but the &quot;printf&quot; not?</div>
<div>&nbsp;</div>
<div>Before this, i believe that the &quot;printk&quot; work correctly, the=
n the uart work ok. but now, i &nbsp;need more reconsidaration about</div>
<div>the relation between the &quot;printk&quot;, &quot;printf&quot;&nbsp;a=
nd &quot;uart&quot;.</div>
<div>Can anyone give me some suggestion? Any comment is welcome, thanks a l=
ot.&nbsp;&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div class=3D"gmail_quote">=D4=DA 2012=C4=EA3=D4=C29=C8=D5 =CF=C2=CE=E710:0=
8=A3=ACChenglie He <span dir=3D"ltr">&lt;<a href=3D"mailto:chengjie.he@lina=
ro.org" target=3D"_blank">chengjie.he-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;</span>=D0=B4=B5=C0=
=A3=BA<br>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">Hi,<br><br>I am doing this on A9, ech=
o mem &gt;/sys/power/state is right, will trigger kernel to sleep.<br><br>
-jack<br><br>
<div class=3D"gmail_quote">
<div>
<div>On 7 March 2012 23:05, yang gqyang <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:hustgqyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">hustgqyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</=
span> wrote:<br></div></div>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">
<div>
<div>
<div>
<div>dear all:</div>
<div><span style=3D"WHITE-SPACE:pre-wrap"></span>I am working on arm cortex=
 a8 now, trying to implement &quot;suspend to ram&quot; based on linux 3.0.=
8.&nbsp;</div>
<div><span style=3D"WHITE-SPACE:pre-wrap"></span>Before i start my work, th=
e soc already support standby(the cpu is on wfi state), so in order to impl=
ement &quot;suspend to ram&quot;, i think i just need to implement the arch=
-specific related api. The &quot;suspend to ram&quot; works like this:&nbsp=
;</div>

<div>&quot;echo mem &gt; /sys/power/state&quot; &nbsp;-&gt; enter_state -&g=
t; suspend_devices_and_enter -&gt;suspend_ops-&gt;enter(state)</div>
<div>&nbsp;Is that right? Do you think the &quot;suspend to ram&quot; can b=
e realized in this way?</div>
<div><span style=3D"WHITE-SPACE:pre-wrap"></span>In order to power off the =
cortex A8, i save all the writable co-processor and &nbsp; all modes&#39;s =
state register set, and restore them when resuming.&nbsp;</div>
<div><span style=3D"WHITE-SPACE:pre-wrap"></span>All the code seems work ok=
, because when I just does not power off the cortex-A8 and jump to excute t=
he resume code, the system works well. But, when I power off the cpu, and w=
ake up and excute resume code, the kernel seem ok, but the busybox toolkit =
does not work proper, eg: &quot;ls&quot; can not output the result through =
serial port. i add &quot;printk statement&quot; trying to locate the reason=
, but at this time, the &quot;ls&quot; work fine. &nbsp;hence, i doubt some=
thing must be corrupted after resume.</div>

<div><span style=3D"WHITE-SPACE:pre-wrap"></span>I have checked all the sta=
te register and co-processor, having not found any exception, and I also co=
mpared all the dram data before power off and after wake up, nothing have c=
hanged. Right now, I do not know what has happened, and what should I do to=
 locate the real problem to make the busybox works ok. I also want to know =
does the linux kernel 3.0.8 support &quot;suspend to ram&quot; like this:</=
div>

<div>&quot;echo mem &gt; /sys/power/state&quot; &nbsp;-&gt; enter_state -&g=
t; suspend_devices_and_enter -&gt;suspend_ops-&gt;enter(state)?</div>
<div>Can anyone give me some suggestion? Any comment is welcome, thanks a l=
ot. &nbsp;&nbsp;</div></div>
<div class=3D"gmail_quote">
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote"><span><font color=3D"#888888"><font c=
olor=3D"#000000"><br><span><font color=3D"#888888"></font></span></font><sp=
an><font color=3D"#888888">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-pm&quo=
t; in<br>the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TbrhsbdSgBK9A@public.gmane.org=
rg" target=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>More majordomo info =
at &nbsp;<a href=3D"http://vger.kernel.org/majordomo-info.html" target=3D"_=
blank">http://vger.kernel.org/majordomo-info.html</a><br>
</font></span></font></span></blockquote></div><br><br></div></div>________=
_______________________________________<br>linaro-dev mailing list<br><a hr=
ef=3D"mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" target=3D"_blank">linaro-dev@list=
s.linaro.org</a><br>
<a href=3D"http://lists.linaro.org/mailman/listinfo/linaro-dev" target=3D"_=
blank">http://lists.linaro.org/mailman/listinfo/linaro-dev</a><br><br></blo=
ckquote></div><br></blockquote></div><br>

--f46d04478497bab81204bae44657--


--===============7499467546243556689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============7499467546243556689==--
