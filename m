From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v3 2/4] OMAP4: hwmod data: add mmu hwmod for ipu and dsp
Date: Tue, 8 Nov 2011 10:21:08 -0600
Message-ID: <CAB-zwWgd5U+8UNFe_rLY99VpiaHhTqscwYNF+SmuRTyDi+h3+A@mail.gmail.com>
References: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
	<1320185752-568-3-git-send-email-omar.ramirez@ti.com>
	<87sjm31ngz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sjm31ngz.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ohad Ben-Cohen <ohad@wizery.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, lm <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Nov 4, 2011 at 6:23 PM, Kevin Hilman <khilman@ti.com> wrote:
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET,
>
> Why is this needed?
=2E..
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET,
>
> And this?

I have this because the hwmod complains about a failure in hard reset,
even though the reset deassert does complete after the clock is
enabled. Later on, hwmod will warn again because of a wrong state when
enabling, I believe because of the failure on _setup but didn't dig
into it yet.

Regards,

Omar
