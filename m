From: "Budhee Jamaich" <budheej@gmail.com>
Subject: Re: powering up the mmc controller on 3430
Date: Mon, 8 Sep 2008 16:18:54 +0300
Message-ID: <57314e840809080618j1216436fh658507266d1ac579@mail.gmail.com>
References: <57314e840809071219w71ec6e40ja6a8bf8e05a876c1@mail.gmail.com>
	 <13B9B4C6EF24D648824FF11BE8967162036553308D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:2155 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbYIHNSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 09:18:55 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1578304wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 08 Sep 2008 06:18:55 -0700 (PDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036553308D@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Sep 8, 2008 at 4:49 AM, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> I believe the driver now calls this via its platform data in arch/arm/mach-omap2/.  Same sequence but now a bit more generalized from the external driver point of view.

Thank you, I will look into it....

Budhee
>
> Regards,
> Richard W.
>
>
