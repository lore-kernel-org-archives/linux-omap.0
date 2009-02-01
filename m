From: Ramesh Gupta Guntha <grgupta77@gmail.com>
Subject: Re: PM branch updates: 3430sdp and omap3evm results
Date: Sun, 1 Feb 2009 19:35:54 +0530
Message-ID: <3a2dabf50902010605n4f642d21p35d76f1eef8fa908@mail.gmail.com>
References: <87fxj4ty1l.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:62204 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbZBAOF4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Feb 2009 09:05:56 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1112461rvb.1
        for <linux-omap@vger.kernel.org>; Sun, 01 Feb 2009 06:05:54 -0800 (PST)
In-Reply-To: <87fxj4ty1l.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,


On 1/27/09, Kevin Hilman <khilman@deeprootsystems.com> wrote:
> Hello,
>
> I've updated the PM branch with a couple of fixes that get it working
> on the 3430SDP.
>
> For it to work on the SDP, you need the latest u-boot from the
> omapzoom u-boot tree[1].  This fixes the problems I was having with
> the D2D clockdomain remaining active or hanging upon clock disable.

I have tested this on my 3430SDP, I am seeing all domains hitting the off mode.

But I am seeing some issues while waking up iva domain after suspend.

There are couple of cases.

1. after booting the kernel
I run
echo 1 > /sys/power/clocks_off_while_idle
echo 1 > /sys/power/voltage_off_while_idle
echo 1 > /sys/power/enable_off_mode

and
echo mem > /sys/power/state
# echo mem > /sys/power/state
<6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
done.
Freezing user space processes ... Freezing user space processes ... (elapsed 0.0
0 seconds) (elapsed 0.00 seconds) done.
done.
Freezing remaining freezable tasks ... Freezing remaining freezable tasks ... (e
lapsed 0.00 seconds) (elapsed 0.00 seconds) done.done.

Suspending console(s) (use no_console_suspend to debug)
Suspending console(s) (use no_console_suspend to debug)
<6>Successfully put all powerdomains to target state
Successfully put all powerdomains to target state
Restarting tasks ... Restarting tasks ... done.
done.
#

If I install bridgedriver and enable iva2 clock I am getting below messages
clock: dpll2_ck failed transition to 'locked'

<3>clock: dpll2_ck failed transition to 'locked'
clock: dpll2_ck failed transition to 'locked'
<3>clock: dpll2_ck failed transition to 'locked'
clock: dpll2_ck failed transition to 'locked'

2. I run below commands as soon as kernel is booted.
echo 1 > /sys/power/clocks_off_while_idle
echo 1 > /sys/power/voltage_off_while_idle
echo 1 > /sys/power/enable_off_mode

installed bridge driver, loaded an dsp image(which also enables
iva2_ck, gpt6_ick/fck, mail box clocks)



I run system suspend, I am seeing all powerdomains enters into OFF
mode, but after this I am not able to wakeup iva domain, I reenabled
clocks but no use.

3. Without the option
echo 1 > /sys/power/clocks_off_while_idle every thing works fine but
perdomain is not hitting the off mode.


Please let me know any thoghts on these issues I am seeing.

-- 
Thanks
Ramesh Gupta G
