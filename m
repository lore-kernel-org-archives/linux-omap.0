From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v10 3/7] MFD: TWL4030: Modifying the macro name Main_Ref
 to all caps
Date: Fri, 13 May 2011 12:42:53 +0530
Message-ID: <BANLkTim0Rsjxpr7HZg-AU4hXxesa7uswEA@mail.gmail.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
	<1304687833-4578-4-git-send-email-leslyam@ti.com>
	<20110512104208.GL31483@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:47844 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757077Ab1EMHMz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 03:12:55 -0400
Received: by wwf26 with SMTP id 26so1947346wwf.20
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 00:12:53 -0700 (PDT)
In-Reply-To: <20110512104208.GL31483@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Tony,

On Thu, May 12, 2011 at 4:12 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Lesly A M <leslyam@ti.com> [110506 06:14]:
>> Modifying the macro name Main_Ref to all caps(MAIN_REF).
>
> This may get counted as "crazy churn" patch.. Please provide
> some reason for doing this in the patch description.

I will update the change logs.

Explained in Chapter 12 Documentation/CodingStyle.

As per coding-style the macro name should be capitalized.
So modifying the macro name Main_Ref to all caps(MAIN_REF).

Regards
Lesly
