From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH v2] Input: ads7846: add regulator support
Date: Tue, 20 Apr 2010 09:31:54 -0700
Message-ID: <p2j5e088bd91004200931ucbf1eedvc710bebf8236dc1a@mail.gmail.com>
References: <1266078714-18155-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63608 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab0DTQb4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 12:31:56 -0400
Received: by vws5 with SMTP id 5so3081887vws.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Apr 2010 09:31:55 -0700 (PDT)
In-Reply-To: <1266078714-18155-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org

On Sat, Feb 13, 2010 at 9:31 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> The ADS7846/TSC2046 touchscreen controllers can (and usually are)
> connected to various regulators for power, so add regulator support.
>
> Valid regulator will now be required, so boards without complete
> regulator setup should either disable regulator framework or enable
> CONFIG_REGULATOR_DUMMY.

I'd prefer not to completely disable the regulator framework and my
2.6.33 kernel tree doesn't seem to have the CONFIG_REGULATOR_DUMMY
option.

Is there a simple way to handle the case (as exists with the Gumstix
Overo) where the ADS7846 is supplied by a fixed regulator with no
software controls?

Steve
