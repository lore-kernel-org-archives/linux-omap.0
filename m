From: "Que, Simon" <sque@ti.com>
Subject: RE: [PATCH 3/5] omap:hwspinlock-added hwspinlock driver
Date: Wed, 11 Aug 2010 17:03:12 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9D14@dlee03.ent.ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
 <1279558221-14954-4-git-send-email-h-kanigeri2@ti.com>
 <4C518AC0.6070809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53030 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334Ab0HKWDP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 18:03:15 -0400
In-Reply-To: <4C518AC0.6070809@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Nishanth,

> just a curious question:
> 
> Is there no h/w spinlock implementation for other architectures in
> linux? I mean the concept does not seem unique for a heterogenous
> processor environments now a days.. if it does exist, maybe we have two
> options:
> * extend standard spinlock architecture to handle h/w spinlocks as well
> * establish a new framework for h/w spinlocks..
> 

Thank you for bringing that to my attention.  I did a quick search and haven't found any hwspinlock module elsewhere.  But should there be hwspinlocks over multiple architectures in the future, we can definitely consider something like the two solutions that you suggested, so that they can be used from platform-independent kernel code.  However, right now we can develop OMAP hwspinlock independently of that.

Thanks,
Simon
