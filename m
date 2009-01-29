From: Ramesh Gupta Guntha <grgupta77@gmail.com>
Subject: Re: [DSPBridge driver] bridgedriver: Unknown symbol __bad_func_type
Date: Thu, 29 Jan 2009 12:14:54 +0530
Message-ID: <3a2dabf50901282244n26f39318t80268334d9373f5e@mail.gmail.com>
References: <27F9C60D11D683428E133F85D2BB4A5303F7EA4D94@dlee03.ent.ti.com>
	 <F9F1042FDECC134ABFBF4EC5EBEC88DAB3600F@EXGZ02.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:28434 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbZA2Go4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 01:44:56 -0500
Received: by rv-out-0506.google.com with SMTP id g9so2142125rvb.5
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2009 22:44:54 -0800 (PST)
In-Reply-To: <F9F1042FDECC134ABFBF4EC5EBEC88DAB3600F@EXGZ02.sasken.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Krishna Kishore <krishna.kishore@sasken.com>
Cc: linux-omap@vger.kernel.org

Hi Krishna,


On 1/29/09, Krishna Kishore <krishna.kishore@sasken.com> wrote:
>
> Hi,
>
>   We are successful in building and using bridge driver with opensource
> linux kernel
>   (with kernel provided in CSSD 23.3,23.7 and 23.11 packages).
>
>   But, when we build bridge driver with a different kernel
> (Montavista), we are getting
>         "bridgedriver: Unknown symbol __bad_func_type"
>   when we install bridgedriver.ko.
>
>   Why is this problem occuring with one specific linux kernel?

Are you seeing any warnings while building the Bridgedriver with
Montavista kernel? I think may be some of the functions are not
supported in Montavista Kernel.

regards
Ramesh Gupta G
