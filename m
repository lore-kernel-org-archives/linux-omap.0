From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: patch: add omap730 / omap850 rtc support
Date: Wed, 14 Oct 2009 15:22:33 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF6EE@dbde02.ent.ti.com>
References: <3ea34a000910130433i36a3ac7esc6b8e7c6588185f4@mail.gmail.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF600@dbde02.ent.ti.com>
 <3ea34a000910140126p3352a5aej50300a39521f1128@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48961 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932248AbZJNJxO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 05:53:14 -0400
In-Reply-To: <3ea34a000910140126p3352a5aej50300a39521f1128@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christopher Friedt <chrisfriedt@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> On Wed, Oct 14, 2009 at 9:11 AM, G, Manjunath Kondaiah 
> <manjugk@ti.com> wrote:
> 
> > Any advantage of using both enum and register offsets?
> > You can have only register offset macros instead of enum.
> 
> This was the appproach proposed by Tony in response to Alistair's
> original query. Tony originally cited something from Russel for the
> reason.
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg14918.html
> 
> If static #define's were used, then it would probably be impossible to
> support multiple omap1 cpu's with the same binary driver / binary
> kernel. Having a run-time cpu check (referencing static offset arrays)
> makes this possible and in the worst case scenario, it adds ~20 bytes.
> I guess if you really wanted to save those 20 bytes, then you could
> check #ifdef OMAP1_MULTI or something like that.
> 

You can acheive the same using only enum with following:

#define OMAP_RTC_REGISTER_SIZE (cpu_is_omap7xx()?1:4)
#define rtc_read(reg)
	omap_readb(OMAP_RTC_BASE + (reg * OMAP_RTC_REGISTER_SIZE))

#define rtc_write(val, reg)	
	omap_writeb(val, OMAP_RTC_BASE + (reg * OMAP_RTC_REGISTER_SIZE))

Russel point is different compared to your scenario. 

> > Why 50? Count can be decreased from 50 to 30/35 which will 
> increase rtc performance.
> 
> No idea, I didn't write the driver, I just patched it, and that is
> completely irrelevent to my patch, but feel free to test 30/35 and
> submit the changes back :)
>
 
This should be tested and optimized before pushing upstream.

