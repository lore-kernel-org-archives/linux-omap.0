From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] ARM: OMAP2+: Fix build issues with missing include of linux/bug.h
Date: Wed, 7 Mar 2012 17:31:19 -0800
Message-ID: <CAOesGMi3tf7_q1hwOXMGQBLW2EugDcUfH0yL=sgOtwBpYM7xjQ@mail.gmail.com>
References: <20120308012801.GO12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:45932 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab2CHBbU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 20:31:20 -0500
Received: by wibhm2 with SMTP id hm2so3776301wib.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 17:31:19 -0800 (PST)
In-Reply-To: <20120308012801.GO12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Mar 7, 2012 at 5:28 PM, Tony Lindgren <tony@atomide.com> wrote:
> Otherwise we can get the following if bug.h is not included from kernel.h:
>
> arch/arm/mach-omap2/powerdomain-common.c:
> In function 'omap2_pwrdm_get_mem_bank_onstate_mask':
> arch/arm/mach-omap2/powerdomain-common.c:64:3: error:
> implicit declaration of function 'WARN_ON' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied to next/fixes-non-critical. Thanks!


-Olof
