From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: add get_user() support for 8 byte types
Date: Tue, 13 Nov 2012 09:11:09 +0000
Message-ID: <201211130911.09613.arnd@arndb.de>
References: <1352495853-9790-1-git-send-email-rob.clark@linaro.org> <20121112235348.GD28341@n2100.arm.linux.org.uk> <CAF6AEGvoXR3YJomjV1YOeNvjr46aYJ2mVxS+jZfH+41+v1nAvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAF6AEGvoXR3YJomjV1YOeNvjr46aYJ2mVxS+jZfH+41+v1nAvw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 13 November 2012, Rob Clark wrote:
> right, that is what I was worried about..  but what about something
> along the lines of:
> 
>                 case 8: {                                               \
>                         if (sizeof(x) < 8)                              \
>                                 __get_user_x(__r2, __p, __e, __l, 4);   \
>                         else                                            \
>                                 __get_user_x(__r2, __p, __e, __l, 8);   \
>                         break;                                          \
>                 }                                                       \

I guess that's still broken if x is 8 or 16 bits wide.

> maybe we need a special variant of __get_user_8() instead to get the
> right 32bits on big vs little endian systems, but I think something
> roughly along these lines could work.
> 
> Or maybe in sizeof(x)<8 case, we just __get_user_bad()..  I'm not 100%
> sure on whether this is supposed to be treated as an error case at
> compile time or not.

We know that nobody is using that at the moment, so we could define
it to be a compile-time error.

But I still think this is a pointless exercise, a number of people have
concluded independently that it's not worth trying to come up with a
solution, whether one exists or not. Why can't you just use copy_from_user()
anyway?

	Arnd
