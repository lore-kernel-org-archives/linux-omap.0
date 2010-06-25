From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Fri, 25 Jun 2010 17:04:13 -0600
Message-ID: <AANLkTimB0_OfLDvtkwwTE-kVeZrardIxVIsD5IEia-vL@mail.gmail.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<874ogrng3j.fsf@deeprootsystems.com> <AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
	<876316eno5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40134 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab0FYXEf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 19:04:35 -0400
Received: by iwn41 with SMTP id 41so2484302iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 16:04:33 -0700 (PDT)
In-Reply-To: <876316eno5.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.miao@canonical.com>, Nicolas Pitre <nico@fluxnic.net>

On Fri, Jun 25, 2010 at 4:46 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
>
>> Another way to look at the problem is that these runtime
>> customizations are kind of a property of the parent device (the bus,
>> not the bus_type). =A0Would it make sense for parent devices to have
>> runtime ops to perform for each child that is suspended/resumed? =A0=
That
>> would make it simple to register another device that implements the
>> bus behaviour and attach it at runtime instead of compile time.
>
> Maybe I didn't fully understand your idea, but the problem here is
> devices do not have dev_pm_ops. =A0Only busses, classes, and types ha=
ve
> dev_pm_ops.

Sorry, I mistyped.  What I meant was for the parent device's
device_driver to be able to have a set of child dev_pm_ops; but I'm
wading into territory (power management) I'm not particularly familiar
with, and that might be making things far too complex.

> Though I'm horribly unfamiliar with the intended usage of 'struct
> device_type', an interesing discovery is that dev->type also has
> dev_pm_ops, and it takes precedence over the bus type in the
> suspend/resume. =A0IOW, when suspending, when deciding which dev_pm_o=
ps to
> use, it checks class, type, then bus in that order.

So I guess my suggestion above boils down to somehow inserting
"parent" between type and bus in that list.

> I need to explore this 'type' feature a little more, but using that o=
r
> the 'class' might be another way to have custom PM ops for certain
> platform_devices.

Should maybe start cc'ing Greg and linux-kernel/linux-pm in this discus=
sion.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
