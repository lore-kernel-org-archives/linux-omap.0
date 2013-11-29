From: Brian Murphy <brian.murphy@cobham.com>
Subject: Re: [PATCH v7] ARM: omap: edma: add suspend suspend/resume hooks
Date: Fri, 29 Nov 2013 09:08:56 +0100
Message-ID: <52984B98.5050202@cobham.com>
References: <1385560571-3939-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og125.obsmtp.com ([64.18.2.28]:51359 "EHLO
	exprod7og125.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab3K2IKK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 03:10:10 -0500
In-Reply-To: <1385560571-3939-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-omap@vger.kernel.org

On 11/27/2013 02:56 PM, Daniel Mack wrote:
> This patch makes the edma driver resume correctly after suspend. Tested
> on an AM33xx platform with cyclic audio streams and omap_hsmmc.

Can I ask which git this patch is relative to? There is no
suspend/resume support for AM33xx in Linus Torvalds kernel as far as I 
can see.

/Brian
