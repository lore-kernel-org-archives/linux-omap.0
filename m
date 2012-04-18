From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 7/9] ARM: OMAP2+: SmartReflex: Use per-OPP data structure
Date: Wed, 18 Apr 2012 22:52:31 +0200
Message-ID: <CAORVsuXup38v0qhSSm7oeo5uzBN-Kd9T91_Zi4mtY_CG6L_QsA@mail.gmail.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
	<1332173578-27422-8-git-send-email-j-pihet@ti.com>
	<87y5pskiis.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56160 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab2DRUwb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 16:52:31 -0400
Received: by vcqp1 with SMTP id p1so5170228vcq.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 13:52:31 -0700 (PDT)
In-Reply-To: <87y5pskiis.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>, Paul Walmsley <paul@pwsan.com>, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>

On Wed, Apr 18, 2012 at 8:21 PM, Kevin Hilman <khilman@ti.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The SmartReflex driver incorrectly treats some per-OPP data as data
>> common to all OPPs (e.g., ERRMINLIMIT). =A0Move this data into a per=
-OPP
>> data structure.
>
> OK
>
>> The SmartReflex driver should not be dependent on whether the host S=
oC
>> uses eFuses to store SmartReflex parameters or not. =A0(Even SoCs th=
at
>> do store SR data in eFuses often need to override that data with
>> software-defined values.) =A0So, convert sr_retrieve_nvalue() to loo=
k up
>> per-OPP data by the OPP's nominal voltage, rather than by the eFuse
>> offset.
>
> Right.
>
>> While at it:
>> =A0. tidy up the code wrt default values in the data tables,
>> =A0. remove the global errminlimit debugfs entry and create per-volt=
age
>> =A0 =A0entries from the data tables.
>
> OK
>
>> Furthermore, in order to make the SmartReflex implementation ready f=
or
>> the move to drivers/, remove the dependency from the SR driver code
>> to the voltage layer by querying the data tables only from the SR de=
vice
>> init code.
>
> So that's 4 relatively independent things going on in this patch whic=
h
> makes it somewhat difficult to review and understand.
>
> I'd suggest breaking it up into smaller parts if possible. =A0If not,=
 fix
> up the changelog to describe why all of these need to go together, an=
d
> why it's necessary to do them before the move.
Those changes are not independent from each other.
However for improved readability the patch can be split up (e.g.
efuse->opp, debugfs ...) and the changelog updated accordingly.

>
> Thanks,
>
> Kevin
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
