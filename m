From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Suspend to RAM broken on BeagleBoard ?
Date: Mon, 13 Sep 2010 12:01:07 -0700
Message-ID: <87mxrlzcwc.fsf@deeprootsystems.com>
References: <20100910174814.6e5d439e@surf>
	<87sk1h4640.fsf@deeprootsystems.com> <20100911110007.5f7b529d@surf>
	<87eicx1ykp.fsf@deeprootsystems.com> <20100913173933.5d0a6392@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49181 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab0IMTBL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 15:01:11 -0400
Received: by pzk34 with SMTP id 34so2255817pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Sep 2010 12:01:10 -0700 (PDT)
In-Reply-To: <20100913173933.5d0a6392@surf> (Thomas Petazzoni's message of
	"Mon, 13 Sep 2010 17:39:33 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> Hello,
>
> On Mon, 13 Sep 2010 07:56:54 -0700
> Kevin Hilman <khilman@deeprootsystems.com> wrote:
>
>> Looks like DSS has not been initialized, so is not hitting RET.
>> 
>> Do you have the DSS driver enabled and built-in?  Without this (and
>> until we have DSS converted to hwmod) the DSS HW is not in a state that
>> can hit the low power mode.  If the DSS driver is allowed to initialize,
>> even without a panel, it should set the DSS HW in a state that will then
>> allow RET.
>
> Indeed:
>
> $ grep DSS .config
> # CONFIG_OMAP2_DSS is not set
>
> It's not enabled simply because it isn't enabled by omap3_defconfig. So
> maybe it should also be fixed for this ?
>
> I have zero knowledge of DSS, but shouldn't the kernel be able to
> suspend properly even if the DSS driver is disabled ? 

Yes, it should, and it's almost there.

> But maybe it's too complicated to have the DSS init sequence required
> to allow the system to hit RET outside the DSS driver. Thoughts ?

One of the multiple motivations for moving to the omap_hwmod model of
describing all the HW IP blocks in a central location is so that we have
a common init and reset for every on-chip device. 

Once an omap_hwmod exists for a device, during init, the hwmod core will
ensure that that block is properly initialized, reset and in a state
that will not prevent the chip from entering low-power sleep.  This will
happen in the hwmod core, and is independent of the existence of a
driver for that device, so will solve problems like this one.

Currently, we have a hack here and a hack there for common devices that
the bootloader blindy leaves in an state that prevents low-power states,
but this is clearly a hack and does not scale.  omap_hwmod is the
solution to scaling this to every IP block.

Kevin




