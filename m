From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v1 00/10] OMAP: McBSP: hwmod adaptation and runtime
 conversion
Date: Wed, 22 Dec 2010 17:42:57 +0200
Message-ID: <20101222174257.06074d21.jhnikula@gmail.com>
References: <1292917231-13800-1-git-send-email-kishon@ti.com>
	<1292917231-13800-11-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:44675 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab0LVPnM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 10:43:12 -0500
Received: by bwz16 with SMTP id 16so5847790bwz.4
        for <linux-omap@vger.kernel.org>; Wed, 22 Dec 2010 07:43:11 -0800 (PST)
In-Reply-To: <1292917231-13800-11-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com

Hi

On Tue, 21 Dec 2010 13:10:31 +0530
Kishon Vijay Abraham I <kishon@ti.com> wrote:

> Modify OMAP McBSP driver to use omap hwmod framework and pm runtime APIs.
> 
> Created on top of linux OMAP master (linux-omap-2.6 :master)
> Tested on OMAP4430 and OMAP3430 SDP boards. Verified that this patch
> series does not break the OMAP1 build.
> 
Is there some patches missing or conflict with head
e8790546b376d9d77c541f8c17acb080e7342467 as the patch 02/10 doesn't
apply?

Applying: OMAP: McBSP: Convert McBSP to platform device model
error: patch failed: arch/arm/mach-omap1/mcbsp.c:78
error: arch/arm/mach-omap1/mcbsp.c: patch does not apply
Patch failed at 0001 OMAP: McBSP: Convert McBSP to platform device model

-- 
Jarkko
