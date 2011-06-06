From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v10 0/7] MFD: TWL4030: power script and workaround for
 erratum 27
Date: Mon, 6 Jun 2011 19:35:13 +0530
Message-ID: <BANLkTi=SXRJ7dAJ+X-Fz_7TGJrKT8dnQag@mail.gmail.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
	<87lixjlpr3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45651 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752036Ab1FFOFO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jun 2011 10:05:14 -0400
Received: by mail-wy0-f182.google.com with SMTP id 23so5134621wyf.27
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 07:05:13 -0700 (PDT)
In-Reply-To: <87lixjlpr3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Fri, Jun 3, 2011 at 6:01 AM, Kevin Hilman <khilman@ti.com> wrote:
> Lesly A M <leslyam@ti.com> writes:
>
>> Patch series for TWL4030 power scripts for OMAP3 boards and
>> workaround for TWL erratum 27.
>>
>> Changes for implementing TWL4030 power scripts recommended by hardwa=
re team.
>> Introduced a new TWL4030 power script file, which can be used by dif=
ferent
>> OMAP3 board with the power companion chip TWL4030.
>>
>> Updated the changes for TWL4030 errata 27 & 28, and modified
>> the TWL4030 power script.
>> Workaround for TWL4030 erratum 27 is required for Si version less th=
an or
>> equal to TWL5030 ES1.1.
>>
>> TWL4030 script changes re-based on Kevin's PM tree in pm branch.
>
> Please update and rebase against mainline. =A0 There should be no
> dependencies on my tree. =A0I see Samuel has merged many of these alr=
eady,
> so the remaining ones need a refresh and retest.

Ok, I will rebase the changes.

Regards,
Lesly
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
