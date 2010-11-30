From: Anand Gadiyar <gadiyar@ti.com>
Subject: Re: [PATCH v2 2/4] arm: omap4: usb: add platform init code for EHCI
Date: Wed, 01 Dec 2010 03:36:30 +0530
Message-ID: <4CF57566.2060800@ti.com>
References: <1291051572-24084-1-git-send-email-gadiyar@ti.com> <1291051572-24084-3-git-send-email-gadiyar@ti.com> <20101130214045.GA17222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:40007 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753653Ab0K3WGj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 17:06:39 -0500
In-Reply-To: <20101130214045.GA17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Greg KH <gregkh@suse.de>

On 12/1/2010 3:10 AM, Tony Lindgren wrote:
> * Anand Gadiyar <gadiyar@ti.com> [101129 09:16]:
>> - Add platform init code for EHCI on OMAP4
>> - Add pad configuration for PHY and TLL modes
>>
>> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> 
> Looks OK to me. You might want to check if all these signals
> are unique though and do not have alternate paths.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

I've checked these manually - for EHCI, all signals are unique
and come out on exactly one pad. With OHCI though, there are
alternates for 3 signals of one port.

Also, with the mux framework, it tells us if there are
duplicates and the framework cannot identify the pad from
the signal name alone.

- Anand

