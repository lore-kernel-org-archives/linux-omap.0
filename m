From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Wed, 20 Feb 2019 10:51:16 +0100
Message-ID: <CACRpkdYiLDbb=D2biBtr1aWJc6ottUONWm5qPE6g6_Pbpg94QQ@mail.gmail.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com> <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
 <9c58bc48-90bf-8ac5-7fbd-0f6443e3fc5e@ti.com> <CACRpkdb4Q0efW5MaDmPTmewq-RFwXOTp15DCE1VpPf6g216iBw@mail.gmail.com>
 <5C65490E.6000800@ti.com> <86ef8asfap.wl-marc.zyngier@arm.com>
 <5C658CE4.5030307@ti.com> <5C658DD6.8080309@ti.com> <61cf956c-77d7-2316-65a4-de5896e5c082@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <61cf956c-77d7-2316-65a4-de5896e5c082@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, "Davis, Andrew" <afd@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, ext Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, David Lechner <david@lechnology.com>, "Nori, Sekhar" <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, nsaulnier@ti.com, jreeder@ti.com, Murali Karicheri <m-karicheri2@ti.com>, woods.technical@gmail.com, Linux-OMAP <linux-omap@vger.kernel.org>, linux-remoteproc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 15, 2019 at 2:00 AM Suman Anna <s-anna@ti.com> wrote:

> Mark, Linus,
>
> So, I hope it is clear from Roger's responses that above assertions do
> not hold true to this INTC, and so want to confirm that we are good with
> the current non-hierarchical design.

IIUC the 64 lines are latched onto 8 lines, but all 64 lines have
individual masking and ACKing bits and can all be used at the same
time, so yes that is cascading and then you should indeed use
the chained (or nested) IRQ handler.

Yours,
Linus Walleij
