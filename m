From: David Marlin <dmarlin@redhat.com>
Subject: Re: unhandled fault on reboot/shutdown
Date: Tue, 24 Jan 2012 11:15:52 -0600
Message-ID: <4F1EE748.7090601@redhat.com>
References: <4F1CAC71.9080109@redhat.com> <alpine.DEB.2.00.1201230038590.13827@utopia.booyaka.com>
Reply-To: dmarlin@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23159 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393Ab2AXRP5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 12:15:57 -0500
In-Reply-To: <alpine.DEB.2.00.1201230038590.13827@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-pm@vger.kernel.org


Paul Walmsley wrote:
> cc linux-pm
> 
> Hi
> 
> On Sun, 22 Jan 2012, David A. Marlin wrote:
> 
>> I experience an unhandled fault on reboot/shutdown using the ARM-OMAP
>> kernel-2.6.41.3-1 and later (from Fedora) on a Panda Board.  I have logged a
>> bug in:
>>
>>   https://bugzilla.redhat.com/show_bug.cgi?id=781552
>>
>> which provides the details, and a work around which reverts one commit from
>> kernel-3.1.3.
>>
>> Please let me know if you require any additional information or have changes
>> for me to try.
> 
> That commit that you referenced in your bug report -- which is actually 
> mainline commit af8db1508f2c9f3b6e633e2d2d906c6557c617f9 ("PM / driver 
> core: disable device's runtime PM during shutdown") -- is broken.
> 
> Consider leaving it reverted or backporting Alan Stern's commit 
> fe6b91f47080eb17d21cbf2a39311877d57f6938 ("PM / Driver core: leave runtime 
> PM enabled during system shutdown").

Thank you for the information.  We will leave this one reverted for now, 
and catch Alan Stern's commit in the next version.


Thanks again,

d.marlin
===========

> 
> 
> - Paul
