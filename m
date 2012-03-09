From: Chenglie He <chengjie.he-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: implementing "suspend to ram" on cortex A8 based on linux 3.0.8
Date: Fri, 9 Mar 2012 22:08:30 +0800
Message-ID: <CACNz9cVbULxVSGvo60V+JLL=15BDEaYwgd5k9ZMNu09Kfwz4WQ@mail.gmail.com>
References: <CAFawwkXQhyj+c8LEDnD7q4mXDJV2jYCAHV0tBrqxrEaNGk+_0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2860570261153934273=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAFawwkXQhyj+c8LEDnD7q4mXDJV2jYCAHV0tBrqxrEaNGk+_0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: yang gqyang <hustgqyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, venki-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, Baohua.Song-kQvG35nSl+M@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, g.trinabh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, jon-hunter-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============2860570261153934273==
Content-Type: multipart/alternative; boundary=e89a8f923ee86011ff04bacfede4

--e89a8f923ee86011ff04bacfede4
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am doing this on A9, echo mem >/sys/power/state is right, will trigger
kernel to sleep.

-jack

On 7 March 2012 23:05, yang gqyang <hustgqyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> dear all:
> I am working on arm cortex a8 now, trying to implement "suspend to ram"
> based on linux 3.0.8.
> Before i start my work, the soc already support standby(the cpu is on wfi
> state), so in order to implement "suspend to ram", i think i just need to
> implement the arch-specific related api. The "suspend to ram" works like
> this:
> "echo mem > /sys/power/state"  -> enter_state -> suspend_devices_and_enter
> ->suspend_ops->enter(state)
>  Is that right? Do you think the "suspend to ram" can be realized in this
> way?
>  In order to power off the cortex A8, i save all the writable
> co-processor and   all modes's state register set, and restore them when
> resuming.
>  All the code seems work ok, because when I just does not power off the
> cortex-A8 and jump to excute the resume code, the system works well. But,
> when I power off the cpu, and wake up and excute resume code, the kernel
> seem ok, but the busybox toolkit does not work proper, eg: "ls" can not
> output the result through serial port. i add "printk statement" trying to
> locate the reason, but at this time, the "ls" work fine.  hence, i doubt
> something must be corrupted after resume.
>  I have checked all the state register and co-processor, having not found
> any exception, and I also compared all the dram data before power off and
> after wake up, nothing have changed. Right now, I do not know what has
> happened, and what should I do to locate the real problem to make the
> busybox works ok. I also want to know does the linux kernel 3.0.8 support
> "suspend to ram" like this:
> "echo mem > /sys/power/state"  -> enter_state -> suspend_devices_and_enter
> ->suspend_ops->enter(state)?
> Can anyone give me some suggestion? Any comment is welcome, thanks a lot.
>
>
>>
>>  --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>
>

--e89a8f923ee86011ff04bacfede4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am doing this on A9, echo mem &gt;/sys/power/state is right, w=
ill trigger kernel to sleep.<br><br>-jack<br><br><div class=3D"gmail_quote"=
>On 7 March 2012 23:05, yang gqyang <span dir=3D"ltr">&lt;<a href=3D"mailto=
:hustgqyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">hustgqyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div>dear all:</div><div><span style=3D=
"white-space:pre-wrap">	</span>I am working on arm cortex a8 now, trying to=
 implement &quot;suspend to ram&quot; based on linux 3.0.8.=A0</div>
<div><span style=3D"white-space:pre-wrap">	</span>Before i start my work, t=
he soc already support standby(the cpu is on wfi state), so in order to imp=
lement &quot;suspend to ram&quot;, i think i just need to implement the arc=
h-specific related api. The &quot;suspend to ram&quot; works like this:=A0<=
/div>

<div>&quot;echo mem &gt; /sys/power/state&quot; =A0-&gt; enter_state -&gt; =
suspend_devices_and_enter -&gt;suspend_ops-&gt;enter(state)</div><div>=A0Is=
 that right? Do you think the &quot;suspend to ram&quot; can be realized in=
 this way?</div>

<div><span style=3D"white-space:pre-wrap">	</span>In order to power off the=
 cortex A8, i save all the writable co-processor and =A0 all modes&#39;s st=
ate register set, and restore them when resuming.=A0</div><div>
<span style=3D"white-space:pre-wrap">	</span>All the code seems work ok, be=
cause when I just does not power off the cortex-A8 and jump to excute the r=
esume code, the system works well. But, when I power off the cpu, and wake =
up and excute resume code, the kernel seem ok, but the busybox toolkit does=
 not work proper, eg: &quot;ls&quot; can not output the result through seri=
al port. i add &quot;printk statement&quot; trying to locate the reason, bu=
t at this time, the &quot;ls&quot; work fine. =A0hence, i doubt something m=
ust be corrupted after resume.</div>

<div><span style=3D"white-space:pre-wrap">	</span>I have checked all the st=
ate register and co-processor, having not found any exception, and I also c=
ompared all the dram data before power off and after wake up, nothing have =
changed. Right now, I do not know what has happened, and what should I do t=
o locate the real problem to make the busybox works ok. I also want to know=
 does the linux kernel 3.0.8 support &quot;suspend to ram&quot; like this:<=
/div>

<div>&quot;echo mem &gt; /sys/power/state&quot; =A0-&gt; enter_state -&gt; =
suspend_devices_and_enter -&gt;suspend_ops-&gt;enter(state)?</div><div>Can =
anyone give me some suggestion? Any comment is welcome, thanks a lot. =A0=
=A0</div>

</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span><font=
 color=3D"#888888"><font color=3D"#000000"><br><span class=3D"HOEnZb"><font=
 color=3D"#888888">
</font></span></font><span class=3D"HOEnZb"><font color=3D"#888888">
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-pm&quo=
t; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" targe=
t=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</font></span></font></span></blockquote></div><br>
<br>_______________________________________________<br>
linaro-dev mailing list<br>
<a href=3D"mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org">linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org<=
/a><br>
<a href=3D"http://lists.linaro.org/mailman/listinfo/linaro-dev" target=3D"_=
blank">http://lists.linaro.org/mailman/listinfo/linaro-dev</a><br>
<br></blockquote></div><br>

--e89a8f923ee86011ff04bacfede4--


--===============2860570261153934273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============2860570261153934273==--
