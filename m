From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFT v2 45/48] genirq, gpio: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Thu, 4 Jun 2015 13:28:51 +0200
Message-ID: <CACRpkdafGYG3Bt+0Xe4z=5NOoaRK-c-ViOUvJ3P_9yeZg0tLLw@mail.gmail.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
	<1433391238-19471-46-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1433391238-19471-46-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Tien Hock Loh <thloh@altera.com>, Alexandre Courbot <gnurou@gmail.com>, Ray Jui <rjui@broadcom.com>, David Cohen <david.a.cohen@linux.intel.com>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 4, 2015 at 6:13 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:

> Now most IRQ flow handlers make no use of the first parameter 'irq'.
> And for those who do make use of 'irq', we could easily get the irq
> number through irq_desc->irq_data->irq. So kill the first parameter
> 'irq' of irq_flow_handler_t.
>
> To ease review, I have split the changes into several parts, though
> they should be merge as one to support bisecting.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
