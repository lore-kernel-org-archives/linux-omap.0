From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 09/13] OMAP2+: PM: export suspend_set_ops to PM modules
Date: Fri, 27 May 2011 17:28:11 -0700
Message-ID: <87boynvfc4.fsf@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
	<1305739950-11695-10-git-send-email-j-pihet@ti.com>
	<87lixt9hz8.fsf@ti.com>
	<BANLkTimsOMLWX0gmYKdF6XzwhMduGt2Q0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39645 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932094Ab1E1A2P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 20:28:15 -0400
Received: by pvf33 with SMTP id 33so1016707pvf.38
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 17:28:14 -0700 (PDT)
In-Reply-To: <BANLkTimsOMLWX0gmYKdF6XzwhMduGt2Q0A@mail.gmail.com> (Jean
	Pihet's message of "Fri, 27 May 2011 09:48:33 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Fri, May 27, 2011 at 1:09 AM, Kevin Hilman <khilman@ti.com> wrote:
>> jean.pihet@newoldbits.com writes:
>>
>>> From: Jean Pihet <j-pihet@ti.com>
>>>
>>> Export the suspend_set_ops API as omap_pm_suspend_set_ops in the pm
>>> generic code, under CONFIG_SUSPEND.
>>>
>>> Note -hack warning-: since the 'suspend_valid_only_mem' function is
>>> not exported to modules, fill the 'valid' field value of
>>> 'struct platform_suspend_ops' in the common code.
>>>
>>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>>
>> Can you try the patch below instead? =C2=A0 =C2=A0If that works, I'l=
l submit to
>> Rafael/linux-pm.
> This is much cleaner! We need this pushed upstream.

OK, thanks.  I just sent it to linux-pm.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
