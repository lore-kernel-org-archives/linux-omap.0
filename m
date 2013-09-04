From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Wed, 4 Sep 2013 08:01:32 -0700
Message-ID: <CAGa+x85D2tnX_9QDNb6s1LQCpAz_kGUiOK82C7fPLVTmiZMEFg@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<5211E3F6.6090108@ti.com>
	<52125A39.3010008@ti.com>
	<87vc2qyjao.fsf@linaro.org>
	<521FBD6B.3020208@ti.com>
	<87mwo0rvf8.fsf@linaro.org>
	<CA+Bv8Xamd7e24nswG4QhLDNhHXs92EfXcfu8E2uL=XLhsL70Hw@mail.gmail.com>
	<CAGa+x84okZ_j71=oOnK5c43T9L3gmsGcQjWSxZSchfzheA_2HQ@mail.gmail.com>
	<52261B34.60206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:46512 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934837Ab3IDPBe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Sep 2013 11:01:34 -0400
Received: by mail-we0-f179.google.com with SMTP id t58so415326wes.10
        for <linux-omap@vger.kernel.org>; Wed, 04 Sep 2013 08:01:32 -0700 (PDT)
In-Reply-To: <52261B34.60206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Russ Dill <Russ.Dill@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Gururaja Hebbar <gururaja.hebbar@ti.com>

Hi Dave,

> Thanks for taking the time to try this out, it does seem there are a few
> kinks with BeagleBone Black but we'll get those worked out.

I also just noticed that wake from RTC isn't working, but wake from
serial console does.  Does RTC wake work for you?  (I use rtcwake -m
mem -s4)

Kevin
