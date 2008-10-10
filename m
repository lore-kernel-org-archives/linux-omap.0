From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: Git tree updated to v2.6.27, some issues remain
Date: Fri, 10 Oct 2008 15:29:26 -0700
Message-ID: <e5e6ade50810101529y53a1e203g68d5faeaaada22c7@mail.gmail.com>
References: <20081010120427.GZ3044@atomide.com>
	 <200810100843.47808.david-b@pacbell.net>
	 <5e088bd90810100857p2cea5429s810c9810f05bd341@mail.gmail.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870239624A2E@dbde02.ent.ti.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870239624A46@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:35528 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbYJJW31 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 18:29:27 -0400
Received: by qw-out-2122.google.com with SMTP id 3so240099qwe.37
        for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 15:29:26 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870239624A46@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Fri, Oct 10, 2008 at 3:15 PM, Pandita, Vikram <vikram.pandita@ti.com> wrote:
> Theory changed. NR_IRQS is 402. so above is not the issue.
>
> Theory 2:
> When I debug on LDP board, I can see the failure happening in request_irq()
>
> In T2-probe:
>        request_irq( ... )
>                ...
>                if (irq_desc[irq].status & IRQ_NOREQUEST)
>                        return -EINVAL; >>>> code returns from here !!!
>                ...

This is exactly what I saw when testing bare linux-omap git without
Dave's i2c retry patch.  Maybe the patch is not working for you?

- Nathan
