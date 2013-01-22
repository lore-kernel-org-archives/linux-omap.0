From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [RFC v2 16/18] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Tue, 22 Jan 2013 13:50:15 +0100
Message-ID: <87sj5t4c1k.fsf@dell.be.48ers.dk>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
	<1356959231-17335-17-git-send-email-vaibhav.bedia@ti.com>
	<87ip6vlwaf.fsf@dell.be.48ers.dk>
	<B5906170F1614E41A8A28DE3B8D121433ECF118E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:43357 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab3AVMuU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 07:50:20 -0500
Received: by mail-bk0-f50.google.com with SMTP id jf3so3681533bkc.9
        for <linux-omap@vger.kernel.org>; Tue, 22 Jan 2013 04:50:19 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ECF118E@DBDE01.ent.ti.com>
	(Vaibhav Bedia's message of "Mon, 21 Jan 2013 10:37:06 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

>>>>> "V" == Bedia, Vaibhav <vaibhav.bedia@ti.com> writes:

Hi,

 V> +	memcpy((void *)wkup_m3_context->code, fw->data, fw->size);
 >> 
 >> A size check would be good. I don't know much about the finer details
 >> about the m3 and how it is connected, but don't you need to ensure data
 >> is flushed before resetting the m3?
 >> 

 V> Will add the reg property in the next version. The wkup-m3 memory is
 V> coming via ioremap() so AFAIK it should be ok. I realized that I do
 V> need to replace the memcpy() with memcpy_toio() here.

Ok, thanks.

-- 
Bye, Peter Korsgaard
