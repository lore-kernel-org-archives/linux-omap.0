From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx
	cleanups
Date: Tue, 1 May 2012 15:25:54 +0530
Message-ID: <CAMQu2gzK=u1kkbv9nzRyO3xbqVhZkf0KP=ceCyNteSituBZPrg@mail.gmail.com>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
	<4F98740F.1020402@linaro.org> <87vckgltdg.fsf@ti.com>
	<4F9F9BC1.9020908@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2008321107981267215=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F9F9BC1.9020908-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============2008321107981267215==
Content-Type: multipart/alternative; boundary=20cf302d4ccea1be3004bef693a3

--20cf302d4ccea1be3004bef693a3
Content-Type: text/plain; charset=ISO-8859-1

On May 1, 2012 1:46 PM, "Daniel Lezcano" <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> On 05/01/2012 12:58 AM, Kevin Hilman wrote:
>>
>> Daniel Lezcano<daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>  writes:
>>
>>> On 04/24/2012 04:05 PM, Daniel Lezcano wrote:
>>>>
>>>> This patchset makes some cleanup on these cpuidle drivers
>>>> and consolidate the code across both architecture.
>>>>
>>>> Tested on OMAP3 (igepV2).
>>>> Partially tested on OMAP4 (pandaboard), without offlining the cpu1.
>>
>>
>> Without offlining CPU1, none of this code is executed.  Can you test
>> with CPU1 offlined?
>
>
> Unfortunately my OMAP4 board burned :/ I am waiting for a new one.
> Rob tested the series but when he unplugged the cpu1, the kernel panics
for another reason. I guess the problem should have been fixed since the
last testing.
>
>  Rob ? Do you mind the test the series again, the problem you were facing
when unplugging the cpu1 may have been fixed.
>
Have already tested this series on omap4 with cpu offline as well as with
couple idle series on top of it.
I haven't finished omap3 testing and hence not reported yet. Omap4
continies to work with subject series.

Regards
Santosh

--20cf302d4ccea1be3004bef693a3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>
On May 1, 2012 1:46 PM, &quot;Daniel Lezcano&quot; &lt;<a href=3D"mailto:da=
niel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 05/01/2012 12:58 AM, Kevin Hilman wrote:<br>
&gt;&gt;<br>
&gt;&gt; Daniel Lezcano&lt;<a href=3D"mailto:daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">dan=
iel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt; =A0writes:<br>
&gt;&gt;<br>
&gt;&gt;&gt; On 04/24/2012 04:05 PM, Daniel Lezcano wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This patchset makes some cleanup on these cpuidle drivers<=
br>
&gt;&gt;&gt;&gt; and consolidate the code across both architecture.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Tested on OMAP3 (igepV2).<br>
&gt;&gt;&gt;&gt; Partially tested on OMAP4 (pandaboard), without offlining =
the cpu1.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Without offlining CPU1, none of this code is executed. =A0Can you =
test<br>
&gt;&gt; with CPU1 offlined?<br>
&gt;<br>
&gt;<br>
&gt; Unfortunately my OMAP4 board burned :/ I am waiting for a new one.<br>
&gt; Rob tested the series but when he unplugged the cpu1, the kernel panic=
s for another reason. I guess the problem should have been fixed since the =
last testing.<br>
&gt;<br>
&gt;=A0 Rob ? Do you mind the test the series again, the problem you were f=
acing when unplugging the cpu1 may have been fixed.<br>
&gt;<br>
Have already tested this series on omap4 with cpu offline as well as with c=
ouple idle series on top of it. <br>
I haven&#39;t finished omap3 testing and hence not reported yet. Omap4 cont=
inies to work with subject series.</p>
<p>Regards<br>
Santosh</p>

--20cf302d4ccea1be3004bef693a3--


--===============2008321107981267215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============2008321107981267215==--
