From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 7/7] ARM: OMAP2+: PM: reorganize the powerdomain API in
 public and private parts
Date: Thu, 13 Sep 2012 09:29:25 +0200
Message-ID: <CAORVsuUi+8LjRRrDcuKZCL2nxPab1murkSc4eBrxhg1TY4=sTw@mail.gmail.com>
References: <1347443732-7411-1-git-send-email-j-pihet@ti.com>
	<1347443732-7411-8-git-send-email-j-pihet@ti.com>
	<87r4q6rdcu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36495 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756400Ab2IMH31 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 03:29:27 -0400
Received: by lagy9 with SMTP id y9so1711293lag.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 00:29:26 -0700 (PDT)
In-Reply-To: <87r4q6rdcu.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Jean Pihet <j-pihet@ti.com>

On Thu, Sep 13, 2012 at 2:11 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> The newly added code for functional power states re-defines the
>> API to query and control the power domains settings.
>>
>> The API is now split in the following parts in powerdomain.h:
>> - the public or external API, to be used by external PM components:
>>   cpuidle, suspend, pmxxxx, clock* etc.
>> - the private or internal API, to be used by the low level PM code
>>   only: powerdomain*, pm-debug, hwmod, voltage, clockdomainxxxx.
>>
>> The function omap_set_pwrdm_state is not used anymore and so is
>> removed.
>>
>> No functional change is introduced by this patch.
>>
>> Note: the API reorganization in a public and private header files
>> is not part of this patch, this comes as a subsequent clean-up
>> patch series.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> In addition to reorganizing the API, I suspect there are a handful of
> out-of-tree hacks, er, users, that will are using the internal state
> names, as well as the functions that should now only be internal.
The API clean-up series (planned after this one is in the queue) will
sort out the public vs private APIs using different header files and
static functions.

> As part of the subsequent cleanup series, it would it make sense to add
> a '_' prefix to the internal names as well to catch unintentional use of
> internal APIs?
Sure.

>
> Kevin

Thanks,
Jean
