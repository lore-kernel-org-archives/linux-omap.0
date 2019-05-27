From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] Running linux on qemu omap
Date: Mon, 27 May 2019 19:58:58 +0100
Message-ID: <CAFEAcA-n8-LV2=hQwQOvRDT+pro7iBQD8i-QBszWHuW56VQsvg@mail.gmail.com>
References: <20190520190533.GA28160@Red> <20190521232323.GD3621@darkstar.musicnaut.iki.fi>
 <20190522093341.GA32154@Red> <20190522181904.GE3621@darkstar.musicnaut.iki.fi>
 <8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com> <c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
 <20190527063250.GI5447@atomide.com> <5dbec436-4356-415e-eb1c-0f506af89744@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5dbec436-4356-415e-eb1c-0f506af89744@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Corentin Labbe <clabbe.montjoie@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 27 May 2019 at 16:56, Guenter Roeck <linux@roeck-us.net> wrote:
> I'd be happy to use a different (supported) branch, but the Linaro branch
> was the only one I could find that supports those boards. Unfortunately,
> qemu changed so much since 2.3 that it is all but impossible to merge
> the code into mainline qemu without spending a lot of effort on it.

Even back at 2.3 it wasn't possible to merge the code into mainline
without spending a lot of effort -- that's why it was not merged :-)

thanks
-- PMM
