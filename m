From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 12/15] OMAP4: powerdomain data: add wake-up latency figures
Date: Tue, 16 Aug 2011 19:56:45 +0530
Message-ID: <4E4A7E25.8020701@ti.com>
References: <1313502198-9298-1-git-send-email-j-pihet@ti.com> <1313502198-9298-13-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:46408 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752155Ab1HPO0y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Aug 2011 10:26:54 -0400
Received: by mail-yx0-f172.google.com with SMTP id 4so5242567yxp.17
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 07:26:53 -0700 (PDT)
In-Reply-To: <1313502198-9298-13-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Vishwanath BS <vishwanath.bs@ti.com>, Jean Pihet <j-pihet@ti.com>

On Tuesday 16 August 2011 07:13 PM, jean.pihet@newoldbits.com wrote:
> From: Vishwanath BS<vishwanath.bs@ti.com>
>
> This patch adds wake up latency numbers for OMAP4. Note that these are
> preliminary numbers and need to be relooked.
>
> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
>
> The INACTIVE state is added as unsupported.
>
In that case, don't add that support in first place. When INA support is
getting added, you can update these as well.
