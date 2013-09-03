From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Tue, 3 Sep 2013 11:55:48 -0700
Message-ID: <CA+Bv8XakgQZoeB8OTWsq1uUTcPfuxcD1qP9wnhu4HK22FMxFNQ@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	<87txiasqhk.fsf@linaro.org>
	<CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
	<87ppsw7cgq.fsf@linaro.org>
	<CA+Bv8XbxV=BFjcSsUMX2pz9LeCkSwrjzZmj_=YbHGzyfbLXmaQ@mail.gmail.com>
	<874na8xqfl.fsf@linaro.org>
	<CANacCWzK1w9+XKEoUfS4ZB7QGxi_0JkVWBLs_wsaUjrzW2QB+A@mail.gmail.com>
	<87hae8tc6e.fsf@linaro.org>
	<CA+Bv8XaQgOiSiScQW=CVxzXBuG0soafQotApjoVEZ0P9U3netg@mail.gmail.com>
	<87eh9bqi1x.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:42083 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab3ICSzt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Sep 2013 14:55:49 -0400
In-Reply-To: <87eh9bqi1x.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: devicetree@vger.kernel.org, =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, Mark Brown <broonie@kernel.org>, Vaibhav Bedia <vaibhav.bedia@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Fri, Aug 30, 2013 at 9:06 AM, Kevin Hilman <khilman@linaro.org> wrote:
> Well, I was thinking of something much dumber.
>
> I was thinking about just _carefully_ writing a single, self-contained C
> function, with all of its data on the stack (and consts as #defines).
> Think of it is a step up in readability from straight assembly (which
> was the stated reason for moving the code to the M3 in the first place.)
>
> Kevin

That can only give you your suspend function. You need a resume
function to undo everything before calling cpu_resume, and the resume
function needs access to the data that was in the suspend function.
