From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Suspend to RAM broken on BeagleBoard ?
Date: Mon, 13 Sep 2010 07:56:54 -0700
Message-ID: <87eicx1ykp.fsf@deeprootsystems.com>
References: <20100910174814.6e5d439e@surf>
	<87sk1h4640.fsf@deeprootsystems.com> <20100911110007.5f7b529d@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40391 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab0IMO46 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 10:56:58 -0400
Received: by pvg2 with SMTP id 2so2161377pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Sep 2010 07:56:57 -0700 (PDT)
In-Reply-To: <20100911110007.5f7b529d@surf> (Thomas Petazzoni's message of
	"Sat, 11 Sep 2010 11:00:07 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> On Fri, 10 Sep 2010 14:54:23 -0700
> Kevin Hilman <khilman@deeprootsystems.com> wrote:
>
>> It's the CPUfreq driver that's failing to suspend.
>
> Ok.
>
>> Yes, CPUfreq is not supported in l-o master or pm-core (only in the
>> full pm branch.)  If you Kconfig out CPUfreq, this failure will go
>> away.
>
> Aah, yes, I forgot about this. I know it's temporary, but wouldn't it
> be good to disable CPUfreq in omap3_defconfig in this case ?

Yes.

> BTW, I'm now seeing:
>
> [   37.830596] Powerdomain (core_pwrdm) didn't enter target state 1
> [   37.830627] Powerdomain (dss_pwrdm) didn't enter target state 1
>
> when the system is woken up.

Looks like DSS has not been initialized, so is not hitting RET.

Do you have the DSS driver enabled and built-in?  Without this (and
until we have DSS converted to hwmod) the DSS HW is not in a state that
can hit the low power mode.  If the DSS driver is allowed to initialize,
even without a panel, it should set the DSS HW in a state that will then
allow RET.

Kevin



