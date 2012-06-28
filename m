From: "Franky Lin" <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: Panda ES board hang when using GPIO as interrupt
Date: Wed, 27 Jun 2012 17:41:56 -0700
Message-ID: <4FEBA854.5010508@broadcom.com>
References: <4FE8CF77.5080400@broadcom.com> <87txxxs9we.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87txxxs9we.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: tarun.kanti-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 06/26/2012 08:37 PM, Kevin Hilman wrote:
> "Franky Lin" <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> writes:
>> I noticed Kevin raised some similar cases on other platforms and also
>> provided two patches in the patch mail thread. But unfortunately those
>> two patches doesn't help in our case. I tested the driver with 3.5-rc3
>> mainline kernel and the issue is still there. I can only "fix" the
>> hang by either reverting the commit or disabling
>> CONFIG_PM_RUNTIME. Also, the hang only happens on Panda ES board. Old
>> Panda with 4430 works good.
>>
>> Any thoughts and suggestions?
>
> If reverting the patch fixes your problem, can you isolate down to which
> part of that patch causes the problem?  IOW, can you fix your problem if
> you undo just the hunk added in runtime_suspend or undo just the moved
> hunk runtime_resume?  Or is reverting both required?
>
> I suspect the added runtime_suspend hunk is causing the problems, so can
> you see if just undoing that part works[1].  If that works, I will give
> a bit more of a thinking on it tomorrow.

runtime_suspend hunk is fine. The hang still exist after reverting it. 
The culprit is the moved hunk in runtime_resume. Reverting it makes the 
hang disappear.

>
> Thanks for reporting the problem!   Bug reports like this that have
> clearly been thoroughly researched and bisected are greatly appreciated!
>
> Kevin
>

You are welcome.

Regards,
Franky

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
