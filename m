From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 0/8] staging: tidspbridge - misc fixes
Date: Tue, 26 Oct 2010 09:55:39 -0500
Message-ID: <AANLkTimgpj3iU3xQ8K7iwjMuaH3efgzsZfkzZU-H8Fxc@mail.gmail.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<20101026040619.GA8549@suse.de>
	<1288103059-notmuch-felipe.contreras@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62425 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab0JZOzl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 10:55:41 -0400
In-Reply-To: <1288103059-notmuch-felipe.contreras@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: gregkh@suse.de, x0095840@ti.com, hiroshi.doyu@nokia.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Oct 26, 2010 at 9:43 AM, Felipe Contreras
<felipe.contreras@nokia.com> wrote:
> gregkh@suse.de wrote:
>> On Mon, Oct 25, 2010 at 07:51:38PM -0500, Fernando Guzman Lugo wrote=
:
>> > This set of patches fix some issues found in lastest tree.
>> >
>> > Fernando Guzman Lugo (8):
>> > =A0 staging: tidspbridge - remove req_addr from proc_map
>> > =A0 staging: tidspbridge - add kconfig parameter for DMM size
>> > =A0 staging: tidspbridge - change mmufault tasklet to a workqueue
>> > =A0 staging: tidspbridge - fix timeout in dsp_gpt_wait_overflow
>> > =A0 staging: tidspbridge - use GTP7 for DSP stack dump
>> > =A0 staging: tidspbridge - remove disabling twl when printing DSP =
stack
>> > =A0 staging: tidspbridge - fix some issues after iommu patches
>> > =A0 staging: tidspbridge - make sync_wait_on_event interruptible
>>
>> Are any of these really applicable for .37 after .37-rc1? =A0Or can =
they
>> wait for .38?
>
> As of right now the dspbridge doesn't work, and there's a mess of
> dependencies to get it working.

Just to note that there will be one more dependency for SCM changes[1]
that will fix compilation, as these need to climb from linux-omap (if
accepted) before applying tidspbridge chunks.

Regards,
Omar

---
[1] http://marc.info/?l=3Dlinux-omap&m=3D128779652429922&w=3D2
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
