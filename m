From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: [Resend] [PATCH 1/3] Add MCSPI1 and gpio_85 Mux configuration
Date: Thu, 25 Sep 2008 11:27:14 +0530
Message-ID: <dfeb90390809242257x50e64be1t2fefc8f87af30ef9@mail.gmail.com>
References: <dfeb90390809242234h2264c7acw3003d6895574f002@mail.gmail.com>
	 <20080925085328.62009bf3.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:20442 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbYIYF5P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 01:57:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so297361rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 22:57:14 -0700 (PDT)
In-Reply-To: <20080925085328.62009bf3.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Sep 25, 2008 at 11:23 AM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> On Thu, 25 Sep 2008 11:04:07 +0530
> "ext Arun KS" <arunks@mistralsolutions.com> wrote:
>
>> This patch adds mcspi1 and gpio_85 mux configuration for 2430.
>>
>> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
>> ---
>>  arch/arm/mach-omap2/mux.c             |   10 ++++++++++
>>  arch/arm/plat-omap/include/mach/mux.h |    9 +++++++++
>>  2 files changed, 19 insertions(+), 0 deletions(-)
>>
> How about adding muxing for remaining 2430 McBSP ports 3-5 as well in
> this patch?

I will send a separate patch for that.

Arun
>
>
> Jarkko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
