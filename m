From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [RFC 1/1] drivers: i2c: omap: Add slave support
Date: Sun, 28 Aug 2016 01:38:16 +0200
Message-ID: <CAALWOA8mtMAszBv6rcXdMzE_mRrrh-wmn6ECMJ32z4cJcfcOjw@mail.gmail.com>
References: <20160525141119.14486-1-rk@ti.com> <20160525141119.14486-2-rk@ti.com>
 <20160825171430.GM2856@katana> <CAALWOA-XP+mfTcVPc1LZZofAaCK-KtKhFKKKHu2PyHWFrfir3A@mail.gmail.com>
 <20160827172211.GA1601@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160827172211.GA1601@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ravikumar Kattekola <rk@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 27 August 2016 at 19:22, Wolfram Sang <wsa@the-dreams.de> wrote:
> Uh, that sounds like bad HW...

Making a mess of I2C controllers seems to be a popular hobby among
chip designers :P

( I also really like how the RPi handles clock stretching... *cough* )

> While it surely is nice to have super detailed information, can you give
> this overloaded maintainer a few-line, high level summary of what is
> written there?

What's written there is what should have been in the docs: correct (as
in reality-matching) details of how the thing actually works in slave
mode, and how to operate it without risking race conditions. They're
not comprehensive, and certainly not polished since they are my
personal notes I've made while studying the peripheral in detail, but
I figured both on E2E and here I might perhaps save time and
frustration by making them available.

A lot of the details (including the completely bizarre behaviour of
its innocuous-looking irq registers) would be quite non-trivial to
figure out without putting in a similar effort.

Matthijs
