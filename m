From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v7] ARM: omap: edma: add suspend suspend/resume hooks
Date: Fri, 29 Nov 2013 09:57:13 +0100
Message-ID: <529856E9.8030708@gmail.com>
References: <1385560571-3939-1-git-send-email-zonque@gmail.com> <52984B98.5050202@cobham.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:60699 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab3K2I5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 03:57:25 -0500
Received: by mail-bk0-f50.google.com with SMTP id e11so4180443bkh.37
        for <linux-omap@vger.kernel.org>; Fri, 29 Nov 2013 00:57:24 -0800 (PST)
In-Reply-To: <52984B98.5050202@cobham.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Murphy <brian.murphy@cobham.com>
Cc: linux-omap@vger.kernel.org

On 11/29/2013 09:08 AM, Brian Murphy wrote:
> On 11/27/2013 02:56 PM, Daniel Mack wrote:
>> This patch makes the edma driver resume correctly after suspend. Tested
>> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
> 
> Can I ask which git this patch is relative to? There is no
> suspend/resume support for AM33xx in Linus Torvalds kernel as far as I 
> can see.

I am based on 3.13-rc1 with some patches from Suman Anna, Vaibhav Bedia
and Dave Gerlach that have been posted on arm-linux some month ago.

This patch can be merged independently as it has no dependency on those.

We already did the same for cppi41, musb, mcasp and some other drivers,
which gradually learn support for suspend in mainline now. Only the core
bits are missing, but I'm sure someone from TI is pushing them forward :)


Daniel

