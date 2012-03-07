From: yang gqyang <hustgqyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: implementing "suspend to ram" on cortex A8 based on linux 3.0.8
Date: Wed, 7 Mar 2012 23:05:18 +0800
Message-ID: <CAFawwkXQhyj+c8LEDnD7q4mXDJV2jYCAHV0tBrqxrEaNGk+_0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2178936615952080601=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Robert Lee <rob.lee-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, venki-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jon-hunter-l0cyMroinI0@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, Baohua.Song-kQvG35nSl+M@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, g.trinabh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============2178936615952080601==
Content-Type: multipart/alternative; boundary=14dae93b5c5ed8ed5c04baa87cb0

--14dae93b5c5ed8ed5c04baa87cb0
Content-Type: text/plain; charset=ISO-8859-1

dear all:
I am working on arm cortex a8 now, trying to implement "suspend to ram"
based on linux 3.0.8.
Before i start my work, the soc already support standby(the cpu is on wfi
state), so in order to implement "suspend to ram", i think i just need to
implement the arch-specific related api. The "suspend to ram" works like
this:
"echo mem > /sys/power/state"  -> enter_state -> suspend_devices_and_enter
->suspend_ops->enter(state)
 Is that right? Do you think the "suspend to ram" can be realized in this
way?
In order to power off the cortex A8, i save all the writable co-processor
and   all modes's state register set, and restore them when resuming.
All the code seems work ok, because when I just does not power off the
cortex-A8 and jump to excute the resume code, the system works well. But,
when I power off the cpu, and wake up and excute resume code, the kernel
seem ok, but the busybox toolkit does not work proper, eg: "ls" can not
output the result through serial port. i add "printk statement" trying to
locate the reason, but at this time, the "ls" work fine.  hence, i doubt
something must be corrupted after resume.
I have checked all the state register and co-processor, having not found
any exception, and I also compared all the dram data before power off and
after wake up, nothing have changed. Right now, I do not know what has
happened, and what should I do to locate the real problem to make the
busybox works ok. I also want to know does the linux kernel 3.0.8 support
"suspend to ram" like this:
"echo mem > /sys/power/state"  -> enter_state -> suspend_devices_and_enter
->suspend_ops->enter(state)?
Can anyone give me some suggestion? Any comment is welcome, thanks a lot.

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--14dae93b5c5ed8ed5c04baa87cb0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><div>dear all:</div><div><span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span>I am working on arm cortex a8 now, trying to implement =
&quot;suspend to ram&quot; based on linux 3.0.8.=A0</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Before i start my wor=
k, the soc already support standby(the cpu is on wfi state), so in order to=
 implement &quot;suspend to ram&quot;, i think i just need to implement the=
 arch-specific related api. The &quot;suspend to ram&quot; works like this:=
=A0</div>
<div>&quot;echo mem &gt; /sys/power/state&quot; =A0-&gt; enter_state -&gt; =
suspend_devices_and_enter -&gt;suspend_ops-&gt;enter(state)</div><div>=A0Is=
 that right? Do you think the &quot;suspend to ram&quot; can be realized in=
 this way?</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>In or=
der to power off the cortex A8, i save all the writable co-processor and =
=A0 all modes&#39;s state register set, and restore them when resuming.=A0<=
/div><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>All the co=
de seems work ok, because when I just does not power off the cortex-A8 and =
jump to excute the resume code, the system works well. But, when I power of=
f the cpu, and wake up and excute resume code, the kernel seem ok, but the =
busybox toolkit does not work proper, eg: &quot;ls&quot; can not output the=
 result through serial port. i add &quot;printk statement&quot; trying to l=
ocate the reason, but at this time, the &quot;ls&quot; work fine. =A0hence,=
 i doubt something must be corrupted after resume.</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>I hav=
e checked all the state register and co-processor, having not found any exc=
eption, and I also compared all the dram data before power off and after wa=
ke up, nothing have changed. Right now, I do not know what has happened, an=
d what should I do to locate the real problem to make the busybox works ok.=
 I also want to know does the linux kernel 3.0.8 support &quot;suspend to r=
am&quot; like this:</div>
<div>&quot;echo mem &gt; /sys/power/state&quot; =A0-&gt; enter_state -&gt; =
suspend_devices_and_enter -&gt;suspend_ops-&gt;enter(state)?</div><div>Can =
anyone give me some suggestion? Any comment is welcome, thanks a lot. =A0=
=A0</div>
</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"HOEnZb"><font color=3D"#888888"><font class=3D"Apple-style-span" color=
=3D"#000000"><br>
</font>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-pm&quo=
t; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</font></span></blockquote></div><br>

--14dae93b5c5ed8ed5c04baa87cb0--


--===============2178936615952080601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============2178936615952080601==--
