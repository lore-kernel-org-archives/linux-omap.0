From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: query: omap-defconfigs
Date: Wed, 12 Aug 2009 20:09:54 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5A38748@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F598989C@dbde02.ent.ti.com>
 <87iqgt14n6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36337 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbZHLOkC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 10:40:02 -0400
In-Reply-To: <87iqgt14n6.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>"Pandita, Vikram" <vikram.pandita@ti.com> writes:
>
>> For the omap board defconfigs, is there a plan to remove these entries:
>> CONFIG_SYSFS_DEPRECATED=y
>> CONFIG_SYSFS_DEPRECATED_V2=y
>>
>> I can see that on pm branch on kevin's tree, these are not enabled.
>>
>> With older busybox, I needed these entries to be enabled, but switching to latest busybox 1_9_2 I
>could disable these entries without problem.
>>
>> Anything we would break by removing these DEPRECATED entries?
>
>I vote to remove them since using OE or OE-based distros like Arago
>require them to be disabled.

I can post a patch removing these from all omap defconfigs if no one has an objection.

Vikram


