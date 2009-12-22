From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] io: remove redundant params in omap2_init_common_hw
Date: Tue, 22 Dec 2009 09:08:46 -0800
Message-ID: <871vinq6ld.fsf@deeprootsystems.com>
References: <1261228253-30283-1-git-send-email-nm@ti.com>
	<1261228253-30283-2-git-send-email-nm@ti.com>
	<4B2F1EC3.3060001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:33007 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbZLVRIu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 12:08:50 -0500
Received: by qw-out-2122.google.com with SMTP id 8so29037qwh.37
        for <linux-omap@vger.kernel.org>; Tue, 22 Dec 2009 09:08:49 -0800 (PST)
In-Reply-To: <4B2F1EC3.3060001@ti.com> (Romit Dasgupta's message of "Mon\, 21 Dec 2009 12\:37\:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romit Dasgupta <romit@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>

Romit Dasgupta <romit@ti.com> writes:

>> -	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>> +	omap2_init_common_hw(NULL, NULL);
>
>
> A call to a function with NULL parameters suggests that the function is doing
> more than it should. 

Not necessarily.  It can also suggest that this board does not want to
override any default settings.

> I think omap2_init_common_hw and omap2_sdrc_init,
> _omap2_init_reprogram_sdrc, gpmc init can be separated from
> omap2_init_common_hw. 
>
> If you are refactoring the code may be this should be taken care as
> well.

In this case, Nishanth is not refactoring, he's just removing some code
added earlier in the PM branch that is no longer needed.

A patch to do what you suggest (which is a good idea) should be a
separate patch and generated against l-o master.

Kevin

