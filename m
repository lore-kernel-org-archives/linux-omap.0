From: Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx
	cleanups
Date: Tue, 1 May 2012 12:25:24 +0300
Message-ID: <CAP245DV+uJt3Ke7TbHvtTe2=e8JvckZiyyYY5p0xW6T-oLs3Ew@mail.gmail.com>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
	<4F98740F.1020402@linaro.org> <87vckgltdg.fsf@ti.com>
	<4F9F9BC1.9020908@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Lists linaro-dev <linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 1, 2012 at 11:16 AM, Daniel Lezcano
<daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 05/01/2012 12:58 AM, Kevin Hilman wrote:
>>
>> Daniel Lezcano<daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> =A0writes:
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
>> Without offlining CPU1, none of this code is executed. =A0Can you test
>> with CPU1 offlined?
>
>
> Unfortunately my OMAP4 board burned :/ I am waiting for a new one.
> Rob tested the series but when he unplugged the cpu1, the kernel panics f=
or
> another reason. I guess the problem should have been fixed since the last
> testing.
>
> Rob ? Do you mind the test the series again, the problem you were facing
> when unplugging the cpu1 may have been fixed.

I'd rather have someone from the OMAP community that understands the
internals test this - adding Santosh to see if he can bring some
engineering time to bear on this series.

> Mike ? if you have time, is it possible you test it on your board ?

And Mike and Rajendra, if you could help with this, it would be great.
We'd really like to get various platform cpuidle driver changes in for
3.5 so that Daniel can take a stab at more consolidation for the core
in the next cycle.

/Amit
