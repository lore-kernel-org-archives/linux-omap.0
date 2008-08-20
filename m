From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 0/0] Power domain and clock domain patches for omap
Date: Wed, 20 Aug 2008 08:20:55 +0000 (UTC)
Message-ID: <g8gk57$2ff$1@ger.gmane.org>
References: <1216221555-18958-1-git-send-email-tony@atomide.com>
	<g8feuo$i9$1@ger.gmane.org>
	<alpine.DEB.1.00.0808200034010.26647@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:39779 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbYHTIVJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Aug 2008 04:21:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KViwC-0007J6-4A
	for linux-omap@vger.kernel.org; Wed, 20 Aug 2008 08:21:04 +0000
Received: from ppp89-110-23-172.pppoe.avangarddsl.ru ([89.110.23.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 20 Aug 2008 08:21:04 +0000
Received: from dbaryshkov by ppp89-110-23-172.pppoe.avangarddsl.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 20 Aug 2008 08:21:04 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Paul Walmsley wrote:

> Hello Dmitry,
> 
> On Tue, 19 Aug 2008, Dmitry Baryshkov wrote:
> 
>> There is one major flaw IMO in this code. Please correct me if I'm
>> wrong: Driver A: powerdomain_register()
>> Driver B: powerdomain_get()
>> Driver A: powerdomain_unregister()
>> 
>> Then Driver B has a reference to unregistered domain. And as
>> powerdomains lack any type of refcounting this can lead to any type of
>> memory access bugs if Driver A is unloaded from the kernel.
> 
> At this point, only OMAP kernel init code registers powerdomains in
> arch/arm/mach-omap2/io.c.  It's not intended that driver code will
> manipulate or even know about these.

Anyway, this type of powerdomain_unregister() is asking for problems. Either
unregistering should be disallowed, or proper reference counting should be
implemented IMO.

-- 
With best wishes
Dmitry


