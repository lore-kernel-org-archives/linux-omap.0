From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv6 1/5] Documentation: dt: add common bindings for hwspinlock
Date: Wed, 12 Nov 2014 17:14:22 +0200
Message-ID: <CAK=WgbZqj23J4M8n5FOkPdUOcyK3==TXgc3DfX=LKS6E8C+-Bg@mail.gmail.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com> <1410553499-55951-2-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:60063 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbaKLPOn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 10:14:43 -0500
Received: by mail-ig0-f178.google.com with SMTP id a13so3069110igq.17
        for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2014 07:14:43 -0800 (PST)
In-Reply-To: <1410553499-55951-2-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>

Hi Suman,

On Fri, Sep 12, 2014 at 11:24 PM, Suman Anna <s-anna@ti.com> wrote:
> This patch adds the generic common bindings used to represent
> a hwlock device and use/request locks in a device-tree build.
>
...
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  .../devicetree/bindings/hwlock/hwlock.txt          | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/hwlock.txt

Please ask a DT maintainer to ACK this - otherwise I can't send this to Linus.

Thanks,
Ohad.
