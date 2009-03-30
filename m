From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Query about DSP_Close() function
Date: Mon, 30 Mar 2009 21:44:21 +0300
Message-ID: <94a0d4530903301144i38928c13wd9f802550ef8aa9b@mail.gmail.com>
References: <49D0F8DA.4060900@nokia.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2357EF0E@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:7682 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbZC3SoY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2009 14:44:24 -0400
Received: by fg-out-1718.google.com with SMTP id 16so381962fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2009 11:44:21 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2357EF0E@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, Doyu Hiroshi <hiroshi.doyu@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Mar 30, 2009 at 9:16 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Hi Ameya,
>
>> I am trying to make sure that when an application closes a file handle
>> all the resources are freed properly.
>>
>
> -- The current Bridge resource cleanup design is handling the resource cleanup in the Bridge open as opposed to do Bridge close.
> The Bridge Open function loops through cleaning up the resources (that weren't freed by the User applications) of all the processes that were killed.

Why? Wouldn't it make more sense to cleanup at close, exactly when the
file descriptor is closed?

-- 
Felipe Contreras
