From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Overo defconfig for omap-2.6.30
Date: Wed, 15 Jul 2009 11:16:09 -0700
Message-ID: <87tz1d7qxi.fsf@deeprootsystems.com>
References: <F2B67B67-3E11-4CEF-8FB4-49EE9C05F2B9@mac.com>
	<874otd97ty.fsf@deeprootsystems.com>
	<DB30225E-E3F3-4626-9B5D-5BD72DF25DA9@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:34927 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756015AbZGOSQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 14:16:16 -0400
Received: by bwz28 with SMTP id 28so1587237bwz.37
        for <linux-omap@vger.kernel.org>; Wed, 15 Jul 2009 11:16:14 -0700 (PDT)
In-Reply-To: <DB30225E-E3F3-4626-9B5D-5BD72DF25DA9@mac.com> (Elvis Dowson's message of "Wed\, 15 Jul 2009 21\:38\:32 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Elvis Dowson <elvis.dowson@mac.com> writes:

> Hi Kevin,
>
> On Jul 15, 2009, at 9:25 PM, Kevin Hilman wrote:
>
>> I use omap3_pm_defconfig for all boards.
>
> Could you tell me where it is located in the tree?
>

In the PM branch, this is under arch/arm/configs.

or, just do 'make omap3_pm_defconfig'

Kevin

