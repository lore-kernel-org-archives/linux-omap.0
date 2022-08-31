Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B5EECAAD4
	for <linux-omap@archiver.kernel.org>; Wed, 31 Aug 2022 12:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiHaMaY (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiHaMaW (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 31 Aug 2022 08:30:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435424E62F
        for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2022 05:30:19 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0FDE751E;
        Wed, 31 Aug 2022 14:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661949017;
        bh=7C1hLpbibQ9ZIoWNrDKF4xMy0Jr3WhWNNj1DvS5iBRU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oOWirhapNqj1jrdhfciZJPHObURMcJrdMmiKsLslQByRC73Ay6CtHOG/fBms/d1jJ
         k329AcwWYHNXRaNrfdCLns7vFp8UU2OeDZoxM1XE0zbTKRLbyh34ZlsaecxBaOE2zg
         6i+mh5t01g6zejF+VVhLNum8pQNCLB/jpP7aFGnI=
Message-ID: <7a0d68b0-0458-9c12-0e8a-cb0ed402700a@ideasonboard.com>
Date:   Wed, 31 Aug 2022 15:30:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Unable to boot 6.0-rc3 on dra76
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Nishanth Menon <nm@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>
References: <abf4d275-b732-b1d5-35f0-40d78ef09962@ideasonboard.com>
 <Yw9MAKJyZlonv9b3@atomide.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <Yw9MAKJyZlonv9b3@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On 31/08/2022 14:54, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> [220831 11:35]:
>> Hi,
>>
>> I've been unable to boot 6.0-rc3 on dra76 evm with omap2plus_defconfig. I get no output from the kernel.
>> Enabling earlyprintk gives me the following. Any ideas?
> 
> This series of fixes for deferred probe in Linux next should help:
> 
> https://lore.kernel.org/linux-kernel/20220819221616.2107893-1-saravanak@google.com/
> 
> Hopefully it will get merged to the mainline kernel soonish.

Thanks Tony! This solves the issue.

  Tomi
