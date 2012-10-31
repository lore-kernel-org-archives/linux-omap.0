From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [RFC 0/7] Capebus; a bus for SoCs using simple expansion connectors
Date: Wed, 31 Oct 2012 14:56:20 -0700
Message-ID: <CA+Bv8XZEpw=811-EMCMFKgZ7z03=U-KxaXBh4oMphdzwO18f8Q@mail.gmail.com>
References: <1351702333-8456-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351702333-8456-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 31, 2012 at 9:52 AM, Pantelis Antoniou
<panto@antoniou-consulting.com> wrote:
> Capebus is created to address the problem of many SoCs that can provide a
> multitude of hardware interfaces but in order to keep costs down the main
> boards only support a limited number of them. The rest are typically brought
> out to pin connectors on to which other boards, named capes are connected and
> allow those peripherals to be used.
>
> These capes connect to the SoC interfaces but might also contain various other
> parts that may need some kind of driver to work.
>
> Since SoCs have limited pins and pin muxing options, not all capes can work
> together so some kind of resource tracking (at least for the pins in use) is
> required.
>
> Before capebus all of this took place in the board support file, and frankly
> for boards with too many capes it was becoming unmanageable.
>
> Capebus provides a virtual bus, which along with a board specific controller,
> cape drivers can be written using the standard Linux device model.
>
> The core capebus infrastructure is not depended on any specific board.
> However capebus needs a board controller to provide services to the cape devices
> it controls. Services like addressing and resource reservation are provided
> by the board controller.
>
> Capebus at the moment only support TI's Beaglebone platform.
>
> This RFC introduces the core concept; most supporting patches
> have been posted to the relevant places.

There are quite a few TODOs in the code, any chance you could
summarize them in the next header email?
