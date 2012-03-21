From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC][PATCH 1/7] ARM: OMAP4: cpuidle - Remove unused valid field
Date: Wed, 21 Mar 2012 15:33:14 +0530
Message-ID: <4F69A762.5070006@ti.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
	<1332322070-24577-2-git-send-email-daniel.lezcano@linaro.org>
	<CAMQu2gw+GGnpG_s6TCk2fH094Lfmj1zgAZqQ4zdQmpj3ZZhu3w@mail.gmail.com>
	<4F69A37A.7020606@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F69A37A.7020606-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 21 March 2012 03:16 PM, Daniel Lezcano wrote:
> On 03/21/2012 10:41 AM, Shilimkar, Santosh wrote:
>> On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
>> <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>  wrote:
>>> The 'valid' field is never used in the code, let's remove it.
>>>
>>> Signed-off-by: Daniel Lezcano<daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> ---
>> It is used during the registration. This field has been very useful for
>> debug when need to disable a C-state etc.
>> So unless and until there is a strong reason, i would like to retain it.
> 
> IMO if it used for debug purpose, it should be moved to the debug code
> and if the debug code is not upstream, then that 'valid' should not be
> here but in the out-of-tree code.
>
When I said debug, I mean CPUIDLE debug and not any special debug code.

> By the way, this may be a debate for nothing because a patchset is on
> the way to disable C-states from sysfs.
> 
I see but sysfs won't solve that because you want to disable certain
C-state so that CPUIDLE driver don't use that state.

Let say if the C4 which is OSWR is broken. In such cases, just
setting valid flag let you disable it.

Again I don't have strong objection to this change.

Regards
santosh
