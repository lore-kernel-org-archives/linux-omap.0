From: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] MFD: Add U300 AB3100 core support v1
Date: Thu, 28 May 2009 13:52:33 +0530
Message-ID: <5d5443650905280122ha5b14a7gfd668d7ae9b09eaf@mail.gmail.com>
References: <63386a3d0905140129s5fd0f32cxde1114489678f012@mail.gmail.com>
	 <4A0BF776.9030301@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A0BF776.9030301-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Mike,

On Thu, May 14, 2009 at 4:20 PM, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> wrote:
> Hi Linus,
> A few comments.
>
> Linus Walleij wrote:
>> This adds a core driver for the AB3100 mixed-signal circuit
>> found in the ST-Ericsson U300 series platforms. This driver
>> is a singleton proxy for all accesses to the AB3100
>> sub-drivers which will be merged on top of this one, RTC,
>> regulators, battery and system power control, vibrator,
>> LEDs, and an ALSA codec.
>
> As general note on the driver, you export register access methods so they can be
> called virtually anywhere.

This will apply to existing manilined driver twl4030-core driver too.
Adding David here.

read/write register APIs for twl4030-core driver is also exported
everywhere without per chip structure fed into it.

---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
