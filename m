From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v7 00/12] omap3: pm: TWL4030 power scripts and workaround
 for TWL errata 27
Date: Wed, 2 Mar 2011 11:24:08 +0530
Message-ID: <AANLkTinkeZrJD+6hyQeTLK1VSEYDhXe3=y4yJ_7byCOQ@mail.gmail.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
	<8739n6h43i.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:52866 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751526Ab1CBFyK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 00:54:10 -0500
Received: by mail-vw0-f48.google.com with SMTP id 20so5887654vws.7
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 21:54:08 -0800 (PST)
In-Reply-To: <8739n6h43i.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Wed, Mar 2, 2011 at 3:54 AM, Kevin Hilman <khilman@ti.com> wrote:
> Lesly A M <leslyam@ti.com> writes:
>
>> Patch series for TWL4030 power scripts and workaround for TWL errata 27.
>>
>> Changes for implementing TWL4030 power scripts recommended by hardware team.
>> Introduced a new TWL4030 power script file, which can be used by different
>> OMAP3 board with the power companion chip TWL4030.
>>
>> Updated the changes for TWL4030 errata 27 & 28, modified the
>> TWL4030 power script and voltage controller setuptime.
>> Workaround for TWL4030 errata 27 & 28 is required for
>> Si version less than or equal to TWL5030 ES1.1.
>>
>> TWL4030 script changes rebased on Kevin's PM tree in pm branch.
>
> What is the dependency on my PM branch?
>
> It looks like this can be based on mainline or l-o master.
>

OFFMODE was not working on mainline and l-o master.

Regards,
Lesly A M

< ... >
