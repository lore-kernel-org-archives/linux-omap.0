From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 2/2] Input: misc: introduce palmas-pwrbutton
Date: Thu, 21 Aug 2014 12:09:38 -0500
Message-ID: <CAGo_u6rTnNxRhgOVkUHscB79qWZz3gVWRrM50Cu9ozO8RDsvZg@mail.gmail.com>
References: <1408392810-16011-1-git-send-email-nm@ti.com>
	<1408636935-29515-1-git-send-email-nm@ti.com>
	<1408636935-29515-3-git-send-email-nm@ti.com>
	<20140821170512.GA3796@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20140821170512.GA3796@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: dt list <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 21, 2014 at 12:05 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
>
> You can not use free_irq with devm-managed resources. As I mentioned, since you
> need manual unwinding, I'd rather you not use managed resources in the driver
> at all.
ok. will drop all devm_  ops in the next version.

---
Regards,
Nishanth Menon
