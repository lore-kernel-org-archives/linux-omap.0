From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 0/2] OMAP3+/4+ PRM: fix of_irq_get() result checks
Date: Mon, 7 Aug 2017 20:04:41 +0300
Message-ID: <8deff01d-2e0c-d511-0557-7712c0358dcc@cogentembedded.com>
References: <20170806151420.104225294@cogentembedded.com>
 <CAHp75VfdGkac6PUMSJLydR9GcZ8UAmqRR6zq2xNhYL8mMe3iUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75VfdGkac6PUMSJLydR9GcZ8UAmqRR6zq2xNhYL8mMe3iUg@mail.gmail.com>
Content-Language: en-MW
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@codeaurora.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 08/06/2017 09:57 PM, Andy Shevchenko wrote:

>> Here's the set of 2 patches against the 'omap-for-v4.13/fixes' branch of Tony
>> Lingren's 'linux-omap.git' repo.  I'm  fixing of_irq_get() DT API result
>> checks.
>>
>> [1/2] ARM: OMAP3+: PRM: fix of_irq_get() result check
>> [2/2] ARM: OMAP4+: PRM: fix of_irq_get() result checks
> 
> What IRQ domain did you consider? In case of STRICT the mapping will
> be 1:1 and 0 is _valid_ IRQ number for hwirq.

    of_irq_get() returns virtual IRQ #'s, no? And for those 0 is considered 
non-valid by Linus (I personally don't agree with that).

> 0 in Linux kernel IRQ numbering often means NO_IRQ.

    NO_IRQ was "considered harmful" AFAIK. :-)

> But there might be exceptions.

> So, it would be nice to see if there is a problem on certain platform
> if the patch is not applied, or is it problem on OF IRQ code, or
> wrong interpratation of 0?

    of_irq_get() is certainly problematic with its returning both 0 and 
negative error # on failure. I tried to fix that back in 2016 but that patch 
got shot down:

http://marc.info/?t=146447243300002&r=1

    I've now audited all the call sites of of_irq_get() and that resulted in a 
number of fixes.

MBR, Sergei
