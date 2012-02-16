From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 6/6] arm: omap: pm-debug: enhanced usecount debug support
Date: Thu, 16 Feb 2012 12:14:16 -0600
Message-ID: <CAOMWX4di8HN=jk7MPVnusYfdYbC5Nj24trNuiy9paGvYFgbtgg@mail.gmail.com>
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
 <1329237402-26008-7-git-send-email-t-kristo@ti.com> <20120214202740.GT1426@atomide.com>
 <87fwed58dm.fsf@ti.com> <20120214235218.GX1426@atomide.com>
 <1329294866.4102.343.camel@sokoban> <874nus5djf.fsf@ti.com>
 <CAOMWX4cg4mfBQGcHLodjFaVY0vVGnKJKvsa9ngMLO-0Ca7gBTQ@mail.gmail.com> <87y5s2hebb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:49887 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445Ab2BPSOh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 13:14:37 -0500
Received: by mail-ww0-f48.google.com with SMTP id dq13so1391824wgb.5
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 10:14:36 -0800 (PST)
In-Reply-To: <87y5s2hebb.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: t-kristo@ti.com, Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 16, 2012 at 11:35, Kevin Hilman <khilman@ti.com> wrote:
>
>>> IMO, the one thing we're still missing is the ability to take register
>>> snapshots (like immediately before and after WFI) and somehow feed those
>>> to omapconf for deciphering.
>>>
>> Something like this perhaps?
>> https://github.com/nmenon/linux-omap-ti-pm/commit/3cd1994fc0df9a8e3e0be74ec3f3add3ff3aef95
>
> Yes, although that is targetted pretty narrowly at suspend and only PRM
> registers.
>
> Do you then use omapconf to display the results?
on the platform we worked on, not everyone had access to omapconf, it
was just 'cat' to take the dump.
omapconf support makes sense if this is a consistent interface cross
OMAP variants, even better if a similar
framework is available cross SoCs.

Regards,
Nishanth Menon
