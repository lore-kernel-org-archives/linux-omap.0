From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [RFC v1 05/25] gpio: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
Date: Mon, 01 Jun 2015 21:48:53 +0800
Message-ID: <556C62C5.2040107@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>	<1432116013-25902-6-git-send-email-jiang.liu@linux.intel.com> <CACRpkdZfWK5H+gRD6inX31Ouq1XCvq7CneNDJV8x0iihXHzWjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZfWK5H+gRD6inX31Ouq1XCvq7CneNDJV8x0iihXHzWjw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Ray Jui <rjui@broadcom.com>, Alexandre Courbot <gnurou@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kern>
List-Id: linux-omap@vger.kernel.org

On 2015/6/1 20:45, Linus Walleij wrote:
> On Wed, May 20, 2015 at 11:59 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> 
>> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
>> already have a pointer to corresponding irq_desc.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Are there dependencies on this patch or can I just apply it
> directly to the GPIO tree?
Hi Linus,
	Thanks for review.
	There's a very long dependency list of this patch set,
so it would be safer to merge this patch set altogether through
the irq tree if that works:)
Thanks!
Gerry

> 
> Yours,
> Linus Walleij
> 
