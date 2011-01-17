From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4] ARM: Thumb-2: Symbol manipulation macros for
	function body copying
Date: Mon, 17 Jan 2011 16:01:36 +0000
Message-ID: <20110117160136.GA25829@n2100.arm.linux.org.uk>
References: <1295039877-7976-1-git-send-email-dave.martin@linaro.org> <AANLkTintFe4V6BxrUxh-gwvhoa=RcH0tkHjYbfyGHKD=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58852 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab1AQQBt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 11:01:49 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTintFe4V6BxrUxh-gwvhoa=RcH0tkHjYbfyGHKD=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, Jan 17, 2011 at 03:02:20PM +0100, Jean Pihet wrote:
> On Fri, Jan 14, 2011 at 10:17 PM, Dave Martin <dave.martin@linaro.org=
> wrote:
> > + * These macros are intended for use when there is a need to copy =
a low-level
> > + * function body into special memory.
> > + *
> > + * For example, when reconfiguring the SDRAM controller, the code =
doing the
> > + * reconfiguration may need to run from SRAM.
> > + *
> > + * NOTE: that the copied function body must be entirely self-conta=
ined and
> > + * position-independent in order for this to work properly.
> > + *
> > + * NOTE: in order for embedded literals and data to get referenced=
 correctly,
> > + * the alignment of functions must be preserved when copying. =A0T=
o ensure this,
> > + * the source and destination addresses for fncpy() must be aligne=
d to a
> > + * multiple of 8 bytes: you will be get a BUG() if this condition =
is not met.
> > + * You will typically need a ".align 3" directive in the assembler=
 where the
> > + * function to be copied is defined, and ensure that your allocato=
r for the
> > + * destination buffer returns 8-byte-aligned pointers.
>=20
> Note that aligning the source and destination pointers to a multiple
> of 8 bytes has an impact on the behavio(u)r and so must be carefully
> thought and tested on OMAP1/2/3 platforms.

OMAP3 is ARMv7, so is EABI.  EABI requires 64-bit data to be aligned to
natural 64-bit boundaries, so architecturally it's correct.

Nevertheless, the code may not be using 64-bit data, so that doesn't
apply - but fncpy() can't know that.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
