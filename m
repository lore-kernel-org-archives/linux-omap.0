From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 12/15] OMAP4: powerdomain data: add wake-up latency figures
Date: Tue, 16 Aug 2011 16:38:42 +0200
Message-ID: <CAORVsuUtJ05AHrT0C3rUg_2iUH=NfKdWpqqzoEZms9pYXR6u6A@mail.gmail.com>
References: <1313502198-9298-1-git-send-email-j-pihet@ti.com>
	<1313502198-9298-13-git-send-email-j-pihet@ti.com>
	<4E4A7E25.8020701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61721 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab1HPOin (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 10:38:43 -0400
Received: by vws1 with SMTP id 1so4780114vws.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 07:38:42 -0700 (PDT)
In-Reply-To: <4E4A7E25.8020701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Vishwanath BS <vishwanath.bs@ti.com>, Jean Pihet <j-pihet@ti.com>

On Tue, Aug 16, 2011 at 4:26 PM, Santosh <santosh.shilimkar@ti.com> wrote:
> On Tuesday 16 August 2011 07:13 PM, jean.pihet@newoldbits.com wrote:
>>
>> From: Vishwanath BS<vishwanath.bs@ti.com>
>>
>> This patch adds wake up latency numbers for OMAP4. Note that these are
>> preliminary numbers and need to be relooked.
>>
>> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
>>
>> The INACTIVE state is added as unsupported.
>>
> In that case, don't add that support in first place. When INA support is
> getting added, you can update these as well.
No. A value is needed for all states, even if unsupported at the
moment. Omitting a value causes it to be set to '0', which means 'no
latency'.

Jean
