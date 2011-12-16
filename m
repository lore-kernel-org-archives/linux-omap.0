From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Fri, 16 Dec 2011 21:39:38 +0530
Message-ID: <CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
 <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:60678 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932106Ab1LPQKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 11:10:06 -0500
Received: by mail-qw0-f54.google.com with SMTP id g14so2154088qab.20
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 08:10:04 -0800 (PST)
In-Reply-To: <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

On Fri, Dec 16, 2011 at 9:27 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Hi,
>
> On Fri, Dec 16, 2011 at 9:24 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>
>> Also I have tried to add 'l3_2_clkdm' into dependency table of iss_clkdm in [2],
>> and it doesn't work.
>
> Also, I still have the question why the static dependency isn't generated from
> the table .wkdep_srcs of struct clockdomain? Seems the static dep info has been
> put inside the tables.
>
No. The table reflects the actual possible combination on hardware. You can't
add anything there arbitrary if that combination is not supported.

But that makes me wonder how the patch worked. I will look at this in detail
next week.

Regards
Santosh
