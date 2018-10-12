From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 3/3] gpiolib: Show correct direction from the beginning
Date: Fri, 12 Oct 2018 08:03:09 +0200
Message-ID: <CACRpkdYkhm16i7BiUsr0iemS7EvZZoy3ZvfLL6FJtCxBvNrqjw@mail.gmail.com>
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
 <20181005065300.22882-3-ricardo.ribalda@gmail.com> <9746eba6-63f5-feaf-e63f-7e0ea7638942@ti.com>
 <CAPybu_1PuRqOx-Fsmba4XCcRsJA0A9tdob1R=8N72-699cxomw@mail.gmail.com> <8d180cc7-d7cb-66eb-001d-f2a5c371d179@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8d180cc7-d7cb-66eb-001d-f2a5c371d179@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, timur@kernel.org, Stephen Boyd <swboyd@chromium.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, jhugo@codeaurora.org, Linux-OMAP <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 12, 2018 at 7:59 AM Vignesh R <vigneshr@ti.com> wrote:
> On Thursday 11 October 2018 07:12 PM, Ricardo Ribalda Delgado wrote:
> > Hi Vignesh
> >
> > Ups, it does not look too good :S . Can you check if this change fixes it:
> >
>
> Below diff works for me. I no longer see crash and gpio-hog seems to be
> working. Thanks!

Ricardo can you send a patch with a Fixes: tag and Vignesh's
Tested-by/Reported-by?

Yours,
Linus Walleij
