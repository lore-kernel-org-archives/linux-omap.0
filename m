From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Restart after 4 min of operation?
Date: Tue, 03 Nov 2009 12:37:42 -0600
Message-ID: <4AF07876.4050602@billgatliff.com>
References: <4AEFA4EE.40308@billgatliff.com> <4AF01901.2050100@mlbassoc.com>,<4AF06CBA.3040609@billgatliff.com> <5A47E75E594F054BAF48C5E4FC4B92AB0309C8629B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:57984 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbZKCShj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 13:37:39 -0500
Received: by bwz27 with SMTP id 27so7924017bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 03 Nov 2009 10:37:42 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309C8629B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Gadiyar, Anand wrote:
> I suspect a watchdog timer of some kind, but I haven't got a clue which one.
>   

Turns out I had disabled watchdog timer support in my kernel. 
Re-enabling it seems to have addressed the problem--- the system has run
for more than 5 minutes now.  :)

Apparently, the default for the OMAP watchdog timer is "armed" at
reset?  Interesting.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

