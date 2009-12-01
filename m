From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: ACPI notifier chain?
Date: Tue, 01 Dec 2009 11:58:23 +0200
Message-ID: <1259661503.1969.1.camel@sanganak>
References: <82cfbe860912010053s54ab1c51wfa3400fb9d0d7c89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53528 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbZLAJ6d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 04:58:33 -0500
In-Reply-To: <82cfbe860912010053s54ab1c51wfa3400fb9d0d7c89@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext tarek attia <tarek.m.attia@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Tarek,

On Tue, 2009-12-01 at 09:53 +0100, ext tarek attia wrote:
> Hi all,
> 
> Can I use the ACPI notifier chain to get noticed when any change for
> any peripheral has been occurred ?
> 
> Like the Video dimming ,can I make a Linux driver module to get
> informed once any change has been occurred to it??
> 
> 
> 
> Regards,
> 
> tarek

I believe ACPI is x86 architecture specific thing. I don't think it has
anything to do with ARM / OMAP.

Cheers,
Ameya.

