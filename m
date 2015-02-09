From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] ARM: DTS: omap3-n900.dts: fix i2c bus numbering
Date: Mon, 09 Feb 2015 18:03:34 +0200
Message-ID: <54D8DA56.8060400@gmail.com>
References: <1423410536-16579-1-git-send-email-ivo.g.dimitrov.75@gmail.com> <20150209150245.GC21362@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:51223 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933203AbbBIQDi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2015 11:03:38 -0500
In-Reply-To: <20150209150245.GC21362@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: tony@atomide.com, pali.rohar@gmail.com, pavel@ucw.cz, linux-omap@vger.kernel.org, devicetree@vger.kernel.org



On  9.02.2015 17:02, Nishanth Menon wrote:
> On 17:48-20150208, Ivaylo Dimitrov wrote:
>> With legacy boot i2c buses on Nokia N900 are numbered i2c1, i2c2 and i2c3.
>> Commit 20b80942ef4e ("ARM: dts: OMAP3+: Add i2c aliases") fixed the
>> numbering with DT boot, but introduced a regression on N900 - aliases
>> become i2c0, i2c1 and i2c2. Fix that by providing the correct aliases in
>> the board dts.
>>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>> ---
> I suppose this is due to some legacy userspace breakage?
> if yes, we do not intend to break userspace :), So:

Yes, legacy userspace breakage :)

Regards,
Ivo
