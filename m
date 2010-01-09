From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] [I2C-OMAP] Add support for 16-bit registers
Date: Sat, 9 Jan 2010 09:47:29 -0800
Message-ID: <6cb013311001090947m2268833cv3784f469dc8b861d@mail.gmail.com>
References: <1260669242-29865-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260669242-29865-1-git-send-email-darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Dec 12, 2009 at 5:54 PM, Cory Maccarrone <darkstar6262-Re5JQEeQqe8@public.gmane.org=
m> wrote:
> The current i2c-omap driver is set up for 32-bit registers, which
> corresponds to most OMAP devices. =C2=A0However, OMAP730/850 based
> devices use a 16-bit register size.
>
> This change modifies the driver to perform a runtime CPU type check
> to determine the register sizes, and uses a bit shift of either 1
> or 2 bits to compute the proper register sizes for all registers.
>
> Signed-off-by: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Haven't heard anything recently on this one -- any chance of it
getting in for the next -rc merge window, or is this a change that'll
need to go in for the next release?  Without it, I2C doesn't work on
omap7xx devices.

Thanks
- Cory
