From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v6 4/7] ARM: l2c: Add support for overriding prefetch
 settings
Date: Tue, 28 Oct 2014 09:50:13 -0200
Message-ID: <CAOMZO5Ddp1=4K6qNmLxi-=TKmEFDm5B+7XRLkemrYMCPzZAjJw@mail.gmail.com>
References: <1414407950-3029-1-git-send-email-m.szyprowski@samsung.com>
 <1414407950-3029-5-git-send-email-m.szyprowski@samsung.com>
 <20141027111404.GW12379@n2100.arm.linux.org.uk>
 <544E2A46.7070106@samsung.com>
 <20141028113531.GZ12379@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141028113531.GZ12379@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, loeliger@gmail.com, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, drake@endlessm.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 28, 2014 at 9:35 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Ok.
>
> I'd ask for one change.  Please make all these messages start with
> "L2C-310 OF" not "PL310 OF:".  The device is described in ARM
> documentation as a L2C-310 not PL310.  (Also note the : is dropped
> too - most of the other messages don't have the : either.)
>
> The:
>
> "PL310 OF: cache setting yield illegal associativity
> PL310 OF: -1073346556 calculated, only 8 and 16 legal"

I have sent a patch to address this error message that happens when
"cache-size" and "cache-sets" properties are not passed in DT:
http://www.spinics.net/lists/arm-kernel/msg372094.html
