From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v8 0/8] Consolidate cpuidle functionality
Date: Tue, 20 Mar 2012 22:23:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1203202146131.24151@xanadu.home>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org> <201203202158.08042.arnd.bergmann@linaro.org> <873992zy5u.fsf@ti.com> <CAP245DXwhCMOJaspW8SY7jtqsA3d5SK4Ctr+JvS+cw4yHfL-mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1729038486-1332296636=:24151"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP245DXwhCMOJaspW8SY7jtqsA3d5SK4Ctr+JvS+cw4yHfL-mw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Robert Lee <rob.lee@linaro.org>, len.brown@intel.com, Andrew Morton <akpm@linux-foundation.org>, rjw@sisk.pl, robherring2@gmail.com, Baohua.Song@csr.com, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.ke
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1729038486-1332296636=:24151
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 21 Mar 2012, Amit Kucheria wrote:

> On Wed, Mar 21, 2012 at 12:48 AM, Kevin Hilman <khilman@ti.com> wrote:
> > Maybe it's time that drivers/cpuidle gets a maintainer.  With lots of
> > discussions of scheduler changes that affect load estimation, I suspect
> > we're all going to have a bit of CPUidle work to do in the
> > not-so-distant future.
> >
> 
> I don't mean to be piling on to Len here, but Daniel Lezcano too has a
> bunch of clean ups that didn't get any maintainer review for over two
> months. He has now refreshed them for 3.3 and is getting ready to send
> them out again. We (Linaro) expect to be spending a lot of time on
> cpuidle in the future and would be glad to help review, test and
> collect patches into a tree for Linus/Andrew to pull while we wait for
> Len to respond or another maintainer to emerge.

As I advised recently, it is usually a good idea for the person/group 
who is working the most on a subsystem to simply take the lead and 
become the new maintainer.  Waiting for another maintainer to emerge 
could be compared to cowardice.


Nicolas
--8323328-1729038486-1332296636=:24151--
