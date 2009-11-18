From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Force write last pad config register into save
	area
Date: Wed, 18 Nov 2009 06:16:26 -0800
Message-ID: <636c5030911180616u382584c4wff04d3122c1e1e4d@mail.gmail.com>
References: <1258475693-22068-1-git-send-email-tero.kristo@nokia.com>
	 <87my2lf1ai.fsf@deeprootsystems.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB030A9CAB51@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:35287 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756888AbZKROQU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 09:16:20 -0500
Received: by pzk1 with SMTP id 1so819501pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 06:16:26 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CAB51@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Nov 18, 2009 at 6:11 AM, Gopinath, Thara <thara@ti.com> wrote:
>
>
>>>-----Original Message-----
>>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger=
=2Ekernel.org] On Behalf Of Kevin
>>>Hilman
>>>Sent: Wednesday, November 18, 2009 12:04 AM
>>>To: Tero Kristo
>>>Cc: linux-omap@vger.kernel.org
>>>Subject: Re: [PATCH] OMAP3: PM: Force write last pad config register=
 into save area
>>>
>>>Tero Kristo <tero.kristo@nokia.com> writes:
>>>
>>>> From: Tero Kristo <tero.kristo@nokia.com>
>>>>
>>>> Due to OMAP3 errata XYZ, the save of the last pad register (ETK_D1=
4 and
>>>> ETK_D15) can fail sometimes when there is simultaneous OCP access =
to the
>>>> SCM register area. Fixed by writing the last register to the save =
area.
>>>>
>>>> Also, optimized the delay loop for the HW save to include an udela=
y(1),
>>>> which limits the number of unnecessary HW accesses to SCM register=
 area
>>>> during the save.
>>>>
>>>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>>>
>>>I certainly like this fix much better than the original proposal:
>>>
>>> =A0http://marc.info/?l=3Dlinux-omap&m=3D125474186609661&w=3D2
>
> Please do not merge this patch until TI officially confirms the worka=
round.
>

OK.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
