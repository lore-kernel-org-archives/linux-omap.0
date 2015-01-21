From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v7 1/4] Documentation: dt: add common bindings for hwspinlock
Date: Wed, 21 Jan 2015 14:41:00 +0200
Message-ID: <CAK=WgbZGGtwmQwzWumjpYOsYHTt8vPQpTraABwJBsv5VXOmJ_Q@mail.gmail.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
 <1421269101-51105-2-git-send-email-s-anna@ti.com> <20150115135201.GG16217@leverpostej>
 <20150115135556.GH16217@leverpostej> <CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>
 <CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
 <20150116101746.GA21809@leverpostej> <CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>
 <20150120180548.GK7718@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46099 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbbAUMlW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2015 07:41:22 -0500
Received: by mail-lb0-f174.google.com with SMTP id f15so246238lbj.5
        for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2015 04:41:20 -0800 (PST)
In-Reply-To: <20150120180548.GK7718@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robherring2@gmail.com>, Suman Anna <s-anna@ti.com>, Kumar Gala <galak@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, Josh Cartwright <joshc@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>

On Tue, Jan 20, 2015 at 8:05 PM, Tony Lindgren <tony@atomide.com> wrote:
> How about default to Linux id space and allow overriding that with
> a module param option if needed?

I'm not sure I'm following.

If the main point of contention is the base_id field, I'm also fine
with removing it entirely, as I'm not aware of any actual user for it
(Suman please confirm?).

Mark? Rob? Will you accept Suman's patches if the base_id field is removed?

Thanks,
Ohad.
