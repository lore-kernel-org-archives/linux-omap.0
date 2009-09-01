From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: USB confusion
Date: Tue, 01 Sep 2009 12:39:17 -0600
Message-ID: <4A9D6A55.1060906@mlbassoc.com>
References: <4A9D0898.4000400@mlbassoc.com> <5e088bd90909011114u4b047d9ft3d27ff3885dbd1ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:47102 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbZIASjR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 14:39:17 -0400
In-Reply-To: <5e088bd90909011114u4b047d9ft3d27ff3885dbd1ad@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org

On 09/01/2009 12:14 PM, Steve Sakoman wrote:
> On Tue, Sep 1, 2009 at 4:42 AM, Gary Thomas<gary@mlbassoc.com>  wrote:
>> What are the options to have USB Host support on the "normal"
>> USB channels (i.e. not the OTG port)?
>>
>> This used to work on my platform but things stopped when I
>> upgraded to the latest kernel :-(
>
> I had the same experience with Overo and posted a patch a couple of
> weeks ago to get it working (ARM: OMAP3: Overo: Fix EHCI
> initialization)

That fixed it (more precisely, the indirectly referenced patch
'fix phy_reset' fixed my problem)

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
