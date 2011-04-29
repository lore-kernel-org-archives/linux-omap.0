From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 3/3] omap : nand : fix subpage ecc issue with prefetch
Date: Fri, 29 Apr 2011 21:30:11 +0530
Message-ID: <BANLkTi=c1Dc0Y=2eGof=5c4075=1RnCgdQ@mail.gmail.com>
References: <1304073070-24526-1-git-send-email-bdefaria@adeneo-embedded.com> <1304073070-24526-4-git-send-email-bdefaria@adeneo-embedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53690 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681Ab1D2QAe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2011 12:00:34 -0400
Received: by wya21 with SMTP id 21so2945194wya.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 09:00:33 -0700 (PDT)
In-Reply-To: <1304073070-24526-4-git-send-email-bdefaria@adeneo-embedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
Cc: linux-omap@vger.kernel.org, jjhiblot@adetelgroup.com, linux-mtd@lists.infradead.org

On Fri, Apr 29, 2011 at 4:01 PM, Bryan DE FARIA
<bdefaria@adeneo-embedded.com> wrote:
> When reading a subpage with a non dividable by 4 ecc number of byte, the
> prefetch function gets first the extra bytes, then reads the bytes lefting.
> Extra bytes are not returned in the buffer (they are overwritten), which makes
> the software ecc fail.

Its not only read, write too is broken for the same reason. More ever,
it is broken for
other path too (failing to enable prefetch engine path).

-- 
Regards,
Vimal Singh
