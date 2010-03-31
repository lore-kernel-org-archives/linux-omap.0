From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCHv2 1/3] OMAP3: PM: Fix crash when enabling SmartReflex
 on non-supported OMAPs.
Date: Wed, 31 Mar 2010 06:07:35 -0500
Message-ID: <4BB32CF7.9000309@gmail.com>
References: <1270017014-27704-1-git-send-email-thara@ti.com> <1270017014-27704-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55396 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756861Ab0CaLHi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 07:07:38 -0400
Received: by gwaa18 with SMTP id a18so5316384gwa.19
        for <linux-omap@vger.kernel.org>; Wed, 31 Mar 2010 04:07:38 -0700 (PDT)
In-Reply-To: <1270017014-27704-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath said the following on 03/31/2010 01:30 AM:
> This patch sets and unsets is_sr_reset is appropriate places so that
> trying to enable smart reflex in a non-supported OMAP chip does not
> lead to unnecessary crash. Basically today if sr_enable fails,
> sr_disable will crash due to accessing sr registers when sr clocks
> are not turned on. By checking on is_sr_reset flag and setting and
> unsetting this flag appropriately this crash is fixed in this
> patch.
>
>
>   
I think this may belong in your first series -
 34xx patchset as this does not have much to do with 3630..

-- 
Regards,
Nishanth Menon
